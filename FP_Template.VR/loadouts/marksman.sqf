params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "20Rnd_762x51_Mag";
_unit addWeapon "srifle_EBR_F";
_unit addPrimaryWeaponItem "optic_DMS";
// Handgun
_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "H_Booniehat_mcamo";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrier1_rgr";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

// Uniform items
_unit addItemToUniform "ACE_Flashlight_MX991";
_unit addItemToUniform "ACE_microDAGR";
_unit addItemToUniform "ACE_MapTools";
_unit addItemToUniform "16Rnd_9x21_Mag";
{_unit addItemToUniform "ACE_epinephrine"} count [1,2];
{_unit addItemToUniform "ACE_morphine"} count [1,2];
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
// Vest items
_unit addItemToVest "NVGoggles";
{_unit addItemToVest "HandGrenade"} count [1,2];
{_unit addItemToVest "SmokeShellGreen"} count [1];
{_unit addItemToVest "20Rnd_762x51_Mag"} count [1,2,3,4,5,6,7];
// Radios
_unit addItemToUniform "ACRE_PRC343";