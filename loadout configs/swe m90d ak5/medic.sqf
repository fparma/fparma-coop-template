params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_556x45_Stanag";
_unit addWeapon "SAM_AK5D";
_unit addPrimaryWeaponItem "RH_compM2l";
_unit addMagazine "RH_17Rnd_9x19_g17";
_unit addWeapon "RH_g17";
removeBackpack _unit;

_unit addHeadgear "FP_Helmet_M90Des";
_unit forceAddUniform "FP_Uniform_M90Des";
_unit addVest "FP_Carrier_GreenPatchless";
_unit addBackpack "B_Kitbag_rgr";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6];
_unit addItemToUniform "ACE_epinephrine";
{_unit addItemToUniform "ACE_morphine"} count [1,2];
{_unit addItemToUniform "CUP_HandGrenade_M67"} count [1,2];

{_unit addItemToVest "SmokeShellGreen"} count [1,2];
_unit addItemToVest "RH_17Rnd_9x19_g17";
{_unit addItemToVest "30Rnd_556x45_Stanag"} count [1,2,3,4,5,6,7];
{_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red"} count [1,2,3];

{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30];
{_unit addItemToBackpack "ACE_bloodIV_500"} count [1,2,3,4];
{_unit addItemToBackpack "ACE_epinephrine"} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24];
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24];

_unit addItemToUniform "ItemRadio";
