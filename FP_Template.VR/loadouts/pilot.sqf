params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Handgun
_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "H_PilotHelmetFighter_B";
_unit forceAddUniform "U_B_PilotCoveralls";
_unit addBackpack "B_AssaultPack_rgr";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","ItemGPS"];

// Uniform items
_unit addItemToUniform "ACE_microDAGR";
_unit addItemToUniform "ACE_epinephrine";
_unit addItemToUniform "Chemlight_green";
_unit addItemToUniform "SmokeShellOrange";
_unit addItemToUniform "ACE_Flashlight_MX991";;
{_unit addItemToUniform "ACE_morphine"} count [1,2];
{_unit addItemToUniform "16Rnd_9x21_Mag"} count [1,2,3];
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4];

// Radios
_unit addItemToUniform "ACRE_PRC343";
_unit addItemToBackpack "ACRE_PRC117F";
