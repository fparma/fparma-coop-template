params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "30Rnd_45ACP_Mag_SMG_01";
_unit addWeapon "SMG_01_Holo_F";
_unit addPrimaryWeaponItem "optic_Holosight_smg";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "H_PilotHelmetHeli_B";
_unit forceAddUniform "U_B_HeliPilotCoveralls";
_unit addVest "V_TacVest_blk";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

// Uniform items
_unit addItemToUniform "ACE_epinephrine";
{_unit addItemToUniform "ACE_morphine"} count [1,2];
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4];
_unit addItemToUniform "ACE_microDAGR";

// Vest items
_unit addItemToVest "NVGoggles";
_unit addItemToVest "Chemlight_green";
_unit addItemToVest "ACE_Flashlight_MX991";
{_unit addItemToVest "SmokeShellGreen"} count [1,2];
{_unit addItemToVest "30Rnd_45ACP_Mag_SMG_01"} count [1,2];

// Radios
_unit addItemToUniform "ACRE_PRC343";
_unit addItemToUniform "ACRE_PRC148";

if (_type == "B_Helipilot_F") then {
	_unit addBackpack "B_AssaultPack_rgr";
	clearAllItemsFromBackpack _unit;
	_unit addItemToBackpack "ACRE_PRC117F";
};