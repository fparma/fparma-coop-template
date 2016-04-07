params ["_unit", "_type"];

_unit addHeadgear "H_HelmetB_light";
_unit forceAddUniform "U_B_CombatUniform_mcam_tshirt";
_unit addVest "V_Chestrig_rgr";
_unit addBackpack "B_Carryall_mcamo_AAT";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [0,1];
_unit addItemToUniform "ACE_morphine";
{_unit addItemToUniform "30Rnd_65x39_caseless_mag"} count [0,1];

{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [0,1,2,3,4];
{_unit addItemToVest "16Rnd_9x21_Mag"} count [0,1];
{_unit addItemToVest "HandGrenade"} count [0,1];
{_unit addItemToVest "B_IR_Grenade"} count [0,1];
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
{_unit addItemToVest "Chemlight_green"} count [0,1];

{_unit addItemToBackpack "Titan_AT"} count [0,1];
{_unit addItemToBackpack "Titan_AP"} count [0,1];

_unit addWeapon "arifle_MX_ACO_pointer_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Aco";

_unit addWeapon "hgun_P07_F";
_unit addWeapon "Rangefinder";

_unit addItemToUniform "ItemRadio";
