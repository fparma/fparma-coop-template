params ["_unit", "_type"];

// Plane pilots
if (_type == "B_pilot_F") then {
params ["_unit", "_type"];

_unit addHeadgear "CUP_H_USMC_Helmet_Pilot";
_unit forceAddUniform "CUP_U_B_USArmy_PilotOverall";
_unit addVest "CUP_V_B_USArmy_PilotVest";

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
_unit addItemToUniform "ACE_morphine";


};

// Heli pilots, crew
if (_type == "B_Helipilot_F" || _type == "B_helicrew_F") then {
  _unit addHeadgear "CUP_H_USMC_Helmet_Pilot";
  _unit forceAddUniform "CUP_U_B_USArmy_PilotOverall";
  _unit addVest "CUP_V_B_USArmy_PilotVest";
  {_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","ItemGPS"];

  {_unit addItemToUniform "ACE_fieldDressing"} count [0,1];
  _unit addItemToUniform "ACE_morphine";
  {_unit addItemToUniform "hlc_30rnd_556x45_SPR"} count [0,1];
  _unit addItemToUniform "SmokeShellGreen";
  _unit addItemToUniform "Chemlight_green";

  _unit addItemToVest "hlc_30rnd_556x45_SPR";
  _unit addItemToVest "SmokeShellBlue";
  _unit addItemToVest "SmokeShellOrange";
  _unit addItemToVest "Chemlight_green";

  _unit addWeapon "rhs_weap_m4a1_carryhandle";

  _unit addItemToUniform "ItemRadio";
  if (_type == "B_Helipilot_F") then {
	_unit addItemToVest "ACRE_PRC152";
  }
};
