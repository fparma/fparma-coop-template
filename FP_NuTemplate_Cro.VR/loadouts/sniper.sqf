params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "7Rnd_408_Mag";
_unit addWeapon "srifle_LRR_F";
_unit addPrimaryWeaponItem "optic_LRPS";
_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
_unit addHandgunItem "muzzle_snds_L";
removeBackpack _unit;

_unit addHeadgear "H_MilCap_mcamo";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrier1_blk";
_unit addBackpack "B_FieldPack_blk";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","ItemGPS","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
{_unit addItemToUniform "ACE_morphine"} count [1,2,3];
{_unit addItemToUniform "ACE_epinephrine"} count [1,2];
_unit addItemToUniform "ACE_Flashlight_MX991";
{_unit addItemToUniform "16Rnd_9x21_Mag"} count [1,2,3];

_unit addItemToVest "RH_anpvs4";
_unit addItemToVest "ACE_RangeCard";
{_unit addItemToVest "HandGrenade"} count [1,2];
_unit addItemToVest "SmokeShell";
{_unit addItemToVest "7Rnd_408_Mag"} count [1,2];
/*LONG HAUL KIT*/
{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
_unit addItemToBackpack "ACE_epinephrine";
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3];
{_unit addItemToBackpack "7Rnd_408_Mag"} count [1,2];
_unit addItemToBackpack "SmokeShell";
_unit addItemToBackpack "HandGrenade";
/*LONG HAUL KIT*/

_unit addItemToUniform "ItemRadio";
