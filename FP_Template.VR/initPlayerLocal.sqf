/*
	Executed locally when player joins mission (includes both mission start and JIP).
	See: https://community.bistudio.com/wiki/Functions_Library_(Arma_3)#Initialization_Order
		for details about when the script is exactly executed.

	Parameters:
		0 - Player object
		1- Did player JiP
*/

params ["_player", "_isJip"];

[] call compile preProcessFileLineNumbers "base\initPlayer.sqf";
[] call compile preProcessFileLineNumbers "briefing.sqf";

// Add JIP players to zeus
if (_isJip) then {[_player] remoteExecCall ["FP_fnc_addToCurators", 2]};

// Add teleport options to flag. See config.sqf
if (!isNil "fp_flag" && {count FP_flag_targets > 0}) then {
	[fp_flag, FP_flag_targets] call compile preProcessFileLineNumbers "base\scripts\teleport_flag.sqf"
};

// Debug script for development. Create a unit named "debugger" and use him as player.
if (str player in ["debugger"]) then {
	[] call compile preProcessFileLineNumbers "base\scripts\debug_man.sqf";
};
