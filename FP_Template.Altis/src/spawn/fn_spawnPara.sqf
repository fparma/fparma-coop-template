/*
///////////////////////////
	ARMA 3 Group spawning script
	Version: 0.1
	Author: Cuel
	Created: 2013-10-13
	Purpose: Spawns a at specified location, fills it with units, heli goes to the drop point. The group ejects and the heli returns to the spawn pos.
	@param {String} - TEAM
	@param {Location|Object|Marker} - Spawning position of the helicopter
	@param {Location|Object|Marker} - Position to drop
	@param {Integer} - Amount of units to paradrop. Can not be more than available cargo positions.
	@param {Location|Object|Marker} Optional. Should group patrol ? - what location
	Example: ["CSAT",position player, position cursorTarget,8,"marker1"] call FP_fnc_spawnPara;
	Returns: Created paratroop group
///////////////////////////
*/

if (!isServer) exitWith {};
private ["_side","_spawnPos","_dropPos","_amount","_patrol","_type","_veh","_grp","_tmp"];

_side = [_this,0,"CSAT",[""]] call BIS_fnc_param;
_spawnPos = ([_this,1,[0,0,0]] call BIS_fnc_param) call CBA_fnc_getPos;
_dropPos = ([_this,2,[0,0,0]] call BIS_fnc_param) call CBA_fnc_getPos;
_amount = [_this,3,4,[0]] call BIS_fnc_param;
_patrol = ([_this,4,[0,0,0]] call BIS_fnc_param) call CBA_fnc_getPos;

if (count (_spawnPos - [0]) == 0 || count (_dropPos - [0]) == 0) exitWith {["fn_spawnPara: Received incorrect positions. (%1) , (%2)",_spawnPos,_dropPos] call BIS_fnc_error};

_type = [_side,true] call FP_fnc_getUnits;
if (_type == "") exitWith {
	["fn_spawnPara: Team does not have a transport helicopter specified. (%1) , (%2)",_side] call BIS_fnc_error;
};

_veh = createVehicle [_type,_spawnPos,[], 0, "FLY"];
createVehicleCrew _veh;

_veh setPosATL [getPosATL _veh select 0, getPosATL _veh select 1, 250];
_veh addEventHandler ["Killed",{[_this select 0] call FP_fnc_addTrash}];
{
	_x addEventHandler ["Killed",{[_this select 0] call FP_fnc_addTrash}];
}forEach (crew _veh);

if (!isNil "FP_addCuratorObject") then {
	_veh call FP_addCuratorObject;
};

_veh addEventHandler ["handleDamage",{
	_veh = _this select 0;
	_damage = _this select 2;
	_source = _this select 3;
	if (!isPlayer _source) then {
		_damage = ((damage _veh) +0.03);
	};
	_damage
}];

_grp = [_side,[5,5,0],_amount] call FP_fnc_spawnGroup;

if (count units _grp > _veh emptyPositions "cargo") then {
	["fn_spawnPara: Tried to fit more units (%1) than free slots in vehicle cargo (%2). Deleting a few units...",_amount,_veh emptyPositions "cargo"] call BIS_fnc_error;
	while {(count units _grp > _veh emptyPositions "cargo")} do {
		deleteVehicle (units _grp select (count units _grp -1));
	};
};
 // store the info on the helictoper 
 // using setwaypointstatements is the best to know when the heli has reached the WP
_veh setVariable ["fp_dropInfo",[_grp,_spawnPos,_dropPos,_patrol]];

[_veh,_grp,_dropPos] spawn {
	private ["_veh","_vehgrp","_grp","_spawnPos","_dropPos","_dropWp","_temp","_finishWp"];
	_veh = _this select 0;
	_grp = _this select 1;
	_vehgrp = (group (driver _veh));
	_dropPos = _this select 2;
	sleep 0.5;
	_vehgrp setBehaviour "CARELESS";
	_vehgrp setSpeedMode "FULL";
	_dropWp = _vehgrp addWaypoint [_dropPos,30];
	_dropWp setwaypointtype "MOVE";
	_dropWp setWaypointStatements ["", "[this] spawn FP_fnc_dropPara"];
	_veh flyInHeight 300;
	[_veh,_dropPos,_grp] spawn {
		_veh = _this select 0;
		_wp = _this select 1;
		_grp = _this select 2;
		// eject the crew if helicopter dies
		waitUntil {sleep 2;  !alive _veh || !alive (driver _veh) || !canMove _veh};
		if (alive _veh && [getPosATL _veh select 0, getPosATL _veh select 1,0] distance [_wp select 0,_wp select 1,0] < 600) then {
			[(leader _grp)] spawn FP_fnc_dropPara;
			waitUntil {sleep 0.5; isTouchingGround _veh || !alive _veh};
			_veh setDamage 1;
		};
	};
	{
		removeBackpack  _x;
		sleep 0.1; 
		_x assignAsCargo _veh;
		sleep 0.1; 
		_x moveInCargo _veh;
	} forEach (units _grp);
};
_grp