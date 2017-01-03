params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "100Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MX_SW_pointer_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "bipod_01_F_snd";
// Handgun
_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "H_HelmetB_grass";
_unit forceAddUniform "U_B_CombatUniform_mcam_tshirt";
_unit addVest "V_PlateCarrier2_rgr";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","NVGoggles"];

// Uniform items
_unit addItemToUniform "SmokeShell";
_unit addItemToUniform "HandGrenade";
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "SmokeShellGreen";
_unit addItemToUniform "Chemlight_green";
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
// Vest items
_unit addItemToVest "16Rnd_9x21_Mag";
_unit addItemToVest "Chemlight_green";
{_unit addItemToVest "100Rnd_65x39_caseless_mag"} count [1,2,3,4];
_unit addItemToUniform "ACRE_PRC343";
