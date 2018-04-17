params ["_unit", "_type"];

// Plane pilots
if (_type == "B_pilot_F") then {
	// ["rhsusf_airforce_jetpilot", "example.sqf"]

	// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
	_unit addBackpack "ACE_FakeBackpack";
	// Handgun
	_unit addMagazine "rhsusf_mag_15Rnd_9x19_FMJ";
	_unit addWeapon "rhsusf_weap_m9";
	removeBackpack _unit;

	// Containers / clothes
	_unit addHeadgear "RHS_jetpilot_usaf";
	_unit forceAddUniform "U_B_HeliPilotCoveralls";
	{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","ItemGPS"];

	// Uniform items
	_unit addItemToUniform "ACE_morphine";
	_unit addItemToUniform "rhsusf_ANPVS_14";
	{_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
	{_unit addItemToUniform "rhsusf_mag_15Rnd_9x19_FMJ"} count [1,2];
	// Radios
	_unit addItemToUniform "ACRE_PRC343";



};

// Heli pilots, crew
if (_type == "B_Helipilot_F" || _type == "B_helicrew_F") then {
	// ["rhsusf_army_ocp_helipilot", "example.sqf"]

	// Fake backpack to store magazines and then load them. This ensures that weapons are loaded
	_unit addBackpack "ACE_FakeBackpack";
	// Primary weapon
	_unit addMagazine "rhs_mag_30Rnd_556x45_M855A1_Stanag";
	_unit addWeapon "rhs_weap_m4_carryhandle";
	// Handgun
	_unit addMagazine "rhsusf_mag_15Rnd_9x19_FMJ";
	_unit addWeapon "rhsusf_weap_m9";
	removeBackpack _unit;

	// Containers / clothes
	_unit addHeadgear "rhsusf_hgu56p";
	_unit forceAddUniform "rhs_uniform_cu_ocp";
	_unit addVest "rhsusf_spcs_ocp";
	{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch"];

	// Uniform items
	_unit addItemToUniform "ACE_morphine";
	_unit addItemToUniform "rhsusf_ANPVS_15";
	_unit addItemToUniform "rhsusf_patrolcap_ocp";
	{_unit addItemToUniform "ACE_fieldDressing"} count [1,2];
	// Vest items
	_unit addItemToVest "rhs_mag_an_m8hc";
	_unit addItemToVest "rhs_mag_m18_red";
	{_unit addItemToVest "rhsusf_mag_15Rnd_9x19_FMJ"} count [1,2,3];
	{_unit addItemToVest "rhs_mag_30Rnd_556x45_M855A1_Stanag"} count [1,2,3,4,5,6];
	// Radios
	_unit addItemToUniform "ACRE_PRC343";
};

