/*
///////////////////////////
	ARMA 3 Group defense script
	Version: 0.1
	Author: Cuel
	Created: 2013-10-13
	Purpose: Spawns a group at designated location with the specific amount.  Group will enter houses and static weapons
	Takes an array format ["TEAM",position,amount,radius,patrol (boolean)] call FP_spawnDefense;
	@param {String} - Team
	@param {Location | String | Object} - Location to spawn the group at
	@param {Int} - Amount of units
	@param {int} - Radius to patrol
	@param {Boolean} - Optional. Patrol the area or not. Default true
	Example: ["CSAT","myDefenseMarker",6,200,true] call FP_fnc_spawnDefense;
	@return {Group} -  Created group
///////////////////////////
*/

// 
// units man defenses and patrol area
if (!isServer) exitWith {};
private ["_grp", "_position","_radius","_patrol"];
_position = ([_this,1, "",[[], objNull, ""]] call BIS_fnc_param) call CBA_fnc_getPos;
if (_area distance [0,0,0] < 5) exitWith  {["spawnDefense: Incorrect parameters (%1)",_this] call BIS_fnc_error};

_group = _this call FP_fnc_spawnGroup;
_radius = [_this,3,100,[0]] call BIS_fnc_param;
_patrol = [_this,4,true,[true]] call BIS_fnc_param;
//[_grp,_area,_radius,2,_patrol] call CBA_fnc_taskDefend;

// patch for taskDefend, last parameter seems broken
_group enableattack false;

private ["_count", "_list", "_list2", "_units", "_i"];
_statics = [_position, vehicles, _radius, {(_x iskindof "StaticWeapon") && {(_x emptypositions "Gunner" > 0)}}] call CBA_fnc_getnearest;
_buildings = _position nearObjects ["building",_radius];
_units = units _group;
_count = count _units;
_threshold = 2;

{
	if (str(_x buildingpos _threshold) == "[0,0,0]") then {_buildings = _buildings - [_x]};
} foreach _buildings;

_i = 0;

{

	_cnt = (count _statics) - 1;
	if (random 1 < 0.31 && {_cnt > -1}) then {
		_x assignasgunner (_statics select _cnt);
		_statics resize _cnt;
		[_x] ordergetin true;
		_i = _i + 1;
	} else {
		if (random 1 < 0.93 && {count _buildings > 0}) then {
			private ["_building","_p","_array"];
			_building = _buildings call BIS_fnc_selectRandom;
			_array = _building getvariable "CBA_taskDefend_positions";
			if (isnil "_array") then {
				private "_k"; _k = 0;
				_building setvariable ["CBA_taskDefend_positions",[]];
				while {str(_building buildingpos _k) != "[0,0,0]"} do {
					_building setvariable ["CBA_taskDefend_positions",(_building getvariable "CBA_taskDefend_positions") + [_k]];
					_k = _k + 1;
				};
				_array = _building getvariable "CBA_taskDefend_positions";
			};
			if (count _array > 0) then {
				_p = (_building getvariable "CBA_taskDefend_positions") call BIS_fnc_selectRandom;
				_array = _array - [_p];
				if (count _array == 0) then {
					_buildings = _buildings - [_building];
					_building setvariable ["CBA_taskDefend_positions",nil];
				};
				_building setvariable ["CBA_taskDefend_positions",_array];
				[_x,_building buildingpos _p] spawn {
					if (surfaceIsWater (_this select 1)) exitwith {};
					(_this select 0) domove (_this select 1);
					sleep 5;
					waituntil {unitready (_this select 0)};
					(_this select 0) disableai "move";
					dostop _this;
					waituntil {not (unitready (_this select 0))};
					(_this select 0) enableai "move";
				};
				_i = _i + 1;
			};
		};
	};
} foreach _units;

{
	_x setvariable ["CBA_taskDefend_positions",nil];
} foreach _buildings;

if (!_patrol) then {_i = _count};

if (_i < _count * 0.5) then {

	[_group, _position, _radius, 5, "sad", "safe", "red", "limited"] call CBA_fnc_taskpatrol;
};
