/*
///////////////////////////
	ARMA 3 Group waypoint script
	Version: 0.1
	Author: Cuel
	Created: 2013-10-13
	Purpose: Spawns a group at designated location with the specific amount. Group follows WP's 
	Takes an array format ["TEAM",position,amount,position or array of positions,behaviour (optional)] call FP_fnc_spawnGroupWP;
	Example: ["CSAT","myDefenseMarker",6,["move1","move2],"SAD"] call FP_fnc_spawnGroupWP;
	Optional behaviour refers to last waypoint.
	Returns: Created group
///////////////////////////
*/
if (!isServer) exitWith {};
private ["_grp","_route","_wps","_behaviour","_exit","_tmp"];
_grp = _this call FP_fnc_spawnGroup;
_wps = [_this,3,[]] call BIS_fnc_param;
_behaviour = [_this,4,"SAD",[""]] call BIS_fnc_param; 
if !(_behaviour in ["MOVE","DESTROY","GETIN","SAD","JOIN","LEADER","GETOUT","CYCLE","LOAD","UNLOAD","TR UNLOAD","HOLD","SENTRY","GUARD","TALK","SCRIPTED","SUPPORT","GETIN NEAREST","DISMISS","LOITER"]) then {_behaviour = "SAD"};
_route = [];
_exit = false;
if (typeName _wps == typeName []) then
{
	{
		_tmp = _x call CBA_fnc_getPos;
		if (count (_tmp - [0]) == 0) exitWith {_exit = true};
		_route set [count _route,_tmp];
	}forEach _wps;
}else{
	_tmp = _wps call CBA_fnc_getPos;
	if (count (_tmp - [0]) == 0) exitWith {_exit = true};
	_route set [0,_tmp];
};
if (_exit) exitWith {["FP_fnc_spawnGroupWP: Incorrect format of one or more waypoints! (%1)",_wps] call BIS_fnc_error;};


if (count _route > 1) then 
{
	for "_i" from 0 to count _route -2 do 
	{
		[_grp,(_route select _i),0,"MOVE", "AWARE", "RED", "FULL"] call CBA_fnc_addWaypoint;
	};
	[_grp,(_route select (count _route -1)),0,_behaviour, "AWARE", "RED", "FULL"] call CBA_fnc_addWaypoint;
}else{
	[_grp,_route select 0,0,_behaviour, "AWARE", "RED", "FULL"] call CBA_fnc_addWaypoint;
};

_grp