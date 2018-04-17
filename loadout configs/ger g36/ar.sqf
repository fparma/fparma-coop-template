// ["B_RangeMaster_F", "example.sqf"]
params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "CUP_100Rnd_TE1_Red_Tracer_556x45_BetaCMag";
_unit addWeapon "hlc_rifle_G36V_CMAG";
_unit addPrimaryWeaponItem "RH_eotech553mag";
_unit addPrimaryWeaponItem "RH_HBLM";
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
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

// Uniform items
_unit addItemToUniform "HandGrenade";
_unit addItemToUniform "ACE_epinephrine";
_unit addItemToUniform "SmokeShellGreen";
_unit addItemToUniform "RH_12Rnd_45cal_usp";
{_unit addItemToUniform "ACE_morphine"} count [1,2];
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
// Vest items
_unit addItemToVest "HandGrenade";
{_unit addItemToVest "CUP_100Rnd_TE1_Red_Tracer_556x45_BetaCMag"} count [1,2];
// Radios
_unit addItemToUniform "ACRE_PRC343";