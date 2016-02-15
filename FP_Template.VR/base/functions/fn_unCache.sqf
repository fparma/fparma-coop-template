/*
	Function: FP_fnc_unCache

	Description:
        Uncache all units associated with an ID
	Parameters:
    _id - ID string

    Example:
	(begin example)
		["id1"] call FP_fnc_unCache;
	(end)

	Author:
	Tinter/Cuel 2016-02-15
*/

if (!isServer) exitWith {};
if (!params [["_id", "", [""]]]) exitWith {false};

private _units = [FP_cachedGroups, _id] call CBA_fnc_hashGet;
if (isNil "_units") exitWith {false};

{
    _x allowDamage true;
    // TODO: update after 1.54, currently hideObjectGlobal is bugged
    [_x, false] remoteExecCall ["hideObject"];
    _x enableSimulationGlobal true;

    private _veh = vehicle _x;
    if (_veh != _x && {!simulationEnabled _veh}) then {
        // TODO: update after 1.54, currently hideObjectGlobal is bugged
        [_x, false] remoteExecCall ["hideObject"];
        _veh hideObjectGlobal false;
    };
} forEach _units;

true
