params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "hlc_200rnd_556x45_M_SAW";
_unit addWeapon "hlc_lmg_M249E2";
_unit addMagazine "RH_17Rnd_9x19_g17";
_unit addWeapon "RH_g17";
removeBackpack _unit;

_unit addHeadgear "FP_Helmet_M90Des";
_unit forceAddUniform "FP_Uniform_M90Des";
_unit addVest "FP_Carrier_GreenPatchless";
_unit addBackpack "usm_pack_200rnd_556_bandoliers";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6];
_unit addItemToUniform "ACE_epinephrine";
{_unit addItemToUniform "ACE_morphine"} count [1,2];
{_unit addItemToUniform "CUP_HandGrenade_M67"} count [1,2];

{_unit addItemToVest "SmokeShellGreen"} count [1,2];
_unit addItemToVest "hlc_200rnd_556x45_M_SAW";
_unit addItemToBackpack "hlc_200rnd_556x45_M_SAW";

_unit addItemToUniform "ItemRadio";
