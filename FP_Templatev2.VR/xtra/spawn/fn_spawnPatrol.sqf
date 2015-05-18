/*
    Function: FP_fnc_spawnPatrol

    Description:
        Spawns a group at designated location with the specific amount. Group patrols using UPS.

    Parameters:
        	_team - Team defined in getUnits [String]
        	_spawnpos - Spawn position for group [Any]
		_patrolMark - UPS marker to patrol. Name them "area"[0-x] or "area_"[0-x]  for automatic hiding on mission start. The marker should be the whole area to patrol
		_amount - Amount of units to spawn

    Examples:
    (begin example)
    		["CSAT","spawnPos,"myMarker",4] call FP_fnc_spawnPatrol;
    (end)

    Returns:
        Created group

    Author:
    Cuel 2015-01-18
*/

private ["_team","_spawnpos","_grp","_patrolmark","_amount"];
_team = [_this,0,"",[""]] call BIS_fnc_param;
_spawnpos = ([_this,1,[0,0,0]] call BIS_fnc_param) call CBA_fnc_getPos;
_patrolmark = [_this,2,[0,0,0],[""]] call BIS_fnc_param;
_amount = [_this,3,4,[0]] call BIS_fnc_param;

if (_team == "" || _spawnpos distance [0,0,0] < 5 || (markerPos _patrolmark) distance [0,0,0] < 5) exitWith {
	["FP_fnc_spawnPatrol: Faulty parameters (%1)",_this] call BIS_fnc_error;
};
_grp = [_team,_spawnpos,_amount]call FP_fnc_spawnGroup;
[leader _grp, _patrolmark, "nofollow"] spawn FP_fnc_UPS;

_grp
