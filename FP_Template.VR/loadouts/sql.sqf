params ["_unit", "_type"];

_unit addHeadgear "H_HelmetB_desert";
_unit forceAddUniform "U_B_CombatUniform_mcam_vest";
_unit addVest "V_PlateCarrierGL_rgr";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","ItemGPS","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [0,1];
_unit addItemToUniform "ACE_morphine";
{_unit addItemToUniform "30Rnd_65x39_caseless_mag"} count [0,1];
_unit addItemToUniform "ACE_MapTools";

_unit addItemToVest "30Rnd_65x39_caseless_mag";
{_unit addItemToVest "30Rnd_65x39_caseless_mag_Tracer"} count [0,1];
{_unit addItemToVest "16Rnd_9x21_Mag"} count [0,1];
{_unit addItemToVest "HandGrenade"} count [0,1];
{_unit addItemToVest "B_IR_Grenade"} count [0,1];
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
_unit addItemToVest "SmokeShellBlue";
_unit addItemToVest "SmokeShellOrange";
{_unit addItemToVest "Chemlight_green"} count [0,1];

_unit addWeapon "arifle_MX_Hamr_pointer_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "optic_Hamr";

_unit addWeapon "hgun_P07_F";
_unit addWeapon "Binocular";

_unit addItemToUniform "ItemRadio";
if (_type != "B_Soldier_TL_F") then {
  _unit addItemToUniform "ACRE_PRC148";
};
