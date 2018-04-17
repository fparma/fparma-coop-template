params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MX_ACO_pointer_F";
_unit addPrimaryWeaponItem "optic_Aco";
// Handgun
_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "H_HelmetB";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierSpec_rgr";
_unit addBackpack "B_UAV_01_backpack_F";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","B_UavTerminal"];

// Uniform items
_unit addItemToUniform "16Rnd_9x21_Mag";
_unit addItemToUniform "ACE_epinephrine";
{_unit addItemToUniform "ACE_morphine"} count [1,2];
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4];
// Vest items
_unit addItemToVest "NVGoggles";
_unit addItemToVest "SmokeShellGreen";
_unit addItemToVest "ACE_Flashlight_MX991";
{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5,6,7];
// Radios
_unit addItemToUniform "ACRE_PRC343";