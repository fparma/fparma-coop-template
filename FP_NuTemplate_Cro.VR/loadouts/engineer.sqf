params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MXC_Holo_pointer_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Holosight";

_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
removeBackpack _unit;

_unit addHeadgear "H_HelmetB_desert";
_unit forceAddUniform "U_B_CombatUniform_mcam_vest";
_unit addVest "V_Chestrig_rgr";
_unit addBackpack "B_Kitbag_mcamo_Eng";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemCompass","ItemWatch","NVGoggles"];

_unit addItemToUniform "ACE_DefusalKit";
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
{_unit addItemToUniform "ACE_morphine"} count [1,2,3];
_unit addItemToUniform "ACE_Flashlight_MX991";
_unit addItemToUniform "ACE_epinephrine";
_unit addItemToUniform "ACE_Clacker";
_unit addItemToUniform "Chemlight_green";

_unit addItemToVest "ACE_EntrenchingTool";
{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [1,2,3,4,5];
_unit addItemToVest "16Rnd_9x21_Mag";
_unit addItemToVest "HandGrenade";
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellBlue";
_unit addItemToVest "SmokeShellOrange";
_unit addItemToVest "Chemlight_green";
{_unit addItemToVest "B_IR_Grenade"} count [1,2,3];
{_unit addItemToVest "ACE_HandFlare_Red"} count [1,2,3];
_unit addItemToVest "SmokeShellRed";

_unit addItemToBackpack "ToolKit";
{_unit addItemToBackpack "MineDetector"} count [1];
_unit addItemToBackpack "SatchelCharge_Remote_Mag";
{_unit addItemToBackpack "DemoCharge_Remote_Mag"} count [1,2,3];

_unit addItemToUniform "ItemRadio";
