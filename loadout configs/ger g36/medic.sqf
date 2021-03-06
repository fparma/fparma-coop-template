// ["B_RangeMaster_F", "example.sqf"]
params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "hlc_30rnd_556x45_EPR_G36";
_unit addWeapon "hlc_rifle_G36CV";
_unit addPrimaryWeaponItem "RH_eothhs1";
// Handgun
_unit addMagazine "RH_12Rnd_45cal_usp";
_unit addWeapon "RH_usp";
_unit addHandgunItem "RH_X300";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "FP_Helmet_Flecktarn";
_unit forceAddUniform "CUP_U_B_GER_Flecktarn_2";
_unit addVest "CUP_V_B_GER_Carrier_Rig_2";
_unit addBackpack "CUP_B_GER_Pack_Flecktarn";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

// Uniform items
_unit addItemToUniform "ACE_epinephrine";
_unit addItemToUniform "SmokeShellGreen";
_unit addItemToUniform "ACE_EntrenchingTool";
{_unit addItemToUniform "ACE_morphine"} count [1,2];
{_unit addItemToUniform "RH_12Rnd_45cal_usp"} count [1,2];
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
// Vest items
{_unit addItemToVest "HandGrenade"} count [1,2];
{_unit addItemToVest "SmokeShellGreen"} count [1,2,3,4];
{_unit addItemToVest "hlc_30rnd_556x45_EPR_G36"} count [1,2,3,4];
{_unit addItemToVest "hlc_30rnd_556x45_Tracers_G36"} count [1,2];
// Backpack items
{_unit addItemToBackpack "ACE_bloodIV"} count [1,2,3,4,5];
{_unit addItemToBackpack "ACE_bloodIV_500"} count [1,2,3,4,5,6,7,8,9,10];
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30];
{_unit addItemToBackpack "ACE_epinephrine"} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30];
{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30];
// Radios
_unit addItemToUniform "ACRE_PRC343";