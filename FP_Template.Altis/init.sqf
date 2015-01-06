// TFAR settings
if (isClass(configFile>>"CfgPatches">>"task_force_radio")) then {
	[] call compile preProcessFileLineNumbers "tfar_settings.sqf";
};
// General FP init, don't remove
[] call compile preProcessFileLineNumbers "src\fp_init.sqf";


if (!isDedicated) then {

	waitUntil {!isNull player};
	
	// "player" command is now initialised (IMPORTANT for JiP compability, if you have no idea what this is, just add client scripts below
	[] call compile preProcessFileLineNumbers "briefing.sqf";

	// longer viewdistance for pilots, p1 / p2 are unit names
	if (str player in ["p1","p2"]) then {
		[] execVM "fp_scripts\viewdistance.sqf";
	};
};

// map markers for development
if (!isMultiplayer) then {
	[] execVM "src\spawn\debug.sqf";
};

// Server only scripts
if (isServer) then 
{

};

// add any "run for everyone" scripts below



// JiP and respawn manager
// Do not change respawn type if used
// Check the settings in the file.
// [] execVM "src\jipAndRespawnManager.sqf";

// Civilians
// [] execVM "fp_scripts\civ\civ_main.sqf";