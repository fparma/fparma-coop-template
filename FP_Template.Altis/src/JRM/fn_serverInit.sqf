/*
	Function: FP_JRM_fnc_serverInit

	Description:
		Inits the server
		
	Author:
	Cuel 2015-03-03
*/

if (!isServer) exitWith {};

if (isNil "FP_jrm_savedDeaths") then {
	FP_jrm_savedDeaths = [];
};

FP_jrm_deadPlayers = [];

["FP_jrm_playerConnectedEV","onPlayerConnected",{
	if (time < 10 || {_name == "__SERVER__"}) exitWith {};
	[_uid] call FP_JRM_fnc_onPlayerConnected;
}] call BIS_fnc_addStackedEventHandler;


// If players disconnect while unconscious, count as a death
addMissionEventHandler ["HandleDisconnect", {
	if (FP_jrm_amountLives < 0) exitWith{false};
	_unit = _this select 0;
	_uid = [_this, 2, "", [""]] call BIS_fnc_param;
	if (_uid == "") exitWith {false};

	if (_unit getVariable ["AGM_isUnconscious", false]) then {
		_amountLives = [_uid] call FP_JRM_fnc_decreaseLivesLeft;
		if (_amountLives isEqualTo 0 && {!(_uid in FP_jrm_deadPlayers)}) then {
			FP_jrm_deadPlayers pushBack _uid;
		};
	};
	false
}];
