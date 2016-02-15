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
if (_isJip) then {[_player] call FP_fnc_addToCurators};

// Add teleport options to flag. See config.sqf
if (!isNil "fp_flag" && {count FP_flagTargets > 0}) then {
    [fp_flag, FP_flagTargets] call compile preProcessFileLineNumbers "base\scripts\teleport_flag.sqf"
};

// Disable remote sensors for regular clients (not server, hc, zeus)
// Curator logic might be null at time 0
[{
    if (hasInterface &&
        {!isServer} &&
        {isNull (getAssignedCuratorLogic player)}
    ) then {
        disableRemoteSensors true;
    };
}, [], 1] call ACE_common_fnc_waitAndExecute;
