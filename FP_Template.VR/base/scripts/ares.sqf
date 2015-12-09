// Ares util functions
private _DISPLAY_NAME = "FP Utils";

/*
 Ejects whatever cargo is inside the vehicle
*/
[_DISPLAY_NAME, "Force eject vehicle cargo", {
	params ["", "_veh"];
	if (isNull _veh || {_veh isKindOf "Man"} || {speed _veh > 2}) exitWith {};

    private _units = [_veh, ["ffv", "cargo"]] call ACE_common_fnc_getVehicleCrew;

    [_units, {
        {
            _x leaveVehicle (vehicle _x);
            _x action ["Eject", vehicle _x]
        } forEach _this;
    }] remoteExecCall ["BIS_fnc_call", _units];

}] call Ares_fnc_RegisterCustomModule;

/*
 Respawns and moves all players (that can fit) inside the cargo of a specific vehicle
*/
[_DISPLAY_NAME, "[RESPAWN] Fill vehicle cargo", {
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
}] call Ares_fnc_RegisterCustomModule;

/*
 Respawns and moves all dead players to a position
*/
[_DISPLAY_NAME, "[RESPAWN] Move to position", {
    params ["_pos"];
    if (!(_pos call FP_fnc_isValidPos)) exitWith {};
    private _deadPlayers = [FP_JRM_savedState, {(_x select 1) == 0}] call ACE_common_fnc_filter;
    if (count _deadPlayers == 0) exitWith {["ERROR: No dead players"] call ares_fnc_ShowZeusMessage};

    private _playerObjects = [];
    {
        private _uid = _x select 0;
        {if (getPlayerUID _x == _uid && alive _x) then {_playerObjects pushBack _x}} forEach allPlayers;
        if (count _playerObjects isEqualTo _maxAmount) exitWith {};
    } forEach _deadPlayers;

    [_pos] remoteExecCall ["FP_JRM_fnc_forceRespawn", _playerObjects];
    ["Respawned %1 players", count _playerObjects] call ares_fnc_ShowZeusMessage;
}] call Ares_fnc_RegisterCustomModule;
