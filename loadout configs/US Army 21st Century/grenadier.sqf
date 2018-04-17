// ["rhsusf_army_ocp_grenadier", "example.sqf"]
params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "rhs_mag_30Rnd_556x45_M855A1_Stanag";
_unit addMagazine "rhs_mag_M441_HE";
_unit addWeapon "rhs_m4_m203_compm4";
_unit addPrimaryWeaponItem "rhsusf_acc_anpeq15side";
_unit addPrimaryWeaponItem "rhsusf_acc_compm4";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "rhsusf_ach_helmet_ESS_ocp";
_unit forceAddUniform "rhs_uniform_cu_ocp";
_unit addVest "rhsusf_iotv_ocp_Grenadier";
_unit addBackpack "rhsusf_falconii_gr";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

// Uniform items
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "rhsusf_ANPVS_14";
_unit addItemToUniform "rhsusf_patrolcap_ocp";
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
// Vest items
_unit addItemToVest "rhs_mag_m67";
{_unit addItemToVest "rhs_mag_M441_HE"} count [1,2,3,4,5];
{_unit addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag"} count [1,2,3,4,5,6];
// Backpack items
{_unit addItemToBackpack "rhs_mag_M585_white"} count [1,2,3,4,5];
{_unit addItemToBackpack "rhs_mag_M441_HE"} count [1,2,3,4,5,6,7,8,9,10];
// Radios
_unit addItemToUniform "ACRE_PRC343";