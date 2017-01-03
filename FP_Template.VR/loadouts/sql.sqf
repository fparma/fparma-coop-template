params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MX_Hamr_pointer_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Hamr";
// Handgun
_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
// Binoc
_unit addWeapon "Binocular";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "H_HelmetB_desert";
_unit forceAddUniform "U_B_CombatUniform_mcam_vest";
_unit addVest "V_PlateCarrierGL_rgr";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","ItemGPS","NVGoggles"];

// Uniform items
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "ACE_MapTools";
_unit addItemToUniform "30Rnd_65x39_caseless_mag";
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
// Vest items
_unit addItemToVest "SmokeShell";
_unit addItemToVest "16Rnd_9x21_Mag";
_unit addItemToVest "SmokeShellBlue";
_unit addItemToVest "SmokeShellGreen";
_unit addItemToVest "SmokeShellOrange";
_unit addItemToVest "30Rnd_65x39_caseless_mag";
{_unit addItemToVest "HandGrenade"} count [1,2];
{_unit addItemToVest "B_IR_Grenade"} count [1,2];
{_unit addItemToVest "Chemlight_green"} count [1,2];
{_unit addItemToVest "30Rnd_65x39_caseless_mag_Tracer"} count [1,2];

// Radios
_unit addItemToUniform "ACRE_PRC343";
if (_type != "B_Soldier_TL_F") then {
  _unit addItemToUniform "ACRE_PRC148";
};
