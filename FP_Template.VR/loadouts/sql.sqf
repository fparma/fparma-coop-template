params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addMagazine "3Rnd_HE_Grenade_shell";
_unit addWeapon "arifle_MX_GL_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Hamr";
// Handgun
_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
// Binoc
_unit addWeapon "Rangefinder";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "H_HelmetSpecB";
_unit forceAddUniform "U_B_CombatUniform_mcam_vest";
_unit addVest "V_PlateCarrierSpec_rgr";
_unit addBackpack "B_AssaultPack_rgr";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

// Uniform items
_unit addItemToUniform "ACE_MapTools";
_unit addItemToUniform "ACE_microDAGR";
_unit addItemToUniform "ACE_HuntIR_monitor";
// Vest items
_unit addItemToVest "16Rnd_9x21_Mag";
{_unit addItemToVest "SmokeShellGreen"} count [1,2];
{_unit addItemToVest "HandGrenade"} count [1,2];
{_unit addItemToVest "ACE_epinephrine"} count [1,2];
{_unit addItemToVest "ACE_morphine"} count [1,2];
{_unit addItemToVest "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
{_unit addItemToVest "30Rnd_65x39_caseless_mag_Tracer"} count [1,2,3,4];
// Backpack items
_unit addItemToBackpack "B_IR_Grenade";
_unit addItemToBackpack "ACE_NVG_Gen4";
{_unit addItemToBackpack "ACE_HuntIR_M203"} count [1,2,3,4];
{_unit addItemToBackpack "3Rnd_HE_Grenade_shell"} count [1,2];
{_unit addItemToBackpack "30Rnd_65x39_caseless_mag"} count [1,2,3,4];
{_unit addItemToBackpack "1Rnd_SmokeRed_Grenade_shell"} count [1,2];
{_unit addItemToBackpack "1Rnd_SmokeOrange_Grenade_shell"} count [1,2];
// Radios
_unit addItemToUniform "ACRE_PRC148";
_unit addItemToUniform "ACRE_PRC343";