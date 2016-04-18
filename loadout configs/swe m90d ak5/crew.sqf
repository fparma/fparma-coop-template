params ["_unit", "_type"];

_unit addHeadgear "H_HelmetCrew_B";
_unit forceAddUniform "FP_Uniform_M90Des";
_unit addVest "V_BandollierB_rgr";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [0,1];
_unit addItemToUniform "ACE_morphine";
{_unit addItemToUniform "30Rnd_65x39_caseless_mag"} count [0,1];

{_unit addItemToVest "30Rnd_556x45_Stanag"} count [1,2,3];
_unit addItemToVest "SmokeShell";

_unit addWeapon "SAM_AK5D";
_unit addItemToUniform "ItemRadio";

{_unit addItem "RH_17Rnd_9x19_g17"} count [1,2];
_unit addWeapon "RH_g17";
