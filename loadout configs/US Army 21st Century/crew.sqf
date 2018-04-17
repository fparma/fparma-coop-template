// ["rhsusf_army_ocp_crewman", "example.sqf"]
params ["_unit", "_type"];

// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
_unit addBackpack "ACE_FakeBackpack";
// Primary weapon
_unit addMagazine "rhs_mag_30Rnd_556x45_M855A1_Stanag";
_unit addWeapon "rhs_weap_m4_carryhandle";
// Handgun
_unit addMagazine "rhsusf_mag_15Rnd_9x19_FMJ";
_unit addWeapon "rhsusf_weap_m9";
// Binoc
_unit addWeapon "Binocular";
removeBackpack _unit;

// Containers / clothes
_unit addHeadgear "rhsusf_cvc_helmet";
_unit forceAddUniform "rhs_uniform_cu_ocp";
_unit addVest "rhsusf_iotv_ocp";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

// Uniform items
_unit addItemToUniform "ACE_morphine";
_unit addItemToUniform "rhsusf_ANPVS_14";
_unit addItemToUniform "rhs_mag_an_m8hc";
_unit addItemToUniform "rhsusf_mag_15Rnd_9x19_FMJ";
{_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
// Vest items
_unit addItemToVest "rhsusf_mag_15Rnd_9x19_FMJ";
_unit addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag";
// Radios
_unit addItemToUniform "ACRE_PRC343";
