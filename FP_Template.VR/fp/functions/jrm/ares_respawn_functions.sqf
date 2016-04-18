/*
    ARES Script: Handle respawns for JRM.
*/

params ["_mode", ["_Xarg", objNull]];

switch (toUpper _mode) do {

  // Respawns a single unit at selected position
  case "SINGLE": {
    private _pos = _Xarg call CBA_fnc_getPos;
    if ([_pos select 0, _pos select 1] isEqualTo [0, 0]) exitWith {};

    private _players = [] call FP_JRM_fnc_getSpectators;
    if (count _players == 0) exitWith {["ERROR: No dead players"] call ares_fnc_ShowZeusMessage};
    private _names = _players apply {name _x};

    private _args = ["Respawn single unit", [
        ["Player", _names, 0]
    ]] call Ares_fnc_ShowChooseDialog;
    if (count _args == 0) exitWith {};

    private _plr = _players select (_args select 0);
    private _uid = getPlayerUID _plr;
    if (isNull _plr || _uid == "") exitWith {["ERROR: Unable to find player"] call ares_fnc_ShowZeusMessage};

    FP_JRM_savedState = FP_JRM_savedState select {(_x select 0) != _uid};
    publicVariable "FP_JRM_savedState";

    [_pos] remoteExecCall ["FP_JRM_fnc_forceRespawn", _plr];
    ["Respawned %1 at %2", name _plr, mapGridPosition _pos] call ares_fnc_ShowZeusMessage;
  };

  // Respawns all spectating units at the selected position
  case "POSITION": {
    private _pos = _Xarg call CBA_fnc_getPos;
    if ([_pos select 0, _pos select 1] isEqualTo [0, 0]) exitWith {};

    private _plrs = [] call FP_JRM_fnc_getSpectators;
    if (count _plrs == 0) exitWith {["ERROR: No dead players"] call ares_fnc_ShowZeusMessage};

    private _uids = _plrs apply {getPlayerUID _x};
    FP_JRM_savedState = FP_JRM_savedState select {!((_x select 0) in _uids)};
    publicVariable "FP_JRM_savedState";

    [_pos] remoteExecCall ["FP_JRM_fnc_forceRespawn", _plrs];
    ["Respawned %1 players", count _plrs] call ares_fnc_ShowZeusMessage;

  };

  case "CARGO": {
    if (isNull _Xarg) exitWith {};
    private _maxAmount = _Xarg emptyPositions "cargo";
    private _plrs = [_maxAmount] call FP_JRM_fnc_getSpectators;
    if (_maxAmount isEqualTo 0 || {count _plrs == 0}) exitWith {["ERROR: No cargo slots / no dead players"] call ares_fnc_ShowZeusMessage};

    private _uids = _plrs apply {getPlayerUID _x};
    FP_JRM_savedState = FP_JRM_savedState select {!((_x select 0) in _uids)};
    publicVariable "FP_JRM_savedState";

    private _code = {
      ["FP_screen"] call BIS_fnc_blackOut;
      [{
        [false] call FP_fnc_spectate;
        player assignAsCargo _this;
        player moveInCargo _this;
        ["FP_screen"] call BIS_fnc_blackIn;
      }, _this select 0, 2 + random 2] call ACE_common_fnc_waitAndExecute;
    };

    [[_Xarg], _code] remoteExecCall ["BIS_fnc_call", _plrs];
    ["Moved %1 players into cargo", count _plrs] call ares_fnc_ShowZeusMessage;
  };
};
