/*
    Description:
        Respawns all spectating units at the selected position
*/

params ["_pos"];
if (!(_pos call FP_fnc_isValidPos)) exitWith {};
private _deadPlayers = [FP_JRM_savedState, {(_x select 1) == 0}] call ACE_common_fnc_filter;
if (count _deadPlayers == 0) exitWith {["ERROR: No dead players"] call ares_fnc_ShowZeusMessage};

private _playerObjects = [];
{
    private _uid = _x select 0;
    {if (getPlayerUID _x == _uid && alive _x) then {_playerObjects pushBack _x}} forEach allPlayers;
} forEach _deadPlayers;

[_pos] remoteExecCall ["FP_JRM_fnc_forceRespawn", _playerObjects];
["Respawned %1 players", count _playerObjects] call ares_fnc_ShowZeusMessage;
