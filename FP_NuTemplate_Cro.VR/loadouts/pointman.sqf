params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MX_F";
_unit addPrimaryWeaponItem "optic_Holosight";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addWeapon "Binocular";
removeBackpack _unit;

_unit addHeadgear "H_HelmetSpecB_blk";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrier1_rgr";
_unit addBackpack "B_AssaultPack_rgr";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","ItemGPS","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
{_unit addItemToUniform "ACE_morphine"} count [1,2,3];
_unit addItemToUniform "ACE_epinephrine";
_unit addItemToUniform "ACE_Flashlight_MX991";
{_unit addItemToUniform "Chemlight_green"} count [1,2];
{_unit addItemToUniform "ACE_HandFlare_Green"} count [1,2];

{_unit addItemToVest "30Rnd_65x39_caseless_mag_Tracer"} count [1,2,3];
{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5];
_unit addItemToVest "B_IR_Grenade";
{_unit addItemToVest "HandGrenade"} count [1,2,3];
{_unit addItemToVest "SmokeShell"} count [1,2];
/*LONG HAUL KIT*/
{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
_unit addItemToBackpack "ACE_epinephrine";
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3];
{_unit addItemToBackpack "30Rnd_65x39_caseless_mag"} count [1,2,3];
_unit addItemToBackpack "B_IR_Grenade";
{_unit addItemToBackpack "HandGrenade"} count [1,2,3];
{_unit addItemToBackpack "SmokeShell"} count [1,2];
{_unit addItemToBackpack "30Rnd_65x39_caseless_mag_Tracer"} count [1,2];
/*LONG HAUL KIT*/

_unit addItemToUniform "ItemRadio";
