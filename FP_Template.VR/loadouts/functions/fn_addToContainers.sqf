/*
	Function: FP_fnc_addToContainers

	API:
		Any

	Description:
        Helper to add all kinds of magazines, items etc.

        If item is linkable, will be linked

        If them items is defined in cfgWeapons will try to add to uniform
        For all others, will first try to add to vest, then backpack and lastly uniform

	Parameters:
		_unit - Unit to add stuff to
        _elems - String or array with arrays in format [class, count] or strings
        _force - Force add to some container. Values can be "backpack", "uniform", "vest"

	Examples:
	(begin example)
		[_unit, "mag1"] call FP_fnc_addToContainers;

        [_unit, [["mag1", 2], "mag2"], "uniform"] call FP_fnc_addToContainers; // force adds to uniform

        [_unit, [["mag1", 4], [["mag1", 2], "mag4"], "mag5"]] call FP_fnc_addToContainers;
	(end)

	Author:
	Cuel 2015-04-30
*/

// Todo: maybe check config entry instead
#define LINKABLE_ITEMS ["ItemMap", "ItemCompass","ItemWatch","ItemGPS", "ACE_Altimeter","I_UavTerminal","B_UavTerminal","O_UavTerminal"]
#define ERR_LOG(X, Y) diag_log format ["GEAR: failed to add %2 to %1", X, Y];

params [
    ["_unit", objNull],
    ["_elems", [], [[], ""]],
    ["_force", ""]
];

private _filter = _elems;
if (_filter isEqualType []) then {
    _filter = _elems select {
        if (_x isEqualType "") exitWith {count _x > 0};
        _x params ["_str", "_idx"];
        (_str isEqualType "" && {count _x > 0} && (_idx isEqualType 0))
    };
};

private _add = {
    if (count _this == 0) exitWith {};
    if (_force != "") exitWith {
        switch _force do {
            case "backpack": {
                if (!(_unit canAddItemToBackpack _this)) exitWith {ERR_LOG(_unit, _this)};
                _unit addItemToBackpack _this;
            };
            case "uniform": {
                if (!(_unit canAddItemToUniform _this)) exitWith {ERR_LOG(_unit, _this)};
                _unit addItemToUniform _this;
            };
            case "vest": {
                if (!(_unit canAddItemToVest _this)) exitWith {ERR_LOG(_unit, _this)};
                _unit addItemToVest _this;
            };
            default {ERR_LOG(_unit, _this)};
        };
    };

    if (_this in LINKABLE_ITEMS) exitWith {_unit linkItem _this};
    if (!(_unit canAdd _this)) exitWith {ERR_LOG(_unit, _this)};
    if (isClass (configFile >> "CfgWeapons" >> _this) && {_unit canAddItemToUniform _this}) exitWith {_unit addItemToUniform _this;};
    if (_unit canAddItemToVest _this) exitWith {_unit addItemToVest _this};
    if (_unit canAddItemToBackpack _this) exitWith {_unit addItemToBackpack _this};
    _unit addItemToUniform _this;
};

// only passed a string
if (_filter isEqualType "") exitWith {
    if (_filter != "") then {
        _filter call _add;
    };
};

// empty array
if (_filter isEqualType [] && {count _filter == 0}) exitWith {};

// use recursion if necessary
private _traverse = {
    if (_this isEqualType "") exitWith {_this call _add};
    if ((_this select 0) isEqualType "" && {(_this select 1) isEqualType 0}) exitWith {
        for "_i" from 1 to (_this select 1) do {
            (_this select 0) call _add;
        };
    };

    {
        private _cur = _x;
        if (_cur isEqualType "") then {
            _cur call _add;
        }else{
            if ((_this select 0) isEqualType "" && {(_this select 1) isEqualType 0}) then {
                for "_i" from 1 to (_cur select 1) do {
                    (_cur select 0) call _add;
                };
            }else{
                _cur call _traverse;
            };
        };
    }forEach _this;
};

_filter call _traverse;
