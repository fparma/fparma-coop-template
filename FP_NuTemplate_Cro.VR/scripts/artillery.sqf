/*
    Script: Artillery

    API:
        Server

    Description:
        Fires artillery within a trigger

    Parameters:
        _target - Trigger to fire within
        _nrBarrages - Amount barrages [Default: 1]
        _nrRounds - Amount of rounds per barrage [Default: 3]
        _travelTime - Travel time for rounds to splash [Default: 5]

    Examples:
    (begin example)
        0 = [thisTrigger, 2, 2, 15] execVM "scripts\artillery.sqf"
    (end)

    Author:
    Cuel 2015-01-07
*/

private ["_target","_nrRounds","_nrBarrages","_travelTime","_ammo","_spawnHeight","_pos","_tmppos"];

params [
  ["_target", objNull],
  ["_nrBarrages", 1],
  ["_nrRounds", 3],
  ["_travelTime", 5]
];
if (isNull _target) exitWith {["ARTILLERY.SQF: Trigger is null! ",_this] call BIS_fnc_error; false};

_dist =    (triggerArea _target select 0) max (triggerArea _target select 1);
_ammo = "Sh_82mm_AMOS";
_spawnHeight = 250;

for "_i" from 1 to _nrBarrages do {
  sleep _travelTime;
  for "_y" from 1 to _nrRounds do {
    _pos =  [_target] call CBA_fnc_randPosArea;
    _pos set [2,_spawnHeight];
    if (_y == 1 || (random 1 < 0.4)) then {
      (["mortar1", "mortar2"] select (random 1 > 0.5))
          remoteExecCall ["playSound", allPlayers select {(_x distance2d _pos) < 100}];
    };
    sleep 0.1;
    _bomb = createVehicle [_ammo, _pos, [], 0, "NONE"];
    _bomb setVectorDirAndUp [[0,0,-1],[0,1,0]];
    _bomb setVelocity [0,0,-100];
    sleep 3+(random 3);
  };
};

true
