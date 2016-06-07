params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "hlc_30Rnd_9x19_B_MP5";
_unit addWeapon "hlc_smg_mp5a2";
_unit addMagazine "RH_20Rnd_57x28_FN";
_unit addWeapon "RH_fn57";
removeBackpack _unit;

_unit addHeadgear "usm_helmet_cvc";
_unit forceAddUniform "usm_bdu_w";
_unit addVest "CUP_V_C_Police_Holster";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6];
_unit addItemToUniform "ACE_epinephrine";
{_unit addItemToUniform "ACE_morphine"} count [1,2];
_unit addItemToUniform "ACE_Flashlight_XL50";

{_unit addItemToVest "hlc_30Rnd_9x19_B_MP5"} count [1,2,3,4,5];
{_unit addItemToVest "SmokeShellGreen"} count [1,2];
_unit addItemToVest "ACE_HandFlare_White";

_unit addItemToVest "ItemRadio";

if (toLower str _unit in ["z0", "q0"]) then {
  _unit addBackpack "B_AssaultPack_rgr";
  clearAllItemsFromBackpack _unit;
  _unit addItemToVest "ACRE_PRC148";
  _unit addItemToBackpack "ACRE_PRC117F";

};
