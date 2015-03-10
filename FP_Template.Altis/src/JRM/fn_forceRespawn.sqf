/*
	Function: FP_JRM_fnc_forceRespawn

	Description:
	Forces a "wave" respawn.
    Can take an optional position to move units after respawning

    Parameters:
		_pos -  [Optional] position to tp players after they respawn (any)

	Examples:
	(begin example)
        ["respawn_pos_1"] call FP_JRM_fnc_forceRespawn;
	(end)

	Author:
	Cuel 2015-03-13
*/

if (!isServer) exitWith {};

_pos = [_this, 0, [0,0]] call BIS_fnc_param;

_pos = _pos call CBA_fnc_getPos;
if (_pos distance [0,0] < 10) then {
    _pos = [];
};

FP_jrm_deadPlayers = [];

[[_pos], "FP_JRM_fnc_forceRespawnClient", true] call BIS_fnc_MP;
