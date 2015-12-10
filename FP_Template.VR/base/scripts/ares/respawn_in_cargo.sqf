/*
    Description:
        Respawns the amount of spectating players that can fit inside the vehicle cargo
*/

params ["", "_veh"];
if (isNull _veh) exitWith {};
private _maxAmount = _veh emptyPositions "cargo";
private _deadPlayers = [FP_JRM_savedState, {(_x select 1) == 0}] call ACE_common_fnc_filter;
if (_maxAmount isEqualTo 0 || {count _deadPlayers == 0}) exitWith {["ERROR: No cargo slots / no dead players"] call ares_fnc_ShowZeusMessage};

private _code = {
    ["FP_screen"] call BIS_fnc_blackOut;
    [{
        [false] call FP_fnc_spectate;
        player assignAsCargo _this;
        player moveInCargo _this;
        ["FP_screen"] call BIS_fnc_blackIn;
    }, _this select 0, 2 + random 2] call ACE_common_fnc_waitAndExecute;
};

private _playerObjects = [];
{
    private _uid = _x select 0;
    {if (getPlayerUID _x == _uid && alive _x) then {_playerObjects pushBack _x}} forEach allPlayers;
    if (count _playerObjects isEqualTo _maxAmount) exitWith {};
}forEach _deadPlayers;

[[_veh], _code] remoteExecCall ["BIS_fnc_call", _playerObjects];
["Moved %1 players", count _playerObjects] call ares_fnc_ShowZeusMessage;
