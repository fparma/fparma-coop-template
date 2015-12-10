/*
    Description:
        Force ejects a vehicle's cargo, including players.
*/

params ["", "_veh"];
if (isNull _veh || {_veh isKindOf "Man"} || {speed _veh > 2}) exitWith {};

private _units = [_veh, ["ffv", "cargo"]] call ACE_common_fnc_getVehicleCrew;

[_units, {
    {
        _x leaveVehicle (vehicle _x);
        _x action ["Eject", vehicle _x]
    } forEach _this;
}] remoteExecCall ["BIS_fnc_call", _units];
