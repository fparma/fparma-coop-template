params ["_unit", "_type"];


_unit addHeadgear "CUP_H_USArmy_HelmetMICH_ESS";
_unit forceAddUniform "CUP_U_B_USArmy_UBACS";
_unit addVest "CUP_V_B_IOTV_gl";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
_unit addItemToUniform "ACE_morphine";
{_unit addItemToUniform "hlc_30rnd_556x45_SPR"} count [1,2];

{_unit addItemToVest "hlc_30rnd_556x45_SPR"} count [1,2,3,4,5];
{_unit addItemToVest "CUP_1Rnd_HEDP_M203"} count [1,2,3,4,5,6];
_unit addItemToVest "CUP_HandGrenade_M67";
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
{_unit addItemToVest "Chemlight_green"} count [1,2];

_unit addWeapon "rhs_weap_m4a1_carryhandle_m203";
_unit addPrimaryWeaponItem "rhsusf_acc_eotech_552";

_unit addItemToUniform "ItemRadio";
