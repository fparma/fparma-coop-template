params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MX_ACO_pointer_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Aco";
// Handgun
_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
// Binoc
_unit addWeapon "Rangefinder";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "H_HelmetB_light";
_unit forceAddUniform "U_B_CombatUniform_mcam_tshirt";
_unit addVest "V_Chestrig_rgr";
_unit addBackpack "B_Carryall_mcamo_AAT";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","NVGoggles"];

// Uniform items
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "30Rnd_65x39_caseless_mag";
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
// Vest items
_unit addItemToVest "SmokeShell";
_unit addItemToVest "16Rnd_9x21_Mag";
_unit addItemToVest "SmokeShellGreen";
{_unit addItemToVest "HandGrenade"} count [1,2];
{_unit addItemToVest "B_IR_Grenade"} count [1,2];
{_unit addItemToVest "Chemlight_green"} count [1,2];
{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5];
// Backpack items
{_unit addItemToBackpack "Titan_AT"} count [1,2];
{_unit addItemToBackpack "Titan_AP"} count [1,2];

_unit addItemToUniform "ACRE_PRC343";
