/*
	Function: dropPara
	
	Description: 
		Helper function for spawnPara. Not to be used on its own.

	Author: 
	Cuel 2015-01-18
*/

if (!isServer) exitWith {};

private ["_leader","_veh","_info","_dropGrp","_spawnPos","_dropPos","_patrol","_finishWp"];
_leader = [_this,0,objNull,[objNull]] call BIS_fnc_param;
if (isNull _leader) exitWith {["fn_dropPara: Leader is null! (%1)",_this] call BIS_fnc_error};
_veh = (vehicle _leader);
if (!alive _veh) exitWith{};
_info = _veh getVariable ["fp_dropInfo",[]];
// units already dropped
if (count _info == 0) exitWith {};

_veh setVariable ["fp_dropInfo",[]];
_dropGrp = _info select 0;
_spawnPos = _info select 1;
_dropPos = _info select 2;
_patrol = _info select 3;

{
	_x disableCollisionWith _veh;
	unassignVehicle _x;
	_x action ["eject",vehicle _x];
	sleep 0.1;
	_x setVelocity [((random 30)-15), ((random 30)-15),-3];
	[_x,"HaloFreeFall_non"] call FP_fnc_switchMove;
	_x disableAI "ANIM";
	[_x, _veh] spawn {
		_unit = _this select 0;
		_veh = _this select 1;
		waitUntil {sleep 1+(random 2); (((getPosATL _unit) select 2) < 160 || !alive _unit)};
		_unit enableCollisionWith _veh;
		if (alive _unit) then {
			sleep 0.1;
			_unit enableAI "ANIM";
			_chute = createVehicle ["NonSteerable_Parachute_F",[0,0,100],[],3,"CAN_COLLIDE"];
			sleep 0.01;
			_chute disableCollisionWith _unit;
			_chute setPosATL (getPosATL _unit);
			_chute setVelocity (velocity _unit);
			_unit moveInDriver _chute;
			sleep 0.01;
			_chute enableCollisionWith _unit;
		};
	};
	sleep (0.7+ random 0.5);
}forEach (units _dropGrp);

_veh removeAllEventHandlers "handleDamage";

_veh flyInHeight 100;
(group _leader) setSpeedMode "FULL";
_finishWp = (group _leader) addWaypoint [_spawnPos,1];
_finishWp setwaypointtype "MOVE";
_finishWp setWaypointStatements ["true","deleteVehicle (vehicle this); {deleteVehicle _x} forEach (units (group this))"];

if (_patrol distance [0,0,0] > 5) then {
	[_dropGrp, _patrol, 200, 7, "MOVE", "AWARE", "YELLOW", "NORMAL", "WEDGE",""] call CBA_fnc_taskPatrol;
};

_dropGrp