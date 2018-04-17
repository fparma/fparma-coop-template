// ["rhsusf_army_ocp_autorifleman", "example.sqf"]
params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "rhsusf_100Rnd_556x45_soft_pouch";
_unit addWeapon "rhs_weap_m249_pip_elcan";
_unit addPrimaryWeaponItem "rhsusf_acc_elcan_ard_3d";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "rhsusf_ach_helmet_ocp";
_unit forceAddUniform "rhs_uniform_cu_ocp";
_unit addVest "rhsusf_iotv_ocp_SAW";
_unit addBackpack "rhsusf_assault_eagleaiii_ocp_ar";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

// Uniform items
_unit addItemToUniform "rhs_mag_m67";
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "rhsusf_ANPVS_14";
_unit addItemToUniform "rhsusf_patrolcap_ocp";
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
// Vest items
_unit addItemToVest "rhs_mag_m67";
_unit addItemToVest "rhsusf_100Rnd_556x45_soft_pouch";
// Backpack items
_unit addItemToBackpack "rhs_200rnd_556x45_T_SAW";
{_unit addItemToBackpack "rhsusf_100Rnd_556x45_soft_pouch"} count [1,2,3,4];
// Radios
_unit addItemToVest "ACRE_PRC343";