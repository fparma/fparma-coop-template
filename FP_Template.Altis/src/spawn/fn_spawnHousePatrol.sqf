/*
///////////////////////////
	ARMA 3 Group waypoint script
	Version: 0.1
	Author: Cuel
	Created: 2013-10-13
	Purpose: Spawns a group at designated location with the specific amount. Group patrols and search houses
	Takes an array format ["TEAM",position,amount,radius] call FP_fnc_spawnHousePatrol;
	Example: ["CSAT","myDefenseMarker",6,100] call FP_fnc_spawnHousePatrol;
	Optional behaviour refers to last waypoint.
	Returns: Created group
///////////////////////////
*/

if (!isServer) exitWith {};
private ["_grp","_pos","_radius"];
_grp = _this call FP_fnc_spawnGroup;
_pos = ([_this,1,[0,0,0]] call BIS_fnc_param) call CBA_fnc_getPos;
_radius = [_this,3,150,[0]] call BIS_fnc_param;
if (count units _grp == 0 || _pos distance [0,0,0] < 5) exitWith {
	["FP_fnc_spawnHousePatrol: Faulty parameters (%1)",_this] call BIS_fnc_error;
	_grp
};
[_grp, _pos, _radius,4+(round (random 4)), "MOVE", "SAFE", "YELLOW","LIMITED",(["COLUMN", "STAG COLUMN", "WEDGE", "VEE" ,"LINE"] call BIS_fnc_selectRandom), "[this] spawn CBA_fnc_searchNearby", [5,8,12]] call CBA_fnc_taskPatrol;

_grp