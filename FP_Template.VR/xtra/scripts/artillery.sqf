/*
	Function: Artillery

	API:
		Server 

	Description:
		Fires artillery within a trigger

	Parameters:
		_target - Trigger to fire within
		_nrRounds - Amount of rounds per barrage [Default: 3]
		_nrBarrages - Amount barrages [Default: 1]
		_travelTime - Travel time for rounds to splash [Default: 20]

	Examples:
	(begin example)
		0 = [thisTrigger, 2, 2, 15] execVM "xtra\scripts\artillery.sqf"
	(end)

	Author:
	Cuel 2015-01-07
*/

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
