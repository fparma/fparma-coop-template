/*
    Author: Karel Moricky
        Edited by Cuel

    Description:
    Export current arnsenal loadout, with some improvements

    Returns:
    STRING - SQF code
*/

params [["_exportGogglesAndFace", false, [false]]];
diag_log "copy gear";

private _tab = toString [09];
private _br = tostring [13,10];
private _center = (missionnamespace getvariable ["BIS_fnc_arsenal_center", player]);
private _export = format ["case (_type == ""GiveThisKitAName"" || _type == ""%1""): {", typeOf _center] + _br;
private _var = "_unit";

private _radios = [];

private _fnc_addMultiple = {
    _items = _this select 0;
    _expression = _this select 1;
    _itemsUsed = [];
    {
        _item = _x;
        _itemLower = tolower _x;
        if (_itemLower select [0, 8] == "acre_prc") then {
            private _ex = (_expression splitString " ") select 1;
            private _r = _x splitString "_";
            private _radio = [_r select 0, _r select 1] joinString "_";
            if (_radio == "ACRE_PRC343") then {_radio = "ItemRadio"};
            _radios pushBackUnique format ["%1 %2 ""%3"";",_var, _ex, _radio];
        } else {
            if !(_itemLower in _itemsUsed) then {
                _itemsUsed set [count _itemsUsed,_itemLower];
                _itemCount = {_item == _x} count _items;
                _expressionLocal = _expression;
                if (_itemCount > 1) then {
                    _count = [];
                    for "_i" from 1 to _itemCount do {_count pushBack (_i - 1)};
                    _expressionLocal = format ["{%2} count %1", _count, _expression];
                };
                _export = _export + _br + _tab + format [_expressionLocal,_var,_x] + ";";
            };
        }
    } foreach _items;
};

if (headgear _center != "") then {
    _export = _export + _tab +  format ["%1 addHeadgear ""%2"";",_var,headgear _center] + _br;
};

if (uniform _center != "") then {
    _export = _export + _tab +  format ["%1 forceAddUniform ""%2"";",_var, uniform _center] + _br;
};


if (vest _center != "") then {
    _export = _export + _tab +  format ["%1 addVest ""%2"";",_var, vest _center] + _br;
};

if (!isnull unitbackpack _center) then {
    _export = _export + _tab +  format ["%1 addBackpack ""%2"";",_var,typeof unitbackpack _center] + _br;
    _export = _export + _tab + format ["clearAllItemsFromBackpack %1;", _var] + _br;
};

//--- Assign items
private _items = assigneditems _center - [binocular _center, "ItemRadioAcreFlagged"];
[_items, "%1 linkItem ""%2"""] call _fnc_addMultiple;
_export = _export + _tab +  _br;

// Magazines etc

if (uniform _center != "") then {
    [uniformitems _center,"%1 addItemToUniform ""%2"""] call _fnc_addMultiple;
    _export = _export + _br;
};

if (vest _center != "") then {
    [vestitems _center,"%1 addItemToVest ""%2"""] call _fnc_addMultiple;
    _export = _export + _br;
};

if (!isnull unitbackpack _center) then {
    [backpackitems _center,"%1 addItemToBackpack ""%2"""] call _fnc_addMultiple;
    _export = _export + _br;
};

//--- Weapons
// _export = _export + _tab +  _br;
{
    _weapon = _x select 0;
    _weaponAccessories = _x select 1;
    _weaponCommand = _x select 2;
    if (_weapon != "") then {
        _export = _export + _tab +  format ["%1 addWeapon ""%2"";",_var, _weapon] + _br;
        private _filter = _weaponAccessories select {_x != ""};
        {
            _export = _export + _tab +  format ["%1 %3 ""%2"";",_var, _x, _weaponCommand] + _br;
        } foreach _filter;
        if (count _filter >= 2) then {_export = _export + _br};
    };
} foreach [
    [primaryweapon _center,_center weaponaccessories primaryweapon _center,"addPrimaryWeaponItem"],
    [secondaryweapon _center,_center weaponaccessories secondaryweapon _center,"addSecondaryWeaponItem"],
    [handgunweapon _center,_center weaponaccessories handgunweapon _center,"addHandgunItem"],
    [binocular _center,[],""]
];

if (count _radios > 0) then {
    _export = _export + _br;
    // _export = _export + _tab + "[{" + _br;
    {
        _export = _export +  _tab + _x + _br;
    } forEach _radios;
    // _export = _export + _tab +  "}, 0.5 + random 1, []] call ACE_common_fnc_waitAndExecute;"
};

/*
private _insignia = _center call bis_fnc_getUnitInsignia;
if (_insignia != "") then {
    _export = _export + _tab +  format ["[%1,""%2""] call bis_fnc_setUnitInsignia;", _var, _insignia] + _br;
};
*/

//--- Export to clipboard
_export = _export + _br + "};";

copyToClipboard _export;
_export
