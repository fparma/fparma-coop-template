params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MX_GL_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Hamr";

_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
_unit addWeapon "Laserdesignator_03";
_unit addMagazine "Laserbatteries";
removeBackpack _unit;

_unit addHeadgear "H_HelmetB_desert";
_unit forceAddUniform "U_B_CombatUniform_mcam_vest";
_unit addVest "V_PlateCarrier2_rgr";
_unit addBackpack "B_Kitbag_rgr";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","ItemGPS","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
_unit addItemToUniform "ACE_MapTools";
_unit addItemToUniform "ACE_epinephrine";
{_unit addItemToUniform "ACE_morphine"} count [1,2,3];
_unit addItemToUniform "ACE_Flashlight_MX991";
_unit addItemToUniform "Laserbatteries";

_unit addItemToVest "SmokeShellBlue";
_unit addItemToVest "SmokeShellRed";
_unit addItemToVest "HandGrenade";
_unit addItemToVest "16Rnd_9x21_Mag";
{_unit addItemToVest "B_IR_Grenade"} count [1,2];
{_unit addItemToVest "Chemlight_green"} count [1,2];
_unit addItemToVest "Laserbatteries";
_unit addItemToVest "SmokeShellPurple";
{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5,6];
{_unit addItemToVest "1Rnd_HE_Grenade_shell"} count [1,2,3,4];
{_unit addItemToVest "SmokeShell"} count [1,2];
/*LONG HAUL KIT*/
{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
_unit addItemToBackpack "ACE_epinephrine";
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3];
_unit addItemToBackpack "SmokeShellBlue";
_unit addItemToBackpack "SmokeShellPurple";
_unit addItemToBackpack "SmokeShellRed";
_unit addItemToBackpack "HandGrenade";
_unit addItemToBackpack "SmokeShell";
{_unit addItemToBackpack "1Rnd_HE_Grenade_shell"} count [1,2,3,4,5,6,7,8];
{_unit addItemToBackpack "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5];
/*LONG HAUL KIT*/
_unit addItemToUniform "ItemRadio";
_unit addItemToUniform "ACRE_PRC148";

if (_type == "B_B_Officer_F" || _type == "B_RangeMaster_F") then {
	_unit addItemToBackpack "ACRE_PRC117F";
};
