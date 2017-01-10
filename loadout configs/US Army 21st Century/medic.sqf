params ["_unit", "_type"];

_unit addHeadgear "CUP_H_USArmy_HelmetMICH";
_unit forceAddUniform "CUP_U_B_USArmy_Base";
_unit addVest "CUP_V_B_IOTV_Medic";
_unit addBackpack "CUP_B_USArmy_Medic";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

{_unit addItemToUniform "hlc_30rnd_556x45_SPR"} count [0,1];
{_unit addItemToVest "ACE_morphine"} count [0,1,2,3,4];
{_unit addItemToVest "ACE_fieldDressing"} count [0,1,2,3,4,5,6,7];
{_unit addItemToVest "hlc_30rnd_556x45_SPR"} count [0,1,2];
{_unit addItemToVest "16Rnd_9x21_Mag"} count [0,1];
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
_unit addItemToVest "SmokeShellBlue";
_unit addItemToVest "SmokeShellOrange";
{_unit addItemToVest "Chemlight_green"} count [0,1];

{_unit addItemToBackpack "ACE_fieldDressing"} count [0,1,2,3,4,5,6,7,8,9,10,11,12,13];
{_unit addItemToBackpack "ACE_morphine"} count [0,1,2,3,4,5];
{_unit addItemToBackpack "ACE_epinephrine"} count [0,1,2,3];
{_unit addItemToBackpack "ACE_bloodIV"} count [0,1];

_unit addWeapon "rhs_weap_m4a1_carryhandle";
_unit addPrimaryWeaponItem "rhsusf_acc_eotech_552";
_unit addPrimaryWeaponItem "rhsusf_acc_grip3";

_unit addItemToVest "ItemRadio";
