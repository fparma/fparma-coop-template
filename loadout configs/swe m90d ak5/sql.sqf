params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_556x45_Stanag";
_unit addMagazine "1Rnd_HE_Grenade_shell";
_unit addWeapon "SAM_AK5C_GRT";
_unit addPrimaryWeaponItem "CUP_optic_Elcan_reflex";
_unit addMagazine "RH_17Rnd_9x19_g17";
_unit addWeapon "RH_g17";
_unit addWeapon "ACE_Vector";
removeBackpack _unit;

_unit addHeadgear "FP_Helmet_M90Des";
_unit forceAddUniform "FP_Uniform_M90Des";
_unit addVest "FP_Carrier_GreenPatchless";
_unit addBackpack "CUP_B_ACRScout_m95";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6];
_unit addItemToUniform "ACE_epinephrine";
{_unit addItemToUniform "ACE_morphine"} count [1,2];
_unit addItemToUniform "ACE_microDAGR";
{_unit addItemToUniform "CUP_HandGrenade_M67"} count [1,2];
{_unit addItemToUniform "SmokeShellGreen"} count [1,2];

_unit addItemToVest "ACE_MapTools";
{_unit addItemToVest "30Rnd_556x45_Stanag"} count [1,2,3,4];
_unit addItemToVest "RH_17Rnd_9x19_g17";
{_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red"} count [1,2,3,4,5];

{_unit addItemToBackpack "1Rnd_HE_Grenade_shell"} count [1,2,3,4];
_unit addItemToBackpack "1Rnd_Smoke_Grenade_shell";
_unit addItemToBackpack "1Rnd_SmokePurple_Grenade_shell";
_unit addItemToBackpack "1Rnd_SmokeRed_Grenade_shell";

if (_type != "B_Soldier_TL_F") then {
  _unit addItemToVest "ACE_HuntIR_monitor";
  {_unit addItemToBackpack "ACE_HuntIR_M203"} count [1,2,3,4];
  _unit addItemToVest "ACRE_PRC148";
};
_unit addItemToVest "ItemRadio";
_unit addItem "ACE_CableTie";
