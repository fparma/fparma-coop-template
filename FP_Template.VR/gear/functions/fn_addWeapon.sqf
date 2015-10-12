/*
	Function: FP_fnc_addWeapon

	API:
		Any

	Description:
        Helper to add any kind of weapon and also attachments
        Supports adding attachments to primary weapon, secondaryWeapon and handguns

	Parameters:
		_unit - Unit to add stuff to
        _add - String or array in format [wep, attachments]

	Examples:
	(begin example)
		[_unit, "wep01"] call FP_fnc_addWeapon;

        [_unit, ["wep01", "attachment1"]] call FP_fnc_addWeapon;

        [_unit, ["wep01", "attachment1", "attachments2"]] call FP_fnc_addWeapon;
	(end)

	Author:
	Cuel 2015-04-30
*/

#include "helpers.hpp";
params [
    ["_unit", objNull, [objNull]],
    ["_add", []]
];

local _attach = {
    switch (getNumber (configFile >> "cfgWeapons" >> _wep >> "type")) do {
        case 1: {_unit addPrimaryWeaponItem _this};
        case 2: {_unit addHandgunItem _this};
        case 4: {_unit addSecondaryWeaponItem _this};
        default {ERR_LOG(_unit, _this)};
    };
};

if (IS_STRING(_add)) then {
    if (!([_unit, _add] call CBA_fnc_addWeapon)) then {ERR_LOG(_unit, _add)};
}else{
    _wep = _add deleteAt 0;
    while {IS_ARRAY(_wep)} do {_wep = _wep call BIS_fnc_selectRandom};
    if (!([_unit, _wep] call CBA_fnc_addWeapon)) then {ERR_LOG(_unit, _wep)};
    {
        if (IS_ARRAY(_x)) then {
            {
                ADD_CHECK(_unit, _x);
                _x call _attach;
            }forEach _x;
        }else{
            ADD_CHECK(_unit, _x);
            _x call _attach;
        };
    } forEach _add;
};
