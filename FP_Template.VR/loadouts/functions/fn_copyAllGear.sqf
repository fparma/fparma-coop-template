/*
    Author: Karel Moricky
        Edited by Cuel
    Description:
    Export current arsenal loadout, with some improvements
    Also supports just "simply exporting" the players current gear, if called from editor

    Returns:
    STRING - SQF code
*/

#define ADD_EXPORT(xArg) _export pushBack xArg
#define ADD_EXPORT_FORMAT(xArg) _export pushBack format xArg
#define ADD_EMPTY_LINE _export pushBack _br

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
	private _aceBp = "ACE_FakeBackpack";
  ADD_EXPORT("// Add fake bp with single mag and weapons");
	ADD_EXPORT_FORMAT(['%1 addBackpack "%2;"', _var, _aceBp]);
  
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

	ADD_EXPORT_FORMAT(['%1 removeBackpack "%2";', _aceBp]);
	ADD_EMPTY_LINE;
};

// Containers / clothes
private ["_uniformItems", "_vestItems", "_backpackItems"];
private _containerCommentAdded = false;
private _checkContainerComment = {
	if (!_containerCommentAdded) then {ADD_EXPORT("// Add containers / clothes")};
};

if (headgear _center != "") then {
	call _checkContainerComment;
	ADD_EXPORT_FORMAT(['%1 addHeadgear "%2";', _var, headgear _center]);
};

if (uniform _center != "") then {
	call _checkContainerComment;
	_uniformItems = uniformItems _center;
	ADD_EXPORT_FORMAT(['%1 forceAddUniform "%2";', _var, uniform _center]);
};

if (vest _center != "") then {
	call _checkContainerComment;
	_vestItems = vestItems _center;
	ADD_EXPORT_FORMAT(['%1 addVest "%2";', _var, vest _center]);
};

if (!isNull unitBackpack _center) then {
	call _checkContainerComment;
	_backpackItems = backpackItems _center;
	ADD_EXPORT_FORMAT(['%1 addBackpack "%2";', _var, typeof unitbackpack _center]);
	ADD_EXPORT_FORMAT(['clearAllItemsFromBackpack %1";', _var]);
};

if (_containerCommentAdded) then {ADD_EMPTY_LINE};

// Assigned items
private _assignedItems = assignedItems _center - [binocular _center, "ItemRadioAcreFlagged"];
if (count _assignedItems > 0) then {
	ADD_EXPORT_FORMAT(['{%1 linkItem _x} forEach %2;', _var, _assignedItems]);
	ADD_EMPTY_LINE;
};

// Magazines and misc items for containers
if (!isNil "_uniformItems") then {
	ADD_EXPORT("// Uniform items");
	[_uniformItems, '%1 addItemToUniform "%2";'] call _fnc_addMultiple;
	ADD_EMPTY_LINE;
};

if (!isNil "_vestItems") then {
	ADD_EXPORT("// Vest items");
	[_vestItems, '%1 addItemToVest "%2";'] call _fnc_addMultiple;
	ADD_EMPTY_LINE;
};

if (!isNil "_backpackItems") then {
	ADD_EXPORT("// Backpack items");
	[_backpackItems, '%1 addItemToBackpack "%2";'] call _fnc_addMultiple;
	ADD_EMPTY_LINE;
};

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
