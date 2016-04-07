/*
	Function: FP_fnc_patrol

	Description:
        Makes a group patrol around and searches buildings

    Parameters:
        _grp - Group that will patrol
        _mrkTrig - Number/Marker/Trigger.
          If number = radius
          Marker/Trigger - position to patrol within
          If markers named "areaX" or "area_X" where X is a number, they will be auto hidden in PreInit

	Author:
	Cuel 2016-01-08
*/

params [["_grp", grpNull], ["_posRad", "", ["", objNull, 0]]];
_grp = [_grp] call CBA_fnc_getGroup;
if (!local _grp) exitWith {};

if (_posRad isEqualType 0) exitWith {
  [_grp,  _grp, _posRad, 8, "MOVE", "AWARE", "YELLOW", "NORMAL", "STAG COLUMN", "this spawn CBA_fnc_searchNearby", [3,6,9]] call CBA_fnc_taskPatrol;
};

_posRad = [_posRad] call CBA_fnc_getPos;
if ([_posRad select 0, _posRad select 1] isEqualTo [0, 0]) exitWith {
  ["Invalid position %1", _this] call BIS_fnc_error;
};

[_grp, _posRad, "SAFE", "RED", "NORMAL", "STAG COLUMN", "", [3, 6, 9], 10] call CBA_fnc_taskSearchArea;
_grp
