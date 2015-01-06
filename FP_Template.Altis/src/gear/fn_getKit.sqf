// Gives specific loadouts to units (template-like)
// unit init example:
// [this,"PLT"] call FP_fnc_getKit
// uncomment next line if you do not want custom loadouts (or just remove init lines from in-game)
// if (true) exitWith {};

// change gear here by changing the path. note the backslash \

_GEAR = "blufor\vanilla";

_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_kit = toUpper ([_this,1,"",[""]] call BIS_fnc_param);
_unit setVariable ["FP_kit_type", _kit]; // for respawn

if (local _unit) then {
	removeHeadgear _unit;
	removeAllContainers _unit;
	removeAllItems _unit;
	removeAllWeapons _unit;
	removeAllAssignedItems _unit;

	// assign gear
	_FULLPATH = ("src\gear\" + _GEAR + "\" + _kit + ".sqf");
	[_unit] call compile preprocessFileLineNumbers _FULLPATH;
};