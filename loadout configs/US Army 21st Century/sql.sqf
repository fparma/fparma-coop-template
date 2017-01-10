params ["_unit", "_type"];

_unit addHeadgear "CUP_H_USArmy_HelmetMICH_headset_ess";
_unit forceAddUniform "CUP_U_B_USArmy_TwoKnee";
_unit addVest "CUP_V_B_IOTV_SL";
_unit addBackpack "CUP_B_USPack_Coyote_SL";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","ItemGPS"];

{_unit addItemToUniform "ACE_fieldDressing"} count [0,1];
_unit addItemToUniform "ACE_morphine";
{_unit addItemToUniform "hlc_30rnd_556x45_SPR"} count [0,1];
_unit addItemToUniform "ACE_MapTools";

_unit addItemToVest "hlc_30rnd_556x45_SPR";
{_unit addItemToVest "RH_15Rnd_9x19_M9"} count [0,1];
{_unit addItemToVest "CUP_HandGrenade_M67"} count [0,1];
{_unit addItemToVest "B_IR_Grenade"} count [0,1];
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
_unit addItemToVest "SmokeShellBlue";
_unit addItemToVest "SmokeShellOrange";
{_unit addItemToVest "Chemlight_green"} count [0,1];

{_unit addItemToBackpack "hlc_30rnd_556x45_SPR"} count [0,1,2,3,4,5,6];

_unit addWeapon "rhs_weap_m4a1_carryhandle";
_unit addPrimaryWeaponItem "RH_ta01nsn";
_unit addPrimaryWeaponItem "rhsusf_acc_grip3";

_unit addWeapon "RH_m9";
_unit addWeapon "Binocular";

_unit addItemToUniform "ItemRadio";
if (_type != "B_Soldier_TL_F") then {
  _unit addItemToUniform "ACRE_PRC148";
};
