/*
    Description:
        Respawns a single unit
*/

params ["_pos"];
private _players = [] call FP_JRM_fnc_getSpectators;
if (count _players == 0) exitWith {["ERROR: No dead players"] call ares_fnc_ShowZeusMessage};
private _names = [_players, {name _x}] call ACE_common_fnc_map;

private _args = ["Respawn single unit", [
    ["Player", _names, 0]
]] call Ares_fnc_ShowChooseDialog;

private _plr = _players select (_args select 0);
private _uid = getPlayerUID _plr;
FP_JRM_savedState = [FP_JRM_savedState, {(_x select 0) != _uid}] call ACE_common_fnc_filter;
publicVariable "FP_JRM_fnc_savedState";

[_pos] remoteExecCall ["FP_JRM_fnc_forceRespawn", _plr];
["Respawned %1 at %2", name _plr, mapGridPosition _pos] call ares_fnc_ShowZeusMessage;
