params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addMagazine "1Rnd_HE_Grenade_shell";
_unit addWeapon "arifle_MX_GL_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Holosight";

_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
_unit addWeapon "Laserdesignator_03";
_unit addMagazine "Laserbatteries";
removeBackpack _unit;

_unit addHeadgear "H_HelmetB_light_black";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierGL_blk";
_unit addBackpack "B_Carryall_oli";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","ItemGPS","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
{_unit addItemToUniform "ACE_morphine"} count [1,2,3];
_unit addItemToUniform "ACE_epinephrine";
_unit addItemToUniform "ACE_Flashlight_MX991";
{_unit addItemToUniform "Chemlight_red"} count [1,2];
_unit addItemToUniform "Laserbatteries";

_unit addItemToVest "SmokeShell";
{_unit addItemToVest "HandGrenade"} count [1,2];
{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5,6,7,8];
{_unit addItemToVest "1Rnd_HE_Grenade_shell"} count [1,2,3,4];
_unit addItemToVest "ACE_HuntIR_M203";

/*LONG HAUL KIT*/
{_unit addItemToBackpack "ACE_epinephrine"} count [1,2,3,4,5];
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3,4,5,6,7,8];
{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
{_unit addItemToBackpack "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5];
{_unit addItemToBackpack "1Rnd_HE_Grenade_shell"} count [1,2,3,4,5,6,7,8];
/*LONG HAUL KIT*/

_unit addItemToUniform "ItemRadio";
_unit addItemToUniform "ACRE_PRC148";
_unit addItemToBackpack "ACRE_PRC117F";
