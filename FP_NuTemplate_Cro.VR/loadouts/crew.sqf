params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MXC_F";
_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
removeBackpack _unit;

_unit addHeadgear "H_HelmetCrew_B";
_unit forceAddUniform "U_B_CombatUniform_mcam_vest";
_unit addVest "V_BandollierB_rgr";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
_unit addItemToUniform "ACE_epinephrine";
{_unit addItemToUniform "ACE_morphine"} count [1,2,3];
{_unit addItemToUniform "16Rnd_9x21_Mag"} count [1,2];

_unit addItemToVest "ACE_Flashlight_MX991";
{_unit addItemToVest "30Rnd_65x39_caseless_mag"} count [1,2,3,4];
_unit addItemToVest "HandGrenade";
_unit addItemToVest "SmokeShell";

_unit addItemToUniform "ItemRadio";
_unit addItemToUniform "ACRE_PRC148";
