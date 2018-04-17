// ["B_Soldier_SL_F", "example.sqf"]
params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "hlc_30rnd_556x45_EPR_G36";
_unit addMagazine "1Rnd_HE_Grenade_shell";
_unit addWeapon "hlc_rifle_G36VAG36";
_unit addPrimaryWeaponItem "RH_eothhs1";
// Handgun
_unit addMagazine "RH_12Rnd_45cal_usp";
_unit addWeapon "RH_usp";
_unit addHandgunItem "RH_X300";
// Binoc
_unit addWeapon "ACE_Yardage450";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "FP_Helmet_Flecktarn";
_unit forceAddUniform "CUP_U_B_GER_Flecktarn_1";
_unit addVest "CUP_V_B_GER_Carrier_Vest_3";
_unit addBackpack "CUP_B_GER_Pack_Flecktarn";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

// Uniform items
_unit addItemToUniform "ACE_microDAGR";
_unit addItemToUniform "ACE_epinephrine";
_unit addItemToUniform "ACE_HuntIR_monitor";
_unit addItemToUniform "RH_12Rnd_45cal_usp";
{_unit addItemToUniform "ACE_morphine"} count [1,2];
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
// Vest items
{_unit addItemToVest "HandGrenade"} count [1,2];
{_unit addItemToVest "hlc_30rnd_556x45_EPR_G36"} count [1,2,3,4,5,6];
{_unit addItemToVest "hlc_30rnd_556x45_Tracers_G36"} count [1,2,3,4];
// Backpack items
_unit addItemToBackpack "SmokeShellGreen";
{_unit addItemToBackpack "ACE_HuntIR_M203"} count [1,2,3,4];
{_unit addItemToBackpack "1Rnd_Smoke_Grenade_shell"} count [1,2];
{_unit addItemToBackpack "1Rnd_SmokeRed_Grenade_shell"} count [1,2];
{_unit addItemToBackpack "1Rnd_SmokeGreen_Grenade_shell"} count [1,2];
{_unit addItemToBackpack "1Rnd_HE_Grenade_shell"} count [1,2,3,4,5,6,7,8,9,10,11];
// Radios
_unit addItemToUniform "ACRE_PRC343";
_unit addItemToUniform "ACRE_PRC148";