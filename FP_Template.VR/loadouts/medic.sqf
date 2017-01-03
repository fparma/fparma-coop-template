params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MX_pointer_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
// Handgun
_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "H_HelmetB_light_desert";
_unit forceAddUniform "U_B_CombatUniform_mcam_tshirt";
_unit addVest "V_PlateCarrierSpec_rgr";
_unit addBackpack "B_AssaultPack_rgr_Medic";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","NVGoggles"];

// Uniform items
_unit addItemToUniform "30Rnd_65x39_caseless_mag";
// Vest items
_unit addItemToVest "SmokeShell";
_unit addItemToVest "16Rnd_9x21_Mag";
_unit addItemToVest "SmokeShellBlue";
_unit addItemToVest "SmokeShellGreen";
_unit addItemToVest "SmokeShellOrange";
{_unit addItemToVest "Chemlight_green"} count [1,2];
{_unit addItemToVest "ACE_morphine"} count [1,2,3,4,5];
{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [1,2,3];
{_unit addItemToVest "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
// Backpack items
{_unit addItemToBackpack "ACE_bloodIV"} count [1,2];
{_unit addItemToBackpack "ACE_epinephrine"} count [1,2,3,4];
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3,4,5,6];
{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14];

_unit addItemToUniform "ACRE_PRC343";
