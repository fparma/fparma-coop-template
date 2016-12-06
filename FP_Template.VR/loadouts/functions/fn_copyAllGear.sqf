/*
    Author: Karel Moricky
        Rewritten by Cuel

    Description:
    Export current arsenal loadout, with some improvements
    Also supports just "simply exporting" the players current gear, if called from editor

    Returns:
    STRING - SQF code
*/

#define ADD_EXPORT(xArg) _export pushBack xArg
#define ADD_EXPORT_FORMAT(xArg) _export pushBack format xArg
#define ADD_EMPTY_LINE _export pushBack _br
#define ACE_BACKPACK "ACE_FakeBackpack"
#define ACRE_ITEM_FLAGGED "ItemRadioAcreFlagged"

private _var = "_unit";
private _savedRadios = [];
private _br = toString [13, 10];
private _export = ['params ["_unit", "_type"];' + _br];
private _center = missionNameSpace getVariable ["BIS_fnc_arsenal_center", player];

private _fnc_getRadio = {
  params ["_item"];
  if (_item select [0,8] != "acre_prc") exitWith {""};
  private _split = _item splitString "_";
  private _radio = [_split select 0, _split select 1] joinString "_";
  if (_radio == "ACRE_PRC343") exitWith {"ItemRadio"};
  (toUpper _radio)
};

private _fnc_addMultiple = {
  params ["_items", "_command"];
  private _itemsUsed = [];
  
  {
    private _item = _x;
    private _itemLowerCase = toLower _item;
    private _radio = _itemLowerCase call _fnc_getRadio;
    if (_radio != "") then {
      private _cmd = _command splitString " ") select 1;
      _savedRadios pushBack (format ['%1 %2 "%3";', _var, _cmd, _radio]);
    } else {
      if !(_itemLowerCase in _itemsUsed) then {
        _itemsUsed pushBack _itemLowerCase;
        private _count = {_item == _x} count _items;
        private _localCommand = _command;

        if (_count > 1) then {
          private _numberArray = [];
          for "_i" from 1 to _itemCount do {_numberArray pushBack _i};
          _localCommand = format ["{%1} count %2;", _command, _numberArray];
        };

        ADD_EXPORT_FORMAT([_localCommand, _var, _x]);
      };
    };
  }forEach _items;
};

if (primaryWeapon _center != "" || {secondaryWeapon _center != ""} || {handgunWeapon _center != ""} || {binocular _center != ""}) then {
  ADD_EXPORT("// Add fake bp with single mag and weapons. This ensures that weapons are loaded correctly");
  ADD_EXPORT_FORMAT(['%1 addBackpack "%2;"', _var, ACE_BACKPACK]);
  
  private _pw = primaryWeapon _center;
  private _sw = secondaryWeapon _center;
  private _hw = handgunWeapon _center;
  private _getAccessories = {
    params [["_wep", ""]];
    ((_center weaponAccessories _wep) select {_x != ""})
  };

  private _primary = [_pw, _pw call _getAccessories, "addPrimaryWeaponItem", primaryWeaponMagazine _center],
  private _secondary = [_sw, _sw call _getAccessories, "addSecondaryWeaponItem", secondaryWeaponMagazine _center],
  private _handgun = [_hw, _hw call _getAccessories, "addHandgunItem", handgunMagazine _center],
  private _binoc = [binocular _center, [_center call ace_common_fnc_binocularMagazine], "addMagazine"];
  
  {
    _x params [["_weapon", ""], "_accessories", "_command", ["_loadedAmmo", []];
    if (_weapon != "") then {
      {ADD_EXPORT_FORMAT(['%1 addMagazine "%2";', _var, _x])} forEach _loadedAmmo;
      ADD_EXPORT_FORMAT(['%1 addWeapon "%2";', _var, _weapon]);

      {
        ADD_EXPORT_FORMAT(['%1 %2 "%3";', _var, _command, _x]);
      } forEach _accessories;
      if (count _accessories >= 2) then {ADD_EMPTY_LINE};
    };
  } forEach [_primary, _secondary, _handgun, _binoc];

  ADD_EXPORT_FORMAT(['%1 removeBackpack "%2";', ACE_BACKPACK]);
  ADD_EMPTY_LINE;
};

// Containers / clothes
private _containerCommentAdded = false;
{
	_x params ["_clothing", "_cmd"];
	if (_clothing != "") then {
		if (!_containerCommentAdded) then {ADD_EXPORT("// Add containers / clothes")};
		ADD_EXPORT_FORMAT(['%1 %2 "%3";', _var, _cmd, _clothing]);
	};
} forEach [
	[headgear _center, "addHeadgear"],
	[uniform _center, "forceAddUniform"],
	[vest _center, "addVest"]
];

if (!isNull unitBackpack _center) then {
  call _checkContainerComment;
  _backpackItems = backpackItems _center;
  ADD_EXPORT_FORMAT(['%1 addBackpack "%2";', _var, typeof unitbackpack _center]);
  ADD_EXPORT_FORMAT(['clearAllItemsFromBackpack %1";', _var]);
};

if (_containerCommentAdded) then {ADD_EMPTY_LINE};
// Assigned items
private _assignedItems = assignedItems _center - [binocular _center, ACRE_ITEM_FLAGGED];
if (count _assignedItems > 0) then {
  ADD_EXPORT_FORMAT(['{%1 linkItem _x} forEach %2;', _var, _assignedItems]);
  ADD_EMPTY_LINE;
};

{
	_x params [["_items", []], "_cmd", "_comment"];
	if !(_items isEqualTo []) then {
		ADD_EXPORT(_comment);
		[_items, _cmd] call _fnc_addMultiple;
		ADD_EMPTY_LINE;
	};
} forEach [
	[uniformItems _center, '%1 addItemToUniform "%2";', "// Uniform items"],
	[vestItems _center, '%1 addItemToVest "%2";', "// Vest items"],
	[backpackItems _center, '%1 addItemToBackpack "%2";', "// Backpack items"]
];

// Radios
if !(_savedRadios isEqualTo []) then {
  ADD_EMPTY_LINE;
  {ADD_EXPORT(_x)} forEach _savedRadios;
};

private _ret = _export joinString _br;

/*
private _loadout = getUnitLoadout _center;
[_center, ""] call compile _ret;
if !(getUnitLoadout player isEqualTo _loadout) then {
  hint "loadout mismatch";
};
*/

copyToClipBoard _ret;
_ret
