/*
	ARMA3 Civilian script
	Author:Cuel:
	Date: 2014-02-29
	Version: 0.8
	Purpose:
		Make civilians in towns with houses that have house positions. They walk around and interact.
		Only runs on clients.
*/

if (isServer) then {
	_center = createCenter sideLogic;
	_group = createGroup _center;
	CUL_CIV_LOGIC = _group createUnit ["LOGIC",[0,0,0] , [], 0, ""];
	publicVariable "CUL_CIV_LOGIC";

	CUL_civ_onPlayerDisconnect = {
		private "_arr";
		_arr = [];
		{
			private "_temp";
			_temp = _x getVariable ["cul_controller",[]];
			if (count _temp > 0) then {
				_plr = _temp select 0;
				if (isNull _plr) then {
					_arr set [count _arr,_x];
				};
			};
		}foreach allUnits;
		if (count _arr > 0) then {
			_arr spawn
			{
				while {count _this > 0} do {
					for "_i" from 0 to (count _this)-1 do {
						if (!([_x, 150] call CBA_fnc_nearPlayers)) then {
							deleteVehicle (_this select _i);
							if (!isNil "CUL_CIV_LOGIC") then {
								CUL_CIV_LOGIC setVariable ["CUL_civ_amount", abs((CUL_CIV_LOGIC getVariable ["CUL_civ_amount",0])-1),true]
							};
							_this = _this - [objNull];
						};
						sleep 1;
					};
					sleep 10;
				};
			};
		};
	};
	["CUL_civ_onPlayerDisconnectEventHandler","onPlayerDisconnected","CUL_civ_onPlayerDisconnect"] call BIS_fnc_addStackedEventHandler;
};

if (isServer && isMultiplayer) exitWith{};
#include "civ_config.sqf";
#define _increaseCiviliansByOne				(CUL_CIV_LOGIC setVariable ["CUL_civ_amount", (CUL_CIV_LOGIC getVariable ["CUL_civ_amount",0])+1,true])
#define _decreaseCiviliansByOne			(CUL_CIV_LOGIC setVariable ["CUL_civ_amount", abs((CUL_CIV_LOGIC getVariable ["CUL_civ_amount",1])-1),true])
#define _amountCiviliansInMission			(CUL_CIV_LOGIC getVariable ["CUL_civ_amount",0])
#define _isPositionExcludedLocation(cpos) 	({[_x,cpos] call BIS_fnc_inTrigger} count _excludedTriggerAreas > 0)
private "_currentPlayerCivilians";
_currentPlayerCivilians = [];

if (_aliveCivDeleteDistance < _playersTooCloseDistance || _searchHousesDistance < _playersTooCloseDistance) exitWith{
	sleep 1;
	["civ_main.sqf: Faulty parameters given in civ_config.sqf. Alive civilian deletion OR search houses distance cannot be lower than player too close distance"] call BIS_fnc_error;
};

if (!isMultiplayer) then {
	_maximumCiviliansPerPlayer = _maximumCiviliansOverall;
};

/*
@method getHousePositions
@param {Object}
	- House object
@return {Integer}
	- Amount of house positions
*/
_getHousePositions = {
	private ["_i","_house"];
	_i = 0;
	_house = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	if (isNull _house) exitWith {_i};
	while {count ((_house buildingPos _i) - [0]) > 0}do{
		_i = _i+1;
	};
	_i
};

/*
@method isPlayersNear
@param {Location}
	- Location to search from
@param {Integer}
	- Max distance for a player to be considered close
@return {Boolean}
	- True if player is close
*/
_isPlayersNear = {
	private ["_pos","_dist","_ret"];
	_ret = false;
	_pos = ([_this,0] call BIS_fnc_param) call BIS_fnc_position;
	_dist = [_this,1,50,[0]] call BIS_fnc_param;
	if (_pos distance [0,0,0] < 2) exitWith {true};
	_arr = if (isMultiplayer) then {playableUnits}else{[player]};
	{
		if (_x distance _pos <  _dist) exitWith {_ret = true};
	}foreach _arr;
	_ret
};

/*
@method randPos
@param {Position | Object}
	- Starting position to search from
@param {Int}
	- Distance to search
@param {Boolean}
	- True: Only return position on a road 50m from the randpos
@return {Position OR Empty array}
*/
_randPos = {
	private ["_startpos","_dist","_searchRoad","_pos","_ret"];
	_ret = [];
	_startpos = ([_this,0] call BIS_fnc_param) call BIS_fnc_position;
	if (_startpos distance [0,0,0] < 2) exitWith {_ret};
	_dist = [_this,1,50,[0]] call BIS_fnc_param;
	_searchRoad = [_this,2,false,[false]] call BIS_fnc_param;
	scopeName "main";
	for "_i" from 0 to 10 do {
		_pos = [
			(_startpos select 0)+ (_dist* (sin random 359)),
			(_startpos select 1)+ (_dist* (cos random 359)),
			0
		];
		if (!surfaceIsWater _pos && !_searchRoad) then {
			_ret = _pos;
		};
		if (_searchRoad) then {
			_pos = (_pos nearRoads 50);
			if (count _pos > 0) then {
				_ret = getPosATL (_pos call BIS_fnc_selectRandom);
			};
		};
		if (count _ret > 0) then {
			if (!_isPositionExcludedLocation(_ret)) exitWith {breakTo "main"};
		};
	};
	_ret
};

/*
@method createCivilian
	Creates a civilian and ensures he does not die during spawn
@param {Location}
	- Location to be spawned
@return {Object}
	-Created unit or null if fail
*/
_createCivilian = {
	private ["_grp","_unit","_pos"];
	_pos = ([_this,0] call BIS_fnc_param) call BIS_fnc_position;
	if (_pos distance [0,0,0] < 2) exitWith {objNull};
	_grp = createGroup CIVILIAN;
	_unit = _grp createUnit [_allCivilians call BIS_fnc_selectRandom,[0,0,0],[],0,"CAN_COLLIDE"];
	sleep .1;
	_unit setPosATL _pos;
	sleep .5;
	if (!isTouchingGround _unit) then {
		_unit setPosATL (getPosATL _unit findEmptyPosition [0,10,typeof _unit]);
	};
	if (alive _unit) then {
		_increaseCiviliansByOne;
		[_unit] call _civInitCode;
		// variable to server to cleanup if player disconnect
		_unit setVariable ["cul_controller",[player],true];
	}else{
		deleteVehicle _unit;
	};
	_unit
};

/*
@method getGoodHouse
@return {Object}
	- Good house to spawn civilian inside
*/
_getGoodHouse = {
	private ["_houses","_possibleHouses","_ret","_pos"];
	_ret = objNull;
	_possibleHouses = [];
	_houses = player nearObjects ["House", _searchHousesDistance];
	{
		if (isNull (_x getVariable ["cul_owner",objNull])) then {
			if (!(typeOf _x in _houseBlacklist)) then {
				if (!([_x,_playersTooCloseDistance] call _isPlayersNear)) then {
					if (_x call _getHousePositions > 2) then {
						if (count (_x nearObjects ["Man",_otherCiviliansTooCloseDistance]) == 0) then {
							_pos = getPosATL _x;
							if (!_isPositionExcludedLocation(_pos)) then {
								_possibleHouses set [count _possibleHouses, _x];
							};
						};
					};
				};
			};
		};
		sleep 0.01;
	}foreach _houses;
	if (count _possibleHouses > 0) then {
		_ret = _possibleHouses call BIS_fnc_selectRandom;
	};
	_ret
};

_cleanUp = {
	private ["_dist","_grp"];
	{
		_dist = if (alive _x) then {_aliveCivDeleteDistance}else{_deadCivDeleteDistance};
		if (!([_x,_dist] call _isPlayersNear)) then {
			_grp = group _x;
			private "_house";
			_house = _x getVariable ["cul_house",objNull];
			if (!isNull _house) then {
				_house setVariable ["cul_owner",objNull,true];
			};
			deleteVehicle _x;
			_decreaseCiviliansByOne;
			sleep 0.1;
			if (count units _grp == 0) then {
				deleteGroup _grp;
			};
		};
	}foreach _currentPlayerCivilians;
	_currentPlayerCivilians = _currentPlayerCivilians - [objNull];
};

/*
@method civilianAction
@param {Object}
	 - Civilian unit
 */
_civilianAction = {
	private "_unit";
	_unit = [_this,0,objNull,[objNull]]call BIS_fnc_param;
	if ((_unit getVariable ["cul_currentCivAction",""]) != "") exitWith {};
	private "_action";
	_action = ["STROLL","INTERACT"] call BIS_fnc_selectRandom;

	switch (_action) do
	{
		case "STROLL": {
			private "_wp";
			for "_i" from 0 to (1+(round random 2)) do {
				private ["_pos","_onRoad"];
				_onRoad = if (random 1 < 0.3) then {true}else {false};
				_pos = [_unit,100,_onRoad] call _randPos;

				if (count _pos > 0) then {
					_wp = (group _unit) addWaypoint [_pos,_i];
					_wp setWaypointType "MOVE";
					_wp setWaypointSpeed "LIMITED";
					_wp setWaypointTimeout [5,10,15];
				};
			};
			// Last waypoint is back home
			_wp = (group _unit) addWaypoint [(getPosATL (_unit getVariable ["cul_house", getPosATL _unit])), count waypoints _unit];
			_wp setWaypointStatements ["true","this setVariable ['cul_currentCivAction','']"];
		};
		case "INTERACT": {
			private ["_closest","_dist"];
			_closest = objNull;
			_dist = 200;
			{
				if (_x != _unit && _x distance _unit < _dist && _x distance _unit > 15) then {
					if (_x getVariable ["cul_currentCivAction",""] != _action) then {
						_closest = _x;
					};
				};
			} foreach _currentPlayerCivilians;
			if (!isNull _closest) then {
				_closest setVariable ["cul_currentCivAction",_action];
				while {count waypoints group _closest > 0} do {
					deleteWaypoint ((waypoints group _closest) select 0);
				};
				doStop _closest;
				// if unit is on second floor move him out of the house
				if ((getPosATL _closest) select 2 > 1) then {
					private "_pos";
					_pos = getPosATL _closest findEmptyPosition [1, 30,typeof _closest];
					_closest doMove _pos;
				};

				[_unit,_closest] spawn {
					_unit = (_this select 0);
					_closest = (_this select 1);
					waitUntil {
						sleep 1;
						({moveToCompleted _x || moveToFailed _x}count [_unit,_closest]) == 0;
					};
					_timeout = 200;
					_startTime = time;
					_unit doMove getPosATL _closest;
					_unit lookAt _closest;
					_closest lookAt _unit;
					waitUntil {
						sleep 3;
						(!alive _unit
						||
						!alive _closest
						||
						time > (_startTime + _timeout))
						||
						{((_unit distance _closest) < 4 && !lineIntersects [eyepos _unit,eyepos _closest])}
					};

					if (alive _unit && alive _closest && time < (_startTime + _timeout)) then {

						{doStop _x} foreach [_unit,_closest];
						_unit lookAt _closest;
						_closest lookAt _unit;
						_dir = [_unit,_closest] call BIS_fnc_dirTo;
						_unit setDir _dir;
						_dir = [_closest,_unit] call BIS_fnc_dirTo;
						_closest setDir _dir;
						{_x disableAI "MOVE"} foreach [_unit,_closest];
						_anim1 = ['HubBriefing_think','HubBriefing_lookaround1','HubBriefing_lookaround2','HubBriefing_pointleft','HubBriefing_pointright','HubBriefing_scratch','HubBriefing_stretch'] call BIS_fnc_selectRandom;
						_anim2 = ['HubBriefing_think','HubBriefing_lookaround1','HubBriefing_lookaround2','HubBriefing_pointleft', 'HubBriefing_pointright','HubBriefing_scratch','HubBriefing_stretch'] call BIS_fnc_selectRandom;
						[
							[
								[_unit,_anim1,_closest,_anim2],
								{
									(_this select 0) switchMove (_this select 1);
									(_this select 2) switchMove (_this select 3);
									sleep 30;
									(_this select 0) switchMove "";
									(_this select 2) switchMove "";
								}
							],
							"BIS_fnc_spawn",
							true,
							false
						] call BIS_fnc_MP;
						sleep 30;
						// frees up the AI to make them do new actions
						{
							_x enableAI "MOVE";
							_x setVariable ["cul_currentCivAction",""];
							// enalbeai will not make the units follow new waypoints, fix:
							_x doMove [(getPosATL _x select 0)+1,(getPosATL _x select 1)+1,0];
						} foreach [_unit,_closest];
					};
				};
			}else{
				_action = "";
			};
		};
		/* NOT IMPLEMENTED.. ai cant drive for shit
		case "DRIVE_AROUND":
		{
			private "_pos";
			if (!([_unit,300] call _isPlayersNear)) then {
				_startpos = getPosATL _unit;
				_car = "C_Offroad_01_F";
				_moveWPs = [];
				for "_i" from 0 to 8 do {
					_pos = [_unit,400,true] call _randPos;
					if (count _pos > 0) then {
						_moveWPs set [count _moveWPs, _pos];
					};
				};
				_pos = getPosATL _unit findEmptyPosition [1, 30, _car];
				_pos = [_pos,50,true] call _randPos;
				if (count _pos > 0 && count _moveWPs > 2) then {

					_car = createVehicle ["C_Offroad_01_F",_pos,[],0,"CAN_COLLIDE"];
					[_car]  call _vehicleInitCode;
					sleep 1;
					if (alive _car) then {
						[_car] call _createDebugMarker;
						_unit assignAsDriver _car;
						[_unit] orderGetIn true;
						for "_i" from 0 to count _moveWPs -1 do {
							_wp = (group _unit) addWaypoint [_x,_i];
							_wp setWaypointType "MOVE";
							_wp setWaypointSpeed (if (random 1 > 0.8) then {"LIMITED"}else{"FULL"});
						};
					};
					_wp = (group _unit) addWaypoint [_startpos,count waypoints _unit];
					_wp setWaypointType "MOVE";
					_wp setWaypointStatements ["true","this setVariable ['cul_currentCivAction','']; unassignVehicle this; [this] orderGetIn false"];
					_unit setVariable ["cul_carOwner",_car];
				}else{
					_action = "";
				};
			}else{
				_action = "";
			};
		};*/
	};

	_unit setVariable ["cul_currentCivAction",_action];
};

// Main loop
waitUntil {!isNil "CUL_CIV_LOGIC"};
private ["_house","_unit","_housepos","_spawnpos"];
while {true} do
{
	if (alive player && (getPosATL player) select 2 < 20 && {speed vehicle player < 20}) then {

		if (_amountCiviliansInMission < _maximumCiviliansOverall && count _currentPlayerCivilians <  _maximumCiviliansPerPlayer) then {
			_house = call _getGoodHouse;
			// dead units are null and trying to getvariable on objnull wont work
			if (isNull (_house getVariable ["cul_owner",objNull])) then {

				_unit = [_house buildingPos (floor random (_house call _getHousePositions))] call _createCivilian;
				if (!isNull _unit) then {

					_house setVariable ["cul_owner",_unit,true];
					_unit setVariable ["cul_house",_house];
					if (_debug) then {
						[_house] call _createDebugMarker;
						[_unit] call _createDebugMarker;
						_debugCounter = _debugCounter +1;
					};
					_currentPlayerCivilians set [count _currentPlayerCivilians,_unit];
				};
			};
		};
	};

	{
		if (alive _x) then {
			[_x] call _civilianAction;
		};
		sleep 0.4;
	}foreach _currentPlayerCivilians;
	sleep (_civSpawnDelay/2);
	call _cleanUp;
	sleep (_civSpawnDelay/2);
};
