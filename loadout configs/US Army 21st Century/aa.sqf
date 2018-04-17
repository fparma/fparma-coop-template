// ["rhsusf_army_ocp_aa", "example.sqf"]
params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "rhs_mag_30Rnd_556x45_M855A1_Stanag";
_unit addWeapon "rhs_weap_m16a4_carryhandle";
// Secondary weapon
_unit addMagazine "rhs_fim92_mag";
_unit addWeapon "rhs_weap_fim92";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "rhsusf_ach_helmet_ocp";
_unit forceAddUniform "rhs_uniform_cu_ocp";
_unit addVest "rhsusf_iotv_ocp_Rifleman";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

// Uniform items
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "rhsusf_ANPVS_14";
_unit addItemToUniform "rhsusf_patrolcap_ocp";
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
// Vest items
{_unit addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag"} count [1,2,3,4,5,6];
// Radios
_unit addItemToUniform "ACRE_PRC343";