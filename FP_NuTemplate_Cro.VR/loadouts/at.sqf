params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MXC_Holo_pointer_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Holosight";

_unit addMagazine "Titan_AT";
_unit addWeapon "launch_B_Titan_short_F";
_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
removeBackpack _unit;

_unit addHeadgear "H_HelmetB_light_desert";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrier1_rgr";
_unit addBackpack "B_Carryall_oli";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
{_unit addItemToUniform "ACE_morphine"} count [1,2,3];
_unit addItemToUniform "ACE_epinephrine";
_unit addItemToUniform "ACE_Flashlight_MX991";

{_unit addItemToVest "16Rnd_9x21_Mag"} count [1,2];
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5];
/*LONG HAUL KIT*/
{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3];
_unit addItemToBackpack "ACE_epinephrine";
{_unit addItemToBackpack "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5];
/*LONG HAUL KIT*/
_unit addItemToBackpack "Titan_AT";

_unit addItemToUniform "ItemRadio";
