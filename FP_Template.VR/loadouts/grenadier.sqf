params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addMagazine "1Rnd_HE_Grenade_shell";
_unit addWeapon "arifle_MX_GL_ACO_F";
_unit addPrimaryWeaponItem "optic_Aco";
_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
removeBackpack _unit;

_unit addHeadgear "H_HelmetSpecB_blk";
_unit forceAddUniform "U_B_CombatUniform_mcam";
_unit addVest "V_PlateCarrierGL_rgr";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
_unit addItemToUniform "ACE_morphine";
{_unit addItemToUniform "30Rnd_65x39_caseless_mag"} count [1,2];

{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [1,2,3];
{_unit addItemToVest "16Rnd_9x21_Mag"} count [1,2];
{_unit addItemToVest "1Rnd_HE_Grenade_shell"} count [1,2,3,4,5];
{_unit addItemToVest "HandGrenade"} count [1,2];
{_unit addItemToVest "MiniGrenade"} count [1,2];
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
{_unit addItemToVest "Chemlight_green"} count [1,2];
{_unit addItemToVest "1Rnd_Smoke_Grenade_shell"} count [1,2];
_unit addItemToVest "1Rnd_SmokeBlue_Grenade_shell";
_unit addItemToVest "1Rnd_SmokeGreen_Grenade_shell";
_unit addItemToVest "1Rnd_SmokeOrange_Grenade_shell";

_unit addItemToUniform "ItemRadio";
