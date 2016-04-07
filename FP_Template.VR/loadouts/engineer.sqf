params ["_unit", "_type"];

_unit addHeadgear "H_HelmetB_desert";
_unit forceAddUniform "U_B_CombatUniform_mcam_vest";
_unit addVest "V_Chestrig_rgr";
_unit addBackpack "B_Kitbag_mcamo_Eng";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","NVGoggles"];

_unit addItemToUniform "ACE_Clacker";
_unit addItemToUniform "ACE_DefusalKit";
{_unit addItemToUniform "ACE_fieldDressing"} count [0,1];
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "30Rnd_65x39_caseless_mag";
_unit addItemToUniform "Chemlight_green";

{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [0,1,2,3];
{_unit addItemToVest "16Rnd_9x21_Mag"} count [0,1];
{_unit addItemToVest "HandGrenade"} count [0,1];
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
_unit addItemToVest "SmokeShellBlue";
_unit addItemToVest "SmokeShellOrange";
_unit addItemToVest "Chemlight_green";

_unit addItemToBackpack "ToolKit";
_unit addItemToBackpack "MineDetector";
_unit addItemToBackpack "SatchelCharge_Remote_Mag";
{_unit addItemToBackpack "DemoCharge_Remote_Mag"} count [0,1];

_unit addWeapon "arifle_MXC_Holo_pointer_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Holosight";

_unit addWeapon "hgun_P07_F";

_unit addItemToUniform "ItemRadio";
