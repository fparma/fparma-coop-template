// ["B_RangeMaster_F", "example.sqf"]
params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "hlc_30rnd_556x45_Tracers_G36";
_unit addWeapon "hlc_rifle_G36CV";
_unit addPrimaryWeaponItem "optic_Aco";
// Handgun
_unit addMagazine "RH_12Rnd_45cal_usp";
_unit addWeapon "RH_usp";
_unit addHandgunItem "RH_X300";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "FP_Helmet_Flecktarn";
_unit forceAddUniform "CUP_U_B_GER_Flecktarn_1";
_unit addVest "CUP_V_B_GER_Carrier_Vest";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

// Uniform items
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "SmokeShellGreen";
_unit addItemToUniform "RH_12Rnd_45cal_usp";
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4];
// Vest items
_unit addItemToVest "HandGrenade";
{_unit addItemToVest "hlc_30rnd_556x45_Tracers_G36"} count [1,2,3,4,5,6,7,8,9];