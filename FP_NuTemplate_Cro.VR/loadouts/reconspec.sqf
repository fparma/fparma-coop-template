params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MX_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Aco";

_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
_unit addHandgunItem "muzzle_snds_L";
_unit addWeapon "ACE_MX2A";
removeBackpack _unit;

_unit addHeadgear "H_HelmetB_light_black";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_Chestrig_blk";
_unit addBackpack "B_AssaultPack_blk";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","NVGoggles","ItemGPS"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
{_unit addItemToUniform "ACE_morphine"} count [1,2,3,4,5];
{_unit addItemToUniform "ACE_epinephrine"} count [1,2,3];
_unit addItemToUniform "ACE_Flashlight_MX991";
_unit addItemToUniform "ACE_DefusalKit";
_unit addItemToUniform "16Rnd_9x21_Mag";

{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5,6,7,8,9,10,11];
_unit addItemToVest "SmokeShell";
{_unit addItemToVest "MiniGrenade"} count [1,2,3,4];
/*LONG HAUL KIT*/
{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
_unit addItemToBackpack "ACE_epinephrine";
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3];
/*LONG HAUL KIT*/
/*SPECIALIST KIT*/
_unit addItemToBackpack "B_UavTerminal";
_unit addItemToBackpack "ACE_Clacker";
_unit addItemToBackpack "SatchelCharge_Remote_Mag";
{_unit addItemToBackpack "DemoCharge_Remote_Mag"} count [1,2];
/*SPECIALIST KIT*/

_unit addItemToUniform "ItemRadio";
