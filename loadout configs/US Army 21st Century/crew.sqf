params ["_unit", "_type"];

_unit addHeadgear "CUP_H_USMC_Crew_Helmet";
_unit forceAddUniform "CUP_U_B_USArmy_Base";
_unit addVest "CUP_V_B_IOTV_Rifleman";
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","ItemGPS"];

{_unit addItemToUniform "ACE_fieldDressing"} count [0,1];
_unit addItemToUniform "ACE_morphine";
{_unit addItemToUniform "CUP_30Rnd_556x45_Stanag"} count [0,1];

{_unit addItemToVest "CUP_30Rnd_556x45_Stanag"} count [0,1,2];
{_unit addItemToVest "RH_15Rnd_9x19_M9"} count [0,1];
{_unit addItemToVest "CUP_HandGrenade_M67"} count [0,1];
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
{_unit addItemToVest "Chemlight_green"} count [0,1];

_unit addWeapon "rhs_weap_m4a1_carryhandle";
_unit addWeapon "RH_m9";

_unit addItemToUniform "ItemRadio";
