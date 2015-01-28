// Run config
[] call compile preprocessFileLineNumbers "config.sqf";

// General FP init, don't remove
[] call compile preProcessFileLineNumbers "src\fp_init.sqf";

// Civilians
// [] execVM "fp_scripts\civ\civ_main.sqf";