params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "20Rnd_762x51_Mag";
_unit addWeapon "srifle_EBR_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Nightstalker";
_unit addPrimaryWeaponItem "bipod_01_F_snd";

_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
removeBackpack _unit;

_unit addHeadgear "H_Cap_headphones";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrier1_rgr";
_unit addBackpack "B_FieldPack_oli";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","ItemGPS","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
_unit addItemToUniform "ACE_epinephrine";
_unit addItemToUniform "ACE_Flashlight_MX991";
{_unit addItemToUniform "ACE_morphine"} count [1,2,3];
_unit addItemToUniform "B_IR_Grenade";
{_unit addItemToUniform "SmokeShell"} count [1,2];

_unit addItemToVest "16Rnd_9x21_Mag";
{_unit addItemToVest "HandGrenade"} count [1,2];
_unit addItemToVest "SmokeShell";
{_unit addItemToVest "20Rnd_762x51_Mag"} count [1,2,3,4,5,6,7,8];
/*LONG HAUL KIT*/
{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
_unit addItemToBackpack "ACE_epinephrine";
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3];
{_unit addItemToBackpack "SmokeShell"} count [1,2];
_unit addItemToBackpack "16Rnd_9x21_Mag";
{_unit addItemToBackpack "20Rnd_762x51_Mag"} count [1,2,3,4,5];
/*LONG HAUL KIT*/

_unit addItemToUniform "ItemRadio";
