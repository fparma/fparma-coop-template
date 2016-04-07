params ["_unit", "_type"];

_unit addHeadgear "H_HelmetB_light_desert";
_unit forceAddUniform "U_B_CombatUniform_mcam_tshirt";
_unit addVest "V_PlateCarrierSpec_rgr";
_unit addBackpack "B_AssaultPack_rgr_Medic";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","NVGoggles"];

{_unit addItemToUniform "30Rnd_65x39_caseless_mag"} count [0,1];
{_unit addItemToVest "ACE_morphine"} count [0,1,2,3,4];
{_unit addItemToVest "ACE_fieldDressing"} count [0,1,2,3,4,5,6,7];
{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [0,1,2];
{_unit addItemToVest "16Rnd_9x21_Mag"} count [0,1];
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
_unit addItemToVest "SmokeShellBlue";
_unit addItemToVest "SmokeShellOrange";
{_unit addItemToVest "Chemlight_green"} count [0,1];

{_unit addItemToBackpack "ACE_fieldDressing"} count [0,1,2,3,4,5,6,7,8,9,10,11,12,13];
{_unit addItemToBackpack "ACE_morphine"} count [0,1,2,3,4,5];
{_unit addItemToBackpack "ACE_epinephrine"} count [0,1,2,3];
{_unit addItemToBackpack "ACE_bloodIV"} count [0,1];

_unit addWeapon "arifle_MX_pointer_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addWeapon "hgun_P07_F";

_unit addItemToVest "ItemRadio";
