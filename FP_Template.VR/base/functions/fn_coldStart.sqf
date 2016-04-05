/*
	Function: FP_fnc_coldStart

	Description:
        Enables cold start if any units can start the mission
        Check the config.sqf for settings
        This function is called automatically and should not be used otherwise.

	Author:
		Cuel 2015-12-08
*/

if (!hasInterface || {!isNil "FP_coldStartStarted"}) exitWith {};

private _canStart = [FP_coldStartCanStart, false, true] call ACE_common_fnc_parseList;
private _canMove = [FP_coldStartCanMove, false, true] call ACE_common_fnc_parseList;

if (FP_coldStartCanStart == "" || {count _canStart == 0}) exitWith {};

// event to handle mission start
FP_coldStartIdx = ["FP_coldStart", {
    if (!isNil "FP_coldStartAction") then {
        [FP_coldStartAction] call CBA_fnc_removePlayerAction;
        player removeAction FP_coldStartAction;
        FP_coldStartAction = nil;
    };
    hintSilent "Mission going live, weapons hot";
    [] spawn {
        sleep 4;
        [player, false] call FP_fnc_disableWeapons;
        hintSilent "";
    };
    ["FP_coldStart", FP_coldStartIdx] call CBA_fnc_removeEventHandler;
    FP_coldStartIdx = nil;
}] call CBA_fnc_addEventHandler;

// Disable weapons
[player, true] call FP_fnc_disableWeapons;

if (player in _canStart) then {
    // Action to start mission
    FP_coldStartAction = ["<t color='#ffff00'>[ Start mission (weapons hot) ]</t>", {
        FP_coldStartStarted = true;
        publicVariable "FP_coldStartStarted";
        ["FP_coldStart"] call CBA_fnc_globalEvent;
    }, nil, 99, false, true] call CBA_fnc_addPlayerAction;
};

if (player in _canMove) exitWith {};
// Units that can't move
[{
    if (!isNil "FP_coldStartStarted") exitWith {[_this select 1] call CBA_fnc_removePerFrameHandler};
    if (player distance (_this select 0) > 20) then {
        (vehicle player) setVelocity [0,0,0];
        player setPosATL (_this select 0);
        hintSilent "You can't move until the mission has started";
        [] spawn {sleep 4; hintSilent ""};
    };
}, 1.23, getPosATL player] call CBA_fnc_addPerFrameHandler;
