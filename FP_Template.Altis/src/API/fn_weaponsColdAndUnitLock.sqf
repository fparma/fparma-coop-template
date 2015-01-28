/*
	Function: FP_fnc_weaponsColdAndUnitLock

	Description:
		Removes all bullets fired until mission has started. 

		Any units that are not leaders or defined in FP_noLockUnits will not be able to move far from their start position
		until any units defined in FP_missionStarters has started the mission.

		Needs to be executed on every client.

	Parameters:
		0 - Force active even if used before. Useful for e.g mission ending [Boolean]

	Author: 
		Cuel 2015-01-19
*/

if (isDedicated) exitWith{};

_force = [_this,0, false, [false]] call BIS_fnc_param;

if (!_force && !isNil "FP_coldLockActive") exitWith{};
FP_coldLockActive = true;

if (_force) then {
	FP_missionHasStarted = false;
};

if ((isNil "FP_missionHasStarted" || {!FP_missionHasStarted}) && {!isNil "FP_missionStarters"} && {count FP_missionStarters > 0}) then {

	_this spawn {

		if (str player in FP_missionStarters) then {
			FP_startMissionAction = player addAction ["<t color='#ffff00'>[ Start mission (weapons hot) ]</t>", {
				// Remove others action
				[{if (!isNil "FP_startMissionAction") then { player removeAction FP_startMissionAction; FP_startMissionAction = nil}}, "BIS_fnc_spawn", true] call BIS_fnc_MP;
				// Tell server to record the time misson was started. Time is most precise on the server.
				[{FP_missionStartTime = compileFinal str time; publicVariable "FP_missionStartTime"},"BIS_fnc_spawn", false] call BIS_fnc_MP;
	
				0 spawn {
					"Mission going live, weapons hot" call FP_fnc_hint;
					sleep 2;
					FP_missionHasStarted = true;
					publicVariable "FP_missionHasStarted";
					sleep 4;
					"" call FP_fnc_hint;
				};
			}, nil, 0, false, true];
		};
		
		_firedEv = player addEventHandler ["Fired", {deleteVehicle (_this select 6)}];
		_spawnPos = getPosATL player;
		if (str player in FP_noLockUnits || {count FP_noLockUnits == 0 && leader group player == player}) then {
			_spawnPos = [];
		};
		
		while {isNil "FP_missionHasStarted" || {!FP_missionHasStarted}} do {
			if (count _spawnPos > 0 && {player distance _spawnPos > 20}) then {
				vehicle player setPosATL _spawnPos;
			};
			sleep 2.23;
		};
		player removeEventHandler ["Fired", _firedEv];
	};	
};
