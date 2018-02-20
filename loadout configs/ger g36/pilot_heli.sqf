// ["B_Helipilot_F", "example.sqf"]
params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "hlc_30Rnd_9x19_B_MP5";
_unit addWeapon "hlc_smg_mp5k_PDW";
// Handgun
_unit addMagazine "RH_12Rnd_45cal_usp";
_unit addWeapon "RH_usp";
_unit addHandgunItem "RH_X300";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "H_PilotHelmetHeli_O";
_unit forceAddUniform "CUP_U_B_GER_Flecktarn_2";
_unit addVest "CUP_V_B_GER_Carrier_Vest";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

// Uniform items
_unit addItemToUniform "ACE_epinephrine";
_unit addItemToUniform "SmokeShellGreen";
{_unit addItemToUniform "ACE_morphine"} count [1,2];
{_unit addItemToUniform "RH_12Rnd_45cal_usp"} count [1,2];
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
// Vest items
{_unit addItemToVest "SmokeShellGreen"} count [1,2];
{_unit addItemToVest "hlc_30Rnd_9x19_B_MP5"} count [1,2,3,4];
// Backpack items
// Radios
_unit addItemToUniform "ACRE_PRC343";

if (str _unit == "l0") then {
	_unit addBackpack "B_AssaultPack_tna_F";
	_unit addItemToBackpack "ACRE_PRC117F";
};