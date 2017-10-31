params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "130Rnd_338_Mag";
_unit addWeapon "MMG_02_sand_RCO_LP_F";
_unit addPrimaryWeaponItem "optic_Hamr";
_unit addPrimaryWeaponItem "bipod_01_F_snd";
// Handgun
_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "H_HelmetB";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrier1_rgr";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

// Uniform items
_unit addItemToUniform "ACE_Flashlight_MX991";
{_unit addItemToUniform "16Rnd_9x21_Mag"} count [1,2];
{_unit addItemToUniform "SmokeShellGreen"} count [1,2];
{_unit addItemToUniform "ACE_epinephrine"} count [1,2];
{_unit addItemToUniform "ACE_morphine"} count [1,2];
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
// Vest items
_unit addItemToVest "NVGoggles";
{_unit addItemToVest "130Rnd_338_Mag"} count [1,2];
// Radios
_unit addItemToUniform "ACRE_PRC343";