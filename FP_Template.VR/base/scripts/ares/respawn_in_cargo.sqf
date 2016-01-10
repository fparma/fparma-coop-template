/*
    Description:
        Respawns the amount of spectating players that can fit inside the vehicle cargo
*/

params ["", "_veh"];
if (isNull _veh) exitWith {};
private _maxAmount = _veh emptyPositions "cargo";
private _plrs = [_maxAmount] call FP_JRM_fnc_getSpectators;
if (_maxAmount isEqualTo 0 || {count _plrs == 0}) exitWith {["ERROR: No cargo slots / no dead players"] call ares_fnc_ShowZeusMessage};

private _uids = [];
{_uids pushBack (getPlayerUID _x)} forEach _plrs;
FP_JRM_savedState = [FP_JRM_savedState, {!((_x select 0) in _uids)}] call ACE_common_fnc_filter;
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

[[_veh], _code] remoteExecCall ["BIS_fnc_call", _plrs];
["Moved %1 players into cargo", count _plrs] call ares_fnc_ShowZeusMessage;
