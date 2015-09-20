
if (FP_JRM_respawns < 0 || !isMultiplayer) exitWith {};
if (isNil "FP_JRM_savedState") then {FP_JRM_savedState = []};

if (isServer) then {

	// If players disconnect while unconscious, count as a death
	addMissionEventHandler ["HandleDisconnect", {
		_unit = _this select 0;
		_uid = [_this, 2, "", [""]] call BIS_fnc_param;
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
		    FP_JRM_savedState set [_idx, _livesLeft];
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

// If player rejoins, get their amount of lives
{
	if (_x select 0 == _uid) exitWith {
		FP_JRM_lives = _x select 1;
		if (FP_JRM_lives == 0) then {
			[true] spawn ace_spectator_fnc_stageSpectator;
		};
	};
} forEach FP_JRM_savedState;

player addEventHandler ["Respawn", {
	_idx = -1;
	_uid = getPlayerUID player;
	_livesLeft = (FP_JRM_lives - 1) max 0;

	{
	    if (_x select 0 == _uid) exitWith {_idx = _forEachIndex};
	} forEach FP_JRM_savedState;

	if (_idx > -1) then {
	    FP_JRM_savedState set [_idx, _livesLeft];
	} else {
		FP_JRM_savedState pushBack [_uid, _livesLeft];
	};
	publicVariable "FP_JRM_savedState";

	// check on global var since 1 respawn
	if (FP_JRM_lives < 1) then {
		[true] spawn ace_spectator_fnc_stageSpectator;
	};

	FP_JRM_lives = _livesLeft;
}];
