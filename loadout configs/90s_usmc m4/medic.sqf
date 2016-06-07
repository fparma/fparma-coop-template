params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_556x45_Stanag";
_unit addWeapon "hlc_rifle_CQBR";
_unit addPrimaryWeaponItem "RH_t1";
_unit addMagazine "RH_20Rnd_57x28_FN";
_unit addWeapon "RH_fn57";
removeBackpack _unit;

_unit addHeadgear "usm_helmet_pasgt_g_w";
_unit forceAddUniform "usm_bdu_w";
_unit addVest "usm_vest_lbv_rmp";
_unit addBackpack "usm_pack_m5_medic";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6];
_unit addItemToUniform "ACE_epinephrine";
{_unit addItemToUniform "ACE_morphine"} count [1,2];
_unit addItemToUniform "ACE_Flashlight_XL50";

{_unit addItemToVest "CUP_HandGrenade_M67"} count [1,2];
{_unit addItemToVest "SmokeShellGreen"} count [1,2];
{_unit addItemToVest "RH_20Rnd_57x28_FN"} count [1,2];
{_unit addItemToVest "30Rnd_556x45_Stanag"} count [1,2,3,4,5,6,7,8,9];
{_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red"} count [1,2];

{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28];
{_unit addItemToBackpack "ACE_bloodIV_500"} count [1,2,3,4];
{_unit addItemToBackpack "ACE_epinephrine"} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26];

_unit addItemToVest "ItemRadio";
