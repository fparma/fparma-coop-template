params ["_unit", "_type"];

_unit addHeadgear "CUP_H_USArmy_HelmetMICH_headset_ess";
_unit forceAddUniform "CUP_U_B_USArmy_Soft";
_unit addVest "CUP_V_B_IOTV_saw";
_unit addBackpack "CUP_B_USArmy_AR";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

{_unit addItemToUniform "ACE_fieldDressing"} count [0,1];
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "SmokeShell";
_unit addItemToUniform "CUP_HandGrenade_M67";
_unit addItemToUniform "SmokeShellGreen";
_unit addItemToUniform "Chemlight_green";

{_unit addItemToBackpack "CUP_100Rnd_TE4_Green_Tracer_556x45_M249"} count [0,1,2,3,4];
_unit addItemToVest "Chemlight_green";

_unit addWeapon "CUP_lmg_m249_pip4";



_unit addItemToUniform "ItemRadio";
