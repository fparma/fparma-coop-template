/*
	General FP init. Should not be edited
*/

[] call compile preprocessFileLineNumbers "config.sqf";

enableSaving [false,false];
enableCamShake true;
setViewDistance FP_VD;
setObjectViewDistance FP_OVD;
setTerrainGrid 25;

// TFAR settings. Sets the default channels etc
if (isClass(configFile >> "CfgPatches" >> "task_force_radio")) then {
	[] call compile preprocessFileLineNumbers "base\scripts\tfar_settings.sqf";
};

// Clients
if (hasInterface) then {

	// Hide all UPS markers with correct name, e.g: "area0", "area1", "area_0", "area_1"
	for "_i" from 0 to 50 do {
		(format ["area%1",_i]) setMarkerAlphaLocal 0;
		(format ["area_%1",_i]) setMarkerAlphaLocal 0;
	};

};

FP_fnc_preInit = nil;
