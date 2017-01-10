params ["_unit", "_type"];

_unit addHeadgear "CUP_H_USArmy_HelmetMICH";
_unit forceAddUniform "CUP_U_B_USArmy_Base";
_unit addVest "CUP_V_B_IOTV_Rifleman";
_unit addBackpack "CUP_B_AssaultPack_ACU_AmmoSAW";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

{_unit addItemToUniform "ACE_fieldDressing"} count [0,1];
_unit addItemToUniform "ACE_morphine";
{_unit addItemToUniform "hlc_30rnd_556x45_SPR"} count [0,1];

{_unit addItemToVest "hlc_30rnd_556x45_SPR"} count [0,1,2,3,4];
{_unit addItemToVest "CUP_HandGrenade_M67"} count [0,1];
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
{_unit addItemToVest "Chemlight_green"} count [0,1];


{_unit addItemToBackpack "CUP_100Rnd_TE4_Green_Tracer_556x45_M249"} count [0,1];
{_unit addItemToBackpack "CUP_100Rnd_TE4_Green_Tracer_556x45_M249"} count [0,1];

_unit addWeapon "rhs_weap_m4a1_carryhandle";
_unit addPrimaryWeaponItem "rhsusf_acc_eotech_552";
_unit addPrimaryWeaponItem "rhsusf_acc_grip3";

_unit addWeapon "Rangefinder";

_unit addItemToUniform "ItemRadio";
