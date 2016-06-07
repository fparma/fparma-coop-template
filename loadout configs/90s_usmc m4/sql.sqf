params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_556x45_Stanag_Tracer_Red";
_unit addMagazine "1Rnd_HE_Grenade_shell";
_unit addWeapon "hlc_rifle_m4m203";
_unit addPrimaryWeaponItem "CUP_optic_CompM4";
_unit addMagazine "RH_20Rnd_57x28_FN";
_unit addWeapon "RH_fn57";
_unit addWeapon "Binocular";
removeBackpack _unit;

_unit addHeadgear "usm_helmet_pasgt_g_w";
_unit forceAddUniform "usm_bdu_w";
_unit addVest "usm_vest_LBE_gr";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6];
_unit addItemToUniform "ACE_epinephrine";
{_unit addItemToUniform "ACE_morphine"} count [1,2];

_unit addItemToVest "ACE_Flashlight_MX991";
_unit addItemToVest "ACE_MapTools";
_unit addItemToVest "ACE_microDAGR";

{_unit addItemToVest "CUP_HandGrenade_M67"} count [1,2];
{_unit addItemToVest "SmokeShellGreen"} count [1,2];
{_unit addItemToVest "RH_20Rnd_57x28_FN"} count [1,2];
{_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red"} count [1,2,3,4];
{_unit addItemToVest "30Rnd_556x45_Stanag"} count [1,2,3,4];

_unit addItemToVest "ItemRadio";
_unit addItemToVest "ACRE_PRC148";

if (_type != "B_Soldier_TL_F") then {
  _unit addItemToVest "ACE_HuntIR_monitor";

  _unit addBackpack "usm_pack_alice_prc119";
  clearAllItemsFromBackpack _unit;
  _unit addItemToBackpack "ACRE_PRC117F";
  {_unit addItemToBackpack "ACE_HuntIR_M203"} count [1,2,3];
  {_unit addItemToBackpack "1Rnd_HE_Grenade_shell"} count [1,2];
}else {
  {_unit addItemToVest "1Rnd_HE_Grenade_shell"} count [1,2,3,4];
};
