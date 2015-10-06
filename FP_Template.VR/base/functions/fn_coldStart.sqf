/*
	Function: FP_fnc_coldStart

	API:
		Client

    Parameters:
        _canStart - Units that can remove the lock and start mission
        _canMove - Units that are able to move

	Description:
        Disables player moving, bullets fired etc.

	Author:
		Cuel 2015-10-29
*/

params [
    ["_canStart", [], [[]]]
    ["_canMove", ["gm", "actual", "amed", "a0", "b0", "c0", "d0", "p0", "p1", "crew0", "crew1", "crew2"], [[]]]
]
if (!hasInterface || {count _canStart == 0}) exitWith {};

[player, true] call FP_fnc_disableWeapons;

if (str player in _canStart) then {
    local _idx  = player addAction ["<t color='#ffff00'>[ Start mission (weapons hot) ]</t>", {
        "Mission going live, weapons hot" remoteExecCall ["hintSilent"];
        sleep 4;
        ["FP_coldStart"] call CBA_fnc_globalEvent;
    }, nil, 0, false, true];

    player setVariable ["FP_coldStartAction", _idx];
};

FP_coldStartIdx = ["FP_coldStart", {
    [player, false] call FP_fnc_disableWeapons;
    local _idx = player getVariable ["FP_coldStartAction", -1];
    if (_idx > -1) then {
        player removeAction _idx;
    };

    if (!isNil "FP_coldStartPFH") then {[FP_coldStartPFH] call CBA_fnc_removePerFrameHandler};
    [FP_coldStartIdx] call CBA_fnc_removeEventHandler;
    FP_coldStartIdx = nil;
    FP_coldStartPFH = nil;
}] call CBA_fnc_addEventHandler;


if (str player in _canMove) exitWith {};

FP_coldStartPFH = [{
    params ["_pos"];
    if ((getPosATL player) distance _pos > 20) then {
		vehicle player setPosATL _spawnPos;
		hintSilent "You are locked in place until mission has started";
	};
}, 1, getPosATL player] call CBA_fnc_addPerFrameHandler;
