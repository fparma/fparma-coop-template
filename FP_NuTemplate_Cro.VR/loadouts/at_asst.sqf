params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MX_ACO_pointer_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Aco";

_unit addWeapon "Rangefinder";
removeBackpack _unit;

_unit addHeadgear "H_HelmetB_light";
_unit forceAddUniform "U_B_CombatUniform_mcam_tshirt";
_unit addVest "V_Chestrig_rgr";
_unit addBackpack "B_Carryall_oli";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemCompass","ItemWatch","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
_unit addItemToUniform "ACE_epinephrine";
_unit addItemToUniform "ACE_Flashlight_MX991";
{_unit addItemToUniform "ACE_morphine"} count [1,2,3];
_unit addItemToUniform "HandGrenade";
_unit addItemToUniform "SmokeShell";

{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5,6,7,8];
/*LONG HAUL KIT*/
{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
_unit addItemToBackpack "ACE_epinephrine";
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3];
{_unit addItemToBackpack "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5];
_unit addItemToBackpack "HandGrenade";
_unit addItemToBackpack "SmokeShell";
/*LONG HAUL KIT*/
{_unit addItemToBackpack "Titan_AT"} count [1,2];

_unit addItemToUniform "ItemRadio";
