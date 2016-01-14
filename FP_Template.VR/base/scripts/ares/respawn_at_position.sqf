/*
    Description:
        Respawns all spectating units at the selected position
*/

params ["_pos"];
if (!(_pos call FP_fnc_isValidPos)) exitWith {};
private _plrs = [] call FP_JRM_fnc_getSpectators;
if (count _plrs == 0) exitWith {["ERROR: No dead players"] call ares_fnc_ShowZeusMessage};

private _uids = [_plrs, {getPlayerUID _x}] call ACE_common_fnc_map;
FP_JRM_savedState = [FP_JRM_savedState, {!((_x select 0) in _uids)}] call ACE_common_fnc_filter;
publicVariable "FP_JRM_savedState";

[_pos] remoteExecCall ["FP_JRM_fnc_forceRespawn", _plrs];
["Respawned %1 players", count _plrs] call ares_fnc_ShowZeusMessage;
