params ["_unit", "_type"];

_unit addHeadgear "CUP_H_USArmy_HelmetMICH";
_unit forceAddUniform "CUP_U_B_USArmy_Base";
_unit addVest "CUP_V_B_IOTV_Rifleman";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

{_unit addItemToUniform "ACE_fieldDressing"} count [0,1];
_unit addItemToUniform "ACE_morphine";
{_unit addItemToUniform "hlc_30rnd_556x45_SPR"} count [0,1];

{_unit addItemToVest "hlc_30rnd_556x45_SPR"} count [0,1,2,3,4,5,6];
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
{_unit addItemToVest "CUP_HandGrenade_M67"} count [0,1];

_unit addWeapon "rhs_weap_m4a1_carryhandle";
_unit addPrimaryWeaponItem "rhsusf_acc_compm4";
_unit addPrimaryWeaponItem "rhsusf_acc_grip1";



_unit addItemToUniform "ItemRadio";
