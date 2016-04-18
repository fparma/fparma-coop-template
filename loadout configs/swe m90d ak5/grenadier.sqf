params ["_unit", "_type"];

_unit addHeadgear "FP_Helmet_M90Des";
_unit forceAddUniform "FP_Uniform_M90Des";
_unit addVest "FP_Carrier_GreenPatchless";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6];
_unit addItemToUniform "ACE_epinephrine";
{_unit addItemToUniform "ACE_morphine"} count [1,2];
{_unit addItemToUniform "CUP_HandGrenade_M67"} count [1,2];
{_unit addItemToUniform "SmokeShellGreen"} count [1,2];

{_unit addItemToVest "RH_30Rnd_556x45_M855A1"} count [1,2,3];
{_unit addItemToVest "1Rnd_HE_Grenade_shell"} count [1,2,3,4,5];
{_unit addItemToVest "30Rnd_556x45_Stanag"} count [1,2,3,4,5,6,7];
_unit addItemToVest "1Rnd_Smoke_Grenade_shell";
_unit addItemToVest "1Rnd_SmokePurple_Grenade_shell";
_unit addItemToVest "1Rnd_SmokeRed_Grenade_shell";

_unit addWeapon "SAM_AK5C_GRT";
_unit addPrimaryWeaponItem "RH_compM2l";

_unit addItem "ItemRadio";

{_unit addItemToVest "RH_17Rnd_9x19_g17"} count [1,2];
_unit addWeapon "RH_g17";
