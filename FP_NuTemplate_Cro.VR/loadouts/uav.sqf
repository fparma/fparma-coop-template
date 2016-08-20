params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MX_Hamr_pointer_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Hamr";

_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
removeBackpack _unit;

_unit addHeadgear "H_MilCap_blk";
_unit forceAddUniform "U_B_CombatUniform_mcam_vest";
_unit addVest "V_Chestrig_rgr";
_unit addBackpack "B_UAV_01_backpack_F";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemWatch","ItemGPS","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
_unit addItemToUniform "ACE_epinephrine";
{_unit addItemToUniform "ACE_morphine"} count [1,2,3];
_unit addItemToUniform "ACE_Flashlight_MX991";
_unit addItemToUniform "SmokeShell";
_unit addItemToUniform "B_IR_Grenade";
_unit addItemToUniform "16Rnd_9x21_Mag";
/*LONG HAUL KIT*/
{_unit addItemToVest "ACE_morphine"} count [1,2,3];
_unit addItemToVest "ACE_epinephrine";
{_unit addItemToVest "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
/*LONG HAUL KIT*/
_unit addItemToVest "B_UavTerminal";
{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5,6,7,8,9,10];
_unit addItemToVest "16Rnd_9x21_Mag";


_unit addItemToUniform "ItemRadio";
