params ["_unit", "_type"];

_unit addHeadgear "CUP_H_USArmy_HelmetMICH";
_unit forceAddUniform "CUP_U_B_USArmy_Base";
_unit addVest "CUP_V_B_IOTV_Rifleman";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

{_unit addItemToUniform "ACE_fieldDressing"} count [0,1];
_unit addItemToUniform "ACE_morphine";
{_unit addItemToUniform "hlc_20Rnd_762x51_B_M14"} count [0,1];

{_unit addItemToVest "hlc_20Rnd_762x51_B_M14"} count [0,1,2,3,4,5,6];

_unit addWeapon "hlc_rifle_m14dmr";
_unit addPrimaryWeaponItem "hlc_optic_LRT_m14";

_unit addWeapon "CUP_Vector21Nite";




_unit addItemToUniform "ItemRadio";
