/*
	Function: FP_fnc_spawnDefense

	Description:
		Spawns a group that will defend an area, mount statics, check buildings and optionally patrol around.

	Parameters:
		_team - Team defined in getUnits [String]
		_position - Main position to spawn on and defend [Any]
		_amount - Amount of units to spawn
		_radius - (Optional) Maximum distance for unit to defend and search [Default: 100]
		_patrol - (Optional) Group should patrol the area or not? [Default: true]

	Examples:
	(begin example)
		["CSAT","myDefenseMarker", 6, 200, true] call FP_fnc_spawnDefense;
	(end)

	Returns:
		Created group

	Author:
	Cuel 2015-01-18
*/

private ["_grp", "_position","_radius","_patrol"];
_position = ([_this,1, "",[[], objNull, ""]] call BIS_fnc_param) call CBA_fnc_getPos;
if (_position distance [0,0,0] < 5) exitWith  {["spawnDefense: Incorrect parameters (%1)",_this] call BIS_fnc_error};

_group = _this call FP_fnc_spawnGroup;
_radius = [_this,3,100,[0]] call BIS_fnc_param;
_patrol = [_this,4,true,[true]] call BIS_fnc_param;

// Patch for CBA taskDefend, last parameter seems broken
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

_group
