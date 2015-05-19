/*
	Function: FP_JRM_fnc_init

	Description:
		Inits JRM system

	Author:
	Cuel 2015-05-15
*/

if (FP_JRM_amountLives < 0 || !isMultiplayer) exitWith {};
if (isNil "FP_jrm_savedDeaths") then {FP_jrm_savedDeaths = []};

if (hasInterface) then {
	0 spawn {
		waitUntil {!isNull player && {getPlayerUID player != ""}};
		FP_clientUID = getPlayerUID player;

		player addEventHandler ["Killed", {
			([FP_clientUID] call FP_JRM_fnc_decreaseLivesLeft) spawn {
				_amountLives = _this;
				waitUntil {alive player};
				if (_amountLives isEqualTo 0) then {
					FP_JRM_playerDead = true;
					[player, player, nil, nil, true] spawn F_fnc_camInit;
				}else{
					hintSilent format ["Remaining lives: %1", _amountLives];
					sleep 5;
					hintSilent "";
				};
			};
		}];
	};
};

if (isServer) then {
	FP_jrm_deadPlayers = [];

	["FP_jrm_playerConnectedEV","onPlayerConnected",{
		if (time < 5) exitWith {};
		[_uid] call FP_JRM_fnc_onPlayerConnected;
	}] call BIS_fnc_addStackedEventHandler;


	// If players disconnect while unconscious, count as a death
	addMissionEventHandler ["HandleDisconnect", {
		_unit = _this select 0;
		_uid = [_this, 2, "", [""]] call BIS_fnc_param;
		if (_uid == "") exitWith {false};

		if (_unit getVariable ["ACE_isUnconscious", false]) then {
			_amountLives = [_uid] call FP_JRM_fnc_decreaseLivesLeft;
			if (_amountLives isEqualTo 0 && {!(_uid in FP_jrm_deadPlayers)}) then {
				FP_jrm_deadPlayers pushBack _uid;
			};
		};
		false
	}];
};
