/*
	Function: FP_fnc_addOptic

	API:
		Any

	Description:
        Helper to add optics such as binocs and not looking around for the class name
        values can be
        binoc, soflam, lerca_b (black), lerca_t (tan), laser, laser_blufor, laser_opfor, laser_indep

        NVG will be added on head if daytime is not between 0700 and 2000
        Otherwise in the inventory

	Parameters:
		_unit - Unit to add stuff to
        _kind - String of a matching value from above

	Examples:
	(begin example)
		[_unit, ["wide"]] call FP_fnc_addOptic;
	(end)

	Author:
	Cuel 2015-04-30
*/

#include "helpers.hpp";

private ["_unit","_kind", "_type"];
_unit = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
_kind = [_this, 1, [], [[], ""]] call BIS_fnc_param;
if (IS_ARRAY(_kind)) then {_kind = _kind select 0};

if (_kind in ["soflam"] || ["laser", _kind] call BIS_fnc_inString) then {
    ADD_CHECK(_unit "LaserBatteries");
    _unit addMagazine "LaserBatteries";
};

_type = switch _kind do {
    case "binoc": {"Binocular"};
    case "soflam": {"CUP_SOFLAM";};
    case "lerca_b": {"lerca_1200_black"};
    case "lerca_t": {"lerca_1200_tan"};
    case "laser": {"ACE_Vector"};
    case "laser_blufor": {"Laserdesignator"};
    case "laser_opfor": {"Laserdesignator_02"};
    case "laser_indep": {"Laserdesignator_03"};
    default {""};
};

if (_type != "" && {!([_unit, _type] call CBA_fnc_addWeapon)}) then {ERR_LOG(_unit, _type)};
