/*
///////////////////////////
	ARMA 3 Patrol script
	Version: 0.1
	Author: Cuel
	Created: 2013-10-13
	Purpose: Spawns a group at designated location with the specific amount. Group patrols using UPS. myMarker must be an AREA to PATROL
	@param {"String"} - Team
	@param {String | Object | Location} Position to spawn the group on
	@param {"String"} - area marker to patrol
	@param {Int} - Amount of units in the group.
	Example: ["CSAT","spawnPos,"myMarker",4] call FP_fnc_spawnPatrol;
	@return {group} - created group
///////////////////////////
*/

if (!isServer) exitWith {};
private ["_team","_spawnpos","_grp","_patrolmark","_amount"];

_team = [_this,0,"",[""]] call BIS_fnc_param;
_spawnpos = ([_this,1,[0,0,0]] call BIS_fnc_param) call CBA_fnc_getPos;
_patrolmark = [_this,2,[0,0,0],[""]] call BIS_fnc_param;
_amount = [_this,3,4,[0]] call BIS_fnc_param;

if (_team == "" || _spawnpos distance [0,0,0] < 5 || (markerPos _patrolmark) distance [0,0,0] < 5) exitWith {
	["FP_fnc_spawnPatrol: Faulty parameters (%1)",_this] call BIS_fnc_error;
};
_grp = [_team,_spawnpos,_amount]call FP_fnc_spawnGroup;
[leader _grp,_patrolmark,"nofollow"] spawn FP_fnc_UPS;

_grp