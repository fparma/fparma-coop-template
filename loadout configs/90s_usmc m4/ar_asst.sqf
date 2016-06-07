params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_556x45_Stanag";
_unit addWeapon "hlc_rifle_M4";
_unit addPrimaryWeaponItem "RH_t1";
_unit addMagazine "RH_20Rnd_57x28_FN";
_unit addWeapon "RH_fn57";
removeBackpack _unit;

_unit addHeadgear "usm_helmet_pasgt_w";
_unit forceAddUniform "usm_bdu_w";
_unit addVest "usm_vest_lbv_mg";
_unit addBackpack "usm_pack_762x51_bandoliers";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6];
_unit addItemToUniform "ACE_epinephrine";
{_unit addItemToUniform "ACE_morphine"} count [1,2];
_unit addItemToUniform "ACE_Flashlight_XL50";

{_unit addItemToVest "30Rnd_556x45_Stanag"} count [1,2,3,4,5,6,7,8];
{_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red"} count [1,2];
{_unit addItemToVest "CUP_HandGrenade_M67"} count [1,2];
{_unit addItemToVest "SmokeShellGreen"} count [1,2];
{_unit addItemToVest "RH_20Rnd_57x28_FN"} count [1,2];

{_unit addItemToBackpack "CUP_100Rnd_TE4_Red_Tracer_556x45_M249"} count [1,2,3];

_unit addItemToVest "ItemRadio";
