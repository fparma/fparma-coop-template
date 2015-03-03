
if (isDedicated) exitWith{};

if (isNil "FP_jrm_savedDeaths") then {
	FP_jrm_savedDeaths = [];
};

_this spawn {

waitUntil {!isNull player && {getPlayerUID player != ""}};
FP_clientUID = getPlayerUID player;
FP_JRM_typeOfPlayer = typeOf player;

player addEventHandler ["Killed", {
	_amountLives = [FP_clientUID] call FP_JRM_fnc_decreaseLivesLeft;

	// lives are unlimited
	if (_amountLives isEqualTo -1) exitWith {};

	if (_amountLives isEqualTo 0) then {

		// player has no lives left, spawn spectator
		[FP_clientUID] call FP_JRM_fnc_onNoLivesLeft;

		[_this select 0] spawn {
			setPlayerRespawnTime 9999;
			[_this select 0, _this select 0, nil, nil, true] spawn F_fnc_CamInit;
		};

	}else{

		[_amountLives] spawn {
			waitUntil {alive player};
			hintSilent format ["Remaining lives: %1", _this select 0];
			sleep 5;
			hintSilent "";
		};

	};
}];

player setVariable ["FP_jrm_isInit",true, true];


};
