/*
	Function: FP_fnc_patrol

	Description:
        Makes a group patrol around and searches buildings

    Parameters:
        _grp - Group that will patrol
        _mrkTrig - Number/Marker/Trigger - Number = radius. Marker/Trigger - position to patrol in
            If named "areaX" or "area_X" where X is a number, they will be auto hidden


	Author:
	Cuel 2016-01-08
*/

params [["_grp", grpNull], ["_posRad", "", ["", objNull, 0]], ["_searchBuildings", true]];

if (_posRad isEqualType 0) exitWith {
    [_grp,  _grp, _posRad, 8, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this spawn CBA_fnc_searchNearby", [3,6,9]] call CBA_fnc_taskPatrol;
};

if (!(([_posRad] call CBA_fnc_getPos) call FP_fnc_isValidPos)) exitWith {
    ["Invalid position %1", _this] call BIS_fnc_error;
};

[_grp, _posRad, "SAFE", "RED", "NORMAL", "STAG COLUMN", "", [3, 6, 9], 10] call CBA_fnc_taskSearchArea;
_grp
