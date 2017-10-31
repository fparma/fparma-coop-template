params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MX_pointer_F";
_unit addPrimaryWeaponItem "optic_Aco";
// Handgun
_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "H_HelmetB_light_desert";
_unit forceAddUniform "U_B_CombatUniform_mcam_tshirt";
_unit addVest "V_PlateCarrier1_rgr";
_unit addBackpack "B_Kitbag_rgr";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

// Uniform items
{_unit addItemToUniform "ACE_epinephrine"} count [1,2];
{_unit addItemToUniform "ACE_morphine"} count [1,2];
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
// Vest items
_unit addItemToVest "NVGoggles";
_unit addItemToVest "SmokeShell";
_unit addItemToVest "16Rnd_9x21_Mag";
_unit addItemToVest "ACE_Flashlight_MX991";
{_unit addItemToVest "HandGrenade"} count [1,2];
{_unit addItemToVest "SmokeShellGreen"} count [1,2,3,4];
{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5,6,7];
// Backpack items
{_unit addItemToBackpack "ACE_bloodIV"} count [1,2,3,4];
{_unit addItemToBackpack "ACE_bloodIV_500"} count [1,2,3,4,5,6];
{_unit addItemToBackpack "ACE_epinephrine"} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22];
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26];
{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30];
// Radios
_unit addItemToUniform "ACRE_PRC343";