/*
	Function: FP_JRM_fnc_clientInit

	Description:
	Inits JRM on clients

	Author:
	Cuel 2015-03-03
*/

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

		FP_JRM_deadPlayerUnit = _this select 0;

		[FP_JRM_deadPlayerUnit] spawn {
			setPlayerRespawnTime 9999;
			sleep 1;
			[FP_JRM_deadPlayerUnit, FP_JRM_deadPlayerUnit, nil, nil, true] spawn F_fnc_CamInit;
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
