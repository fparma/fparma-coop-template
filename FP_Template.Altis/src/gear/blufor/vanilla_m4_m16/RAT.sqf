_unit = _this select 0;
#include "_defineItems.sqf";

_unit forceAddUniform (_UNIFORMS  call BIS_fnc_selectRandom);
_unit addVest (_VESTS call BIS_fnc_selectRandom);
_unit addHeadGear (_HEADGEARS call BIS_fnc_selectRandom);

_unit addMagazines [_STANDARD_SMOKE,2];
_unit addMagazines [_GRENADE, 2];
_unit addMagazines [_STANDARD_MAG,4];
_unit addMagazines [_STANDARD_MAG_T,4];

[_unit, _STANDARD_RIFLE_C] call BIS_fnc_addWeapon;
{if (_x != "") then {_unit addPrimaryWeaponItem _x};} forEach _STANDARD_ATTACHMENTS;

_unit addMagazines [_STANDARD_PISTOL_MAG,2];
_unit addWeapon _STANDARD_PISTOL;

_unit addWeapon "STI_M136";

#include "_after.sqf";