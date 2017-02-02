params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MX_F";
_unit addPrimaryWeaponItem "muzzle_snds_H";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Hamr";
_unit addPrimaryWeaponItem "bipod_01_F_snd";

_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
_unit addWeapon "Laserdesignator_03";
_unit addMagazine "Laserbatteries";
removeBackpack _unit;

_unit addHeadgear "H_MilCap_mcamo";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrier1_blk";
_unit addBackpack "B_FieldPack_blk";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemCompass","ItemWatch","ItemGPS","ItemMap","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
{_unit addItemToUniform "ACE_morphine"} count [1,2,3];
_unit addItemToUniform "ACE_epinephrine";
_unit addItemToUniform "ACE_Flashlight_MX991";
_unit addItemToUniform "ACE_RangeCard";
_unit addItemToUniform "Laserbatteries";

{_unit addItemToVest "HandGrenade"} count [1,2];
_unit addItemToVest "SmokeShell";
{_unit addItemToVest "16Rnd_9x21_Mag"} count [1,2];
{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5];
{_unit addItemToVest "30Rnd_65x39_caseless_mag_Tracer"} count [1,2,3];

_unit addItemToBackpack "ACE_SpottingScope";
{_unit addItemToBackpack "7Rnd_408_Mag"} count [1,2];
/*LONG HAUL KIT*/
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3];
_unit addItemToBackpack "ACE_epinephrine";
{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
{_unit addItemToBackpack "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5];
/*LONG HAUL KIT*/

_unit addItemToUniform "ItemRadio";
