params ["_unit", "_type"];

_unit addHeadgear "H_HelmetB_grass";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrier1_rgr";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [0,1];
_unit addItemToUniform "ACE_morphine";
{_unit addItemToUniform "30Rnd_65x39_caseless_mag"} count [0,1];

{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [0,1,2,3,4];
{_unit addItemToVest "16Rnd_9x21_Mag"} count [0,1];
{_unit addItemToVest "HandGrenade"} count [0,1];
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
{_unit addItemToVest "Chemlight_green"} count [0,1];

_unit addWeapon "arifle_MXM_Hamr_LP_BI_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Hamr";
_unit addPrimaryWeaponItem "bipod_01_F_snd";

_unit addWeapon "hgun_P07_F";

_unit addItemToUniform "ItemRadio";
