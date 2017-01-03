params ["_unit", "_type"];

// Plane pilots
if (_type == "B_pilot_F") then {
  params ["_unit", "_type"];

  // Fake backpack to store magazines and then load them. This ensures that weapons are loaded
  _unit addBackpack "ACE_FakeBackpack";
  // Primary weapon
  _unit addMagazine "30Rnd_45ACP_Mag_SMG_01";
  _unit addWeapon "SMG_01_Holo_F";
  _unit addPrimaryWeaponItem "optic_Holosight_smg";
  removeBackpack _unit;

  // Containers / clothes
  _unit addHeadgear "H_PilotHelmetFighter_B";
  _unit forceAddUniform "U_B_PilotCoveralls";
  _unit addBackpack "ACE_NonSteerableParachute";
  clearAllItemsFromBackpack _unit;
  {_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

  // Uniform items
  _unit addItemToUniform "SmokeShell";
  _unit addItemToUniform "ACE_morphine";
  _unit addItemToUniform "SmokeShellBlue";
  _unit addItemToUniform "Chemlight_green";
  {_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
  {_unit addItemToUniform "30Rnd_45ACP_Mag_SMG_01"} count [1,2];
  // Radios
  _unit addItemToUniform "ACRE_PRC148";
};

// Heli pilots, crew
if (_type == "B_Helipilot_F" || _type == "B_helicrew_F") then {
  params ["_unit", "_type"];

  // Fake backpack to store magazines and then load them. This ensures that weapons are loaded
  _unit addBackpack "ACE_FakeBackpack";
  // Primary weapon
  _unit addMagazine "30Rnd_45ACP_Mag_SMG_01";
  _unit addWeapon "SMG_01_Holo_F";
  _unit addPrimaryWeaponItem "optic_Holosight_smg";
  removeBackpack _unit;

  // Containers / clothes
  _unit addHeadgear "H_PilotHelmetHeli_B";
  _unit forceAddUniform "U_B_HeliPilotCoveralls";
  _unit addVest "V_TacVest_blk";
  {_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","NVGoggles"];

  // Uniform items
  _unit addItemToUniform "ACE_morphine";
  _unit addItemToUniform "SmokeShellGreen";
  _unit addItemToUniform "Chemlight_green";
  _unit addItemToUniform "30Rnd_45ACP_Mag_SMG_01";
  {_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
  // Vest items
  _unit addItemToVest "SmokeShellBlue";
  _unit addItemToVest "Chemlight_green";
  _unit addItemToVest "SmokeShellOrange";
  _unit addItemToVest "30Rnd_45ACP_Mag_SMG_01";
  // Radios
  _unit addItemToUniform "ACRE_PRC343";
  if (_type == "B_Helipilot_F") then {
    _unit addItemToUniform "ACRE_PRC148";
  };
};
