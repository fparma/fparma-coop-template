// General FP init, don't remove
[] call compile preProcessFileLineNumbers "src\fp_init.sqf";

if (!isDedicated) then {

	// Longer view distance for pilots. Edit in config.sqf
	if (!isNil "FP_pilotNames" && {str player in FP_pilotNames}) then {
		[] execVM "fp_scripts\viewdistance.sqf";
	};
};

// Civilians
// [] execVM "fp_scripts\civ\civ_main.sqf";