params ["_unit", "_type"];

_unit addHeadgear "H_HelmetB_grass";
_unit forceAddUniform "U_B_CombatUniform_mcam_tshirt";
_unit addVest "V_PlateCarrier2_rgr";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [0,1];
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "SmokeShell";
_unit addItemToUniform "HandGrenade";
_unit addItemToUniform "SmokeShellGreen";
_unit addItemToUniform "Chemlight_green";

{_unit addItemToVest "100Rnd_65x39_caseless_mag"} count [0,1,2,3,4];
{_unit addItemToVest "16Rnd_9x21_Mag"} count [0,1];
_unit addItemToVest "Chemlight_green";

_unit addWeapon "arifle_MX_SW_pointer_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "bipod_01_F_snd";

_unit addWeapon "hgun_P07_F";

_unit addItemToUniform "ItemRadio";
