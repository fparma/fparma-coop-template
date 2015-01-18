/*
	General FP init. Try not to edit this file.
*/

enableSaving [false,false];
setGroupIconsVisible [true,false]; //Show only 2D
enableCamShake true;
setViewDistance 2000;
setObjectViewDistance 2000;
setTerrainGrid 25;

// TFAR settings
if (isClass(configFile>>"CfgPatches">>"task_force_radio")) then {
	[] call compile preProcessFileLineNumbers "src\tfar_settings.sqf";
};

// Run config
[] call compile preprocessFileLineNumbers "config.sqf";

// Clients
if (!isDedicated) then {

	// Hide all base markers
	{ _x setMarkerAlphaLocal 0; } foreach ["respawn_west","respawn_east","respawn_guer","respawn_guerrila","respawn_civilian","area"];

	// Hide all UPS markers with correct name
	for "_i" from 0 to 50 do {
		_a = format ["area%1",_i];
		_a setMarkerAlphaLocal 0;
		_a = format ["area_%1",_i];
		_a setMarkerAlphaLocal 0;
	};

	// Add teleport options to flag
	if (!isNil "fp_flag") then {
		[fp_flag,[["Alpha Actual","a0"],["Bravo Actual","b0"],["Charlie Actual","c0"],["Delta Actual","d0"]]] call compile preProcessFileLineNumbers "src\teleport.sqf";
	};

	[] spawn {
		waitUntil {!isNull player};

		// Debug script for development. Create a unit named "debugger" and use him as player.
		if (str player in ["debugger"]) then {
			[] execVM "fp_scripts\debug_man.sqf";
		};
		
		sleep  0.3;
		// Lower weapon after mission start
		player switchMove "amovpercmstpslowwrfldnon";

		// Needed to figure out what gear the player have
		_timeOut = time + 15;
		waitUntil {(player getVariable ["FP_kit_type", ""] != "") || time > _timeOut};
		FP_kit_type = player getVariable ["FP_kit_type", ""];
	};
};

if (!isNil "FP_jrm_enabled" && {FP_jrm_enabled}) then {
	[] execVM "src\jipAndRespawnManager.sqf";
};