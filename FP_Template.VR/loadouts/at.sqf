params ["_unit", "_type"];

_unit addHeadgear "H_HelmetB_light_desert";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrier1_rgr";
_unit addBackpack "B_AssaultPack_mcamo_AT";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [0,1];
_unit addItemToUniform "ACE_morphine";
{_unit addItemToUniform "30Rnd_65x39_caseless_mag"} count [0,1];

{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [0,1,2];
{_unit addItemToVest "16Rnd_9x21_Mag"} count [0,1];
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
{_unit addItemToVest "Chemlight_green"} count [0,1];

{_unit addItemToBackpack "Titan_AT"} count [0,1];
_unit addItemToBackpack "Titan_AP";

_unit addWeapon "arifle_MXC_Holo_pointer_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Holosight";

_unit addWeapon "launch_B_Titan_short_F";
_unit addWeapon "hgun_P07_F";

_unit addItemToUniform "ItemRadio";
