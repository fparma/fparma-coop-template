_unit = _this select 0;
#include "_defineItems.sqf";

_unit forceAddUniform (_UNIFORMS  call BIS_fnc_selectRandom);
_unit addVest (_VESTS call BIS_fnc_selectRandom);
_unit addHeadGear (_HEADGEARS call BIS_fnc_selectRandom);

_unit addMagazines [_STANDARD_SMOKE,2];
_unit addMagazines [_GRENADE, 2];
_unit addMagazines [_STANDARD_MAG,6];
_unit addMagazines [_STANDARD_MAG_T,2];

[_unit, _STANDARD_RIFLE_C] call BIS_fnc_addWeapon;
{if (_x != "") then {_unit addPrimaryWeaponItem _x};} forEach _STANDARD_ATTACHMENTS;

_unit addBackPack "B_FieldPack_ocamo";
_bp = (unitBackpack _unit);
clearItemCargoGlobal _bp;
if (isClass (configFile >> "CfgPatches" >> "AGM_Medical")) then {
	_bp addItemCargoGlobal ["AGM_Bandage",16];
	_bp addItemCargoGlobal ["AGM_Morphine",12];
	_bp addItemCargoGlobal ["AGM_Epipen",12];
	_bp addItemCargoGlobal ["AGM_Bloodbag",4];
}else{
	_bp addItemCargoGlobal ["FirstAidKit",12];
	_bp addItemCargoGlobal ["Medikit",1];
};

_unit addMagazines [_STANDARD_PISTOL_MAG,2];
_unit addWeapon _STANDARD_PISTOL;

#include "_after.sqf";