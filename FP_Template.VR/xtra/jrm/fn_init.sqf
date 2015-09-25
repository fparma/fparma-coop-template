
if (FP_JRM_respawns < 0) exitWith {};
if (isNil "FP_JRM_savedState") then {FP_JRM_savedState = []};

if (isServer) then {
	// If players disconnect while unconscious, count as a death
	addMissionEventHandler ["HandleDisconnect", {
		param ["_unit"];
		param [2, "_uid", ""];

		if (_uid == "" || !(_unit getVariable ["ACE_isUnconscious", false])) exitWith {false};
		_idx = -1;
		_livesLeft = (FP_JRM_respawns - 1) max 0;

		{
		    if (_x select 0 == _uid) exitWith {
				_idx = _forEachIndex;
				_livesLeft = ((_x select 1) - 1) max 0;
			};
		} forEach FP_JRM_savedState;

		if (_idx > -1) then {
		    FP_JRM_savedState set [_idx, [_uid, _livesLeft]];
		} else {
			FP_JRM_savedState pushBack [_uid, _livesLeft];
		};
		publicVariable "FP_JRM_savedState";
		false
	}];
};

/*
* Clients
*/
if (!hasInterface) exitWith {};

FP_JRM_lives = FP_JRM_respawns;
_uid = getPlayerUID player;

player addEventHandler ["Respawn", {
	_idx = -1;
	_uid = getPlayerUID player;
	FP_JRM_lives = (FP_JRM_lives - 1) max 0;

	if (FP_JRM_lives < 1) then {
		[{
			[true] spawn ace_spectator_fnc_setSpectator;
			[player, true] spawn ace_spectator_fnc_stageSpectator;
		}, []] call ACE_common_fnc_execNextFrame;
	};

	// Update state
	{
	    if (_x select 0 == _uid) exitWith {_idx = _forEachIndex};
	} forEach FP_JRM_savedState;

	if (_idx > -1) then {
	    FP_JRM_savedState set [_idx, [_uid, FP_JRM_lives]];
	} else {
		FP_JRM_savedState pushBack [_uid, FP_JRM_lives];
	};
	publicVariable "FP_JRM_savedState";
}];

// If player rejoin, get their amount of lives and start spect if they're are considered dead
{
	if (_x select 0 == _uid) exitWith {
		FP_JRM_lives = _x select 1;
		if (FP_JRM_lives == 0) then {
			[{
				[true] spawn ace_spectator_fnc_setSpectator;
				[player, true] spawn ace_spectator_fnc_stageSpectator;
			}, []] call ACE_common_fnc_execNextFrame;
		};
	};
} forEach FP_JRM_savedState;
