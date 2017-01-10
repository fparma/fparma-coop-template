params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "hlc_30rnd_556x45_SPR";
_unit addWeapon "rhs_weap_m4a1_carryhandle";
_unit addPrimaryWeaponItem "rhsusf_acc_compm4";
_unit addPrimaryWeaponItem "rhsusf_acc_grip1";

removeBackpack _unit;

_unit addHeadgear "CUP_H_USArmy_HelmetMICH_earpro_ess";
_unit forceAddUniform "CUP_U_B_USArmy_TwoKnee";
_unit addVest "CUP_V_B_IOTV_SL";
_unit addBackpack "CUP_B_USArmy_Engineer";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","ItemRadio"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
_unit addItemToUniform "ACE_morphine";
{_unit addItemToUniform "hlc_30rnd_556x45_SPR"} count [1,2];

{_unit addItemToVest "hlc_30rnd_556x45_SPR"} count [1,2,3,4];
_unit addItemToVest "CUP_HandGrenade_M67";
_unit addItemToVest "SmokeShell";

_unit addItemToBackpack "ToolKit";

