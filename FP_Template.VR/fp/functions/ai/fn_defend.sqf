/*
	Function: FP_fnc_defend

	Description:
        Makes a group defend an area. Mounts statics, gets in buildings and patrols

    Parameters:
        _grp - Group that will patrol
        _radius - Radius around the group to patrol
        _buildingTreshold - Min amount of positions in buildings

	Author:
	Cuel 2016-01-08
*/
params [["_grp", grpNull], ["_radius", 200], ["_buildingTreshold", 2]];
_grp = [_grp] call CBA_fnc_getGroup;
if (!local _grp) exitWith {};

[_grp, _grp, _radius, _buildingTreshold, true] call CBA_fnc_taskDefend;

_grp
