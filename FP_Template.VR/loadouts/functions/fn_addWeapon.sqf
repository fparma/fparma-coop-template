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

#define ERR_LOG(X, Y) diag_log format ["GEAR: failed to add %2 to %1", X, Y];

params [
    ["_unit", objNull, [objNull]],
    ["_add", []]
];

private _attach = {
    switch (getNumber (configFile >> "cfgWeapons" >> _wep >> "type")) do {
        case 1: {_unit addPrimaryWeaponItem _this};
        case 2: {_unit addHandgunItem _this};
        case 4: {_unit addSecondaryWeaponItem _this};
        default {ERR_LOG(_unit, _this)};
    };
};

if (_add isEqualType "") then {
    if (!([_unit, _add] call CBA_fnc_addWeapon)) then {ERR_LOG(_unit, _add)};
}else{
    _wep = _add deleteAt 0;
    while {_wep isEqualType []} do {_wep = selectRandom _wep};
    if (!([_unit, _wep] call CBA_fnc_addWeapon)) exitWith {ERR_LOG(_unit, _wep)};
    {
        if (_x isEqualType []) then {
            {
                _x call _attach;
            }forEach _x;
        }else{
            _x call _attach;
        };
    } forEach _add;
};
