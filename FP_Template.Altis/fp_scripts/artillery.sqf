/*
///////////////////////////
	ARMA 3 "artillery" script
	Author: SSG Cuel
	Created: 2014-01-13
	Purpose: Sends artillery to target position
	@param {Trigger} Trigger area to fire within. Shells will only land within the trigger 
	@param {Number} Amount rounds / shells per barrage
	@param {Number} Amount of barrages
	@param {Number} Delay between barrage / travel time
	Example:
	0 = [trigger1,3,2,20] execVM "fp_scripts\artillery.sqf";
///////////////////////////
*/
if (!isServer) exitWith {};
private ["_target","_nrRounds","_nrBarrages","_travelTime","_ammo","_spawnHeight","_pos","_exit","_tmppos"];

_target = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_nrRounds = [_this,1,3,[0]] call BIS_fnc_param;
_nrBarrages = [_this,2,1,[0]] call BIS_fnc_param;
_travelTime = [_this,3,20,[0]] call BIS_fnc_param;
if (isNull _target) exitWith {["ARTILLERY.SQF: Trigger is null! ",_this] call BIS_fnc_error; false};

_dist =	(triggerArea _target select 0) max (triggerArea _target select 1);
_ammo = "Sh_82mm_AMOS";
_spawnHeight = 200;

for "_i" from 1 to _nrBarrages do {
	sleep _travelTime;
	for "_y" from 1 to _nrRounds do {
		_exit = false;
		_pos = getPosATL _target;
		for "_z" from 0 to 20 do {
			_tmppos = [_pos,_dist] call CBA_fnc_randPos;
			if ([_target,_tmppos] call BIS_fnc_inTrigger) exitWith {
				_pos = _tmppos;
			};
		};
		_pos set [2,_spawnHeight];
		_bomb = createVehicle [_ammo,_pos, [], 0, "NONE"];
		sleep 0.1;
		 _bomb setVectorDirAndUp [[0,0,-1],[0,1,0]];
		_bomb setVelocity [0,0,-200];
		sleep 3+(random 3);
	};
};

true