/*
    Function: FP_fnc_spawnVehicle

    Description:
        Spawns a vehicle at designated position. vehicle can patrol an area marker or follow waypoints, depending on format.

    Parameters:
    	_class - Vehicle class to spawn
    	_spawnpos - Position to spawn vehicle on
    	_move - UPS marker to patrol OR an array of positions to follow as waypoints. Last position will be a seek and destroy waypoint.
    	_behaviour - If using waypoints, what behaviour is assumed at last waypoint. [Default "SAD" (seek and destroy)]

    Examples:
    (begin example)
    		//Create vehicle + crew, exit and return the vehicle
		["CLASS",spawnpos] call FP_fnc_spawnVehicle;

		// Vehicle patrol area marker:
		["CLASS",spawnpos,"area"] call FP_fnc_spawnVehicle;

		// Vehicle follows waypoint and does whatever behaviour on last waypoint:
		["class",spawnpos,[array of markers or objects],behaviour] call FP_fnc_spawnVehicle;
    (end)

    Returns:
        Created vehicle | objNull

    Author:
    Cuel 2015-01-18
*/

private ["_veh","_class","_spawnpos","_mrk","_wps","_route","_exit","_behaviour"];
_class = [_this,0,"",[""]] call BIS_fnc_param;
_spawnpos = ([_this,1,""] call BIS_fnc_param) call CBA_fnc_getPos;
if !(isClass  (configFile >> "cfgVehicles" >> _class)) exitWith {["Vehicle class name does not exist (%1)",_class] call BIS_fnc_error; objNull};
if (count (_spawnpos - [0]) == 0)  exitWith {["Wrong spawn position given (%1)",_spawnpos] call BIS_fnc_error; objNull};

_veh = createVehicle [_class,_spawnpos,[], 0, "CAN_COLLIDE"];

createVehicleCrew _veh;

clearItemCargoGlobal _veh;
clearWeaponCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearBackpackCargoGlobal _veh;

_exit = false;
if (count _this == 3 && (typeName (_this select 2) == typeName "STRING")) then
{
	_mrk = [_this,2,""] call BIS_fnc_param;
	if ((markerPos _mrk) distance [0,0,0] > 5) then {
		[_veh,_mrk,"nofollow"] spawn FP_fnc_UPS;
	}else{
		_exit = true;
	};
}
else
{
	_wps = [_this,2,""] call BIS_fnc_param;
	_behaviour = [_this,4,"SAD",[""]] call BIS_fnc_param;
	if !(_behaviour in ["MOVE","DESTROY","GETIN","SAD","JOIN","LEADER","GETOUT","CYCLE","LOAD","UNLOAD","TR UNLOAD","HOLD","SENTRY","GUARD","TALK","SCRIPTED","SUPPORT","GETIN NEAREST","DISMISS","LOITER"]) then {
		_behaviour = "SAD";
	};
	_route = [];
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
	if !(_exit) then
	{
		if (count _route > 1) then
		{
			{
				if (_forEachIndex < count _route -1) then {
					[_veh,_x,0,"MOVE", "AWARE", "RED", "FULL"] call CBA_fnc_addWaypoint;
				}else{
					[_veh,_x,0,_behaviour, "AWARE", "RED", "FULL"] call CBA_fnc_addWaypoint;
				};
			}forEach _route;
		}else{
			[_veh,_route select 0,0,_behaviour, "AWARE", "RED", "FULL"] call CBA_fnc_addWaypoint;
		};
	};
};

if (_exit) exitWith {{deleteVehicle _x} forEach crew _veh; deleteVehicle _veh; ["Incorrect format of one or more waypoints! (%1)",_wps] call BIS_fnc_error; objNull};

if (count crew _veh < 1) then {["WARNING! VEHICLE HAS NO CREW %1",_class] call BIS_fnc_error};

_veh call FP_fnc_addCuratorObject;

_veh
