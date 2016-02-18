/*
	Function: FP_fnc_cache

	Description:
        Cache (hide/disable) a group of units for later use in the mission

	Parameters:
    _units - A single unit, a group, or array of units
    _id - The ID to use for this "cache", which can be used with FP_fnc_unCache to enable the units again

    Example:
	(begin example)
		[group this, "id1"] call FP_fnc_cache;
	(end)

	Author:
	Tinter/Cuel 2016-02-15
*/

if (!isServer) exitWith {};
if (!params [
    ["_units", [], [objNull, grpNull, []]],
    ["_id", "", [""]]
]) exitWith {false};

if (!(_units isEqualType [])) then {
    if (_units isEqualType objNull) exitWith {_units = [_units]};
    if (_units isEqualType grpNull) then {_units = units _units};
};

if (_id == "" || {count _units == 0}) exitWith {
    ["Wrong parameters: %1", _this] call BIS_fnc_error;
    false
};

{
    if (!isPlayer _x && {simulationEnabled _x}) then {
        _x allowDamage false;
        _x hideObjectGlobal true;
        _x enableSimulationGlobal false;

        private _veh = vehicle _x;
        if (_veh != _x && {simulationEnabled _veh}) then {
            _veh enableSimulationGlobal false;
            _x hideObjectGlobal true;
        };
    };
} forEach _units;

private _existingUnits = [FP_cachedGroups, _id] call CBA_fnc_hashGet;
if (isNil "_existingUnits") exitWith {
    [FP_cachedGroups, _id, _units] call CBA_fnc_hashSet;
    true
};

{
    _existingUnits pushBack _x;
} forEach _units;
[FP_cachedGroups, _id, _existingUnits] call CBA_fnc_hashSet;

true
