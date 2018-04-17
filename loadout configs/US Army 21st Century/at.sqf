// ["rhsusf_army_ocp_maaws", "example.sqf"]
params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "rhs_mag_30Rnd_556x45_M855A1_Stanag";
_unit addWeapon "rhs_m4_compm4";
_unit addPrimaryWeaponItem "rhsusf_acc_compm4";
// Secondary weapon
_unit addMagazine "rhs_mag_maaws_HEAT";
_unit addWeapon "rhs_weap_maaws_optic";
_unit addSecondaryWeaponItem "rhs_optic_maaws";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "rhsusf_ach_helmet_ocp";
_unit forceAddUniform "rhs_uniform_cu_ocp";
_unit addVest "rhsusf_iotv_ocp_Rifleman";
_unit addBackpack "rhsusf_assault_eagleaiii_ocp_maaws";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

// Uniform items
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "rhsusf_ANPVS_14";
_unit addItemToUniform "rhsusf_patrolcap_ocp";
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
// Vest items
_unit addItemToVest "rhs_mag_m67";
{_unit addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag"} count [1,2,3,4,5,6];
// Backpack items
{_unit addItemToBackpack "rhs_mag_maaws_HEDP"} count [1,2];
// Radios
_unit addItemToUniform "ACRE_PRC343";