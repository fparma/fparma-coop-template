params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "30Rnd_556x45_Stanag";
_unit addWeapon "SAM_AK5C";
_unit addPrimaryWeaponItem "RH_compM2l";
_unit addWeapon "CUP_launch_MAAWS";
_unit addSecondaryWeaponItem "CUP_optic_MAAWS_Scope";
_unit addWeapon "RH_g17";
removeBackpack _unit;

_unit addHeadgear "FP_Helmet_M90Des";
_unit forceAddUniform "FP_Uniform_M90Des";
_unit addVest "FP_Carrier_GreenPatchless";
_unit addBackpack "B_AssaultPack_rgr";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6];
_unit addItemToUniform "ACE_epinephrine";
{_unit addItemToUniform "ACE_morphine"} count [1,2];
{_unit addItemToUniform "CUP_HandGrenade_M67"} count [1,2];

{_unit addItemToVest "SmokeShellGreen"} count [1,2];
{_unit addItemToVest "30Rnd_556x45_Stanag"} count [1,2,3,4,5,6];
{_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Red"} count [1,2,3];

_unit addItemToBackpack "CUP_MAAWS_HEDP_M";

_unit addItemToUniform "ItemRadio";
