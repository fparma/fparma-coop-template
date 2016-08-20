params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MX_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Hamr";

_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
_unit addHandgunItem "muzzle_snds_L";
removeBackpack _unit;

_unit addHeadgear "H_HelmetSpecB_blk";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierGL_blk";
_unit addBackpack "B_FieldPack_blk";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","ItemGPS","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
{_unit addItemToUniform "ACE_morphine"} count [1,2,3];
_unit addItemToUniform "ACE_epinephrine";
_unit addItemToUniform "ACE_Flashlight_MX991";
_unit addItemToUniform "ACE_SpraypaintRed";
{_unit addItemToUniform "SmokeShell"} count [1,2];

{_unit addItemToVest "16Rnd_9x21_Mag"} count [1,2];
{_unit addItemToVest "MiniGrenade"} count [1,2];
{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5,6,7,8,9,10,11];
/*LONG HAUL KIT*/
{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
_unit addItemToBackpack "ACE_epinephrine";
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3];
{_unit addItemToBackpack "ACE_CableTie"} count [1,2,3,4,5];
{_unit addItemToBackpack "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5,6,7,8];
{_unit addItemToBackpack "MiniGrenade"} count [1,2];
{_unit addItemToBackpack "SmokeShell"} count [1,2];
/*LONG HAUL KIT*/

_unit addItemToUniform "ItemRadio";
