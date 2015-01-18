_unit = _this select 0;
#include "_defineItems.sqf";

_unit forceAddUniform (_UNIFORMS call bis_fnc_selectRandom);
_unit addVest (_VESTS select 0);
_unit addBackpack _LR_RADIO;
_unit addHeadGear "H_Beret_red";

_unit addMagazines [_STANDARD_SMOKE,2];
_unit addMagazines [_GRENADE,2];
_unit addMagazines [_STANDARD_MAG,8];
_unit addMagazines [_STANDARD_MAG_T,4];
_unit addMagazines [_GL_HE,4];

_unit addMagazines [_CHEMLIGHT, 2];
{_unit addMagazine _x} forEach _GL_SMOKES;

if ({!isNil "_x" && {_x != ""}} count _LEADER_ITEMS > 0) then {
	{if (_x == "ItemGPS") then {_unit linkItem _x} else {_unit additem _x}} foreach _LEADER_ITEMS;
};

[_unit, _STANDARD_RIFLE_GL] call BIS_fnc_addWeapon;
{if (_x != "") then {_unit addPrimaryWeaponItem _x};} forEach  _LEADER_ATTACHMENTS;

_unit addMagazine "LaserBatteries";
_unit addWeapon "Laserdesignator";

_unit addMagazines [_STANDARD_PISTOL_MAG,2];
_unit addWeapon _STANDARD_PISTOL;

// add common items
#include "_after.sqf";