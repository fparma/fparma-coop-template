// ["rhsusf_army_ocp_explosives", "example.sqf"]
params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "rhs_mag_30Rnd_556x45_M855A1_Stanag";
_unit addWeapon "rhs_m4a1_acog2";
_unit addPrimaryWeaponItem "rhsusf_acc_anpeq15_top";
_unit addPrimaryWeaponItem "rhsusf_acc_ACOG2_3d";
// Handgun
_unit addMagazine "rhsusf_mag_15Rnd_9x19_FMJ";
_unit addWeapon "rhsusf_weap_m9";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "rhsusf_ach_helmet_ESS_ocp";
_unit forceAddUniform "rhs_uniform_cu_ocp";
_unit addVest "rhsusf_iotv_ocp_Repair";
_unit addBackpack "rhsusf_assault_eagleaiii_ocp_demo";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

// Uniform items
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "rhsusf_ANPVS_14";
_unit addItemToUniform "rhsusf_patrolcap_ocp";
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
// Vest items
_unit addItemToVest "rhs_mag_m18_red";
{_unit addItemToVest "Chemlight_green"} count [1,2];
{_unit addItemToVest "rhsusf_mag_15Rnd_9x19_FMJ"} count [1,2];
{_unit addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag"} count [1,2,3,4,5,6];
// Backpack items
_unit addItemToBackpack "rhsusf_m112x4_mag";
{_unit addItemToBackpack "rhsusf_m112_mag"} count [1,2,3];
// Radios
_unit addItemToUniform "ACRE_PRC343";