params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "CUP_MAAWS_HEAT_M";
_unit addWeapon "CUP_launch_MAAWS_Scope";
_unit addSecondaryWeaponItem "CUP_optic_MAAWS_Scope";
removeBackpack _unit;

_unit addHeadgear "CUP_H_USArmy_HelmetMICH_ESS";
_unit forceAddUniform "CUP_U_B_USArmy_Base";
_unit addVest "CUP_V_B_IOTV_AT";
_unit addBackpack "CUP_B_AssaultPack_ACU_AT_1";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

{_unit addItemToUniform "ACE_fieldDressing"} count [0,1];
_unit addItemToUniform "ACE_morphine";
{_unit addItemToUniform "hlc_30rnd_556x45_SPR"} count [0,1];

{_unit addItemToVest "hlc_30rnd_556x45_SPR"} count [0,1,2,3,4,5,6];


_unit addWeapon "rhs_weap_m4a1_carryhandle";
_unit addPrimaryWeaponItem "rhsusf_acc_compm4";
_unit addPrimaryWeaponItem "rhsusf_acc_grip1";

_unit addItemToVest "CUP_HandGrenade_M67";

_unit addItemToUniform "ItemRadio";
