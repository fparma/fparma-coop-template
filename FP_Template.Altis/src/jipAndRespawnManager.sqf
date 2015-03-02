//if (!isMultiplayer) exitWith{};

// Note: IF USING this, respawn type must be BASE.

if (isNil "FP_jrm_savedDeaths") then {
	FP_jrm_savedDeaths = [];
};

/* Both */
FP_jrm_decreaseLives = {
	_uid = [_this, 0, "", [""]] call BIS_fnc_param;
	if (_uid == "") exitWith {-1};

	if (FP_jrm_amountLives < 0) exitWith {-1};
	_amountLives = FP_jrm_amountLives;

	_idx = -1;
	{
		if (_x select 0 == FP_clientUID) exitWith {
			_idx = _foreachindex;
			_amountLives = _x select 1;
		};
	}forEach FP_jrm_savedDeaths;

	if (_idx > -1) then {
		FP_jrm_savedDeaths set [_idx, [FP_clientUID, 0 max (_amountLives -1)]];
	}else{
		FP_jrm_savedDeaths pushback [FP_clientUID, 0 max (_amountLives -1)];
	};
	publicVariable "FP_jrm_savedDeaths";
	_amountLives
};

/* Clients */
if (!isDedicated) then {
	[] spawn {
		waitUntil {!isNull player && {getPlayerUID player != ""}};

		FP_clientUID = getPlayerUID player;

		player addEventHandler ["Killed", {
			_amountLives = [FP_clientUID] call FP_jrm_decreaseLives;
			if (_amountLives isEqualTo -1) exitWith {};
			if (_amountLives isEqualTo 0) then {
				[[FP_clientUID] ,"FP_jrm_playerDied",false, false] call BIS_fnc_MP;
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
};

if (!isServer) exitWith{};

/* Server */

FP_jrm_deadPlayers = [];

FP_jrm_playerDied = {
	_uid = [_this, 0, "", [""]] call BIS_fnc_param;

	/* Saves death */
	if (time > 1 && _uid != "" && {!(_uid in FP_jrm_deadPlayers)}) then  {
		FP_jrm_deadPlayers pushback _uid;
	};
};

/* Handles JIPs connecting. Time is most precise on the server. It also knows where units are more precise*/
FP_jrm_playerConnected = {
	_uid = [_this,0,"",[""]] call BIS_fnc_param;
	if (_uid == "") exitWith {};

	_timeout = time + 20;
	_unit = objNull;

	while {isNull _unit} do
	{
		{ // forEach
			if (getPlayerUID _x == _uid) exitWith{
				_unit = _x;
			};
		}foreach ([] call CBA_fnc_players);
		sleep .2;
		if (time > _timeout) exitWith{};
	};

	if (isNull _unit) exitWith{};

	// We have the player object
	if (_uid in FP_jrm_deadPlayers || {FP_jrm_timeBeforeJIPNotPossible > -1 && (time > (1 max FP_jrm_timeBeforeJIPNotPossible))}) then {
		/* Let player init this script so he has the killed EV */
		waitUntil {isNull _unit || (_unit getVariable ["FP_jrm_isInit",false])};
		// Timeout
		if (isNull _unit) exitWith{};

		_unit setDamage 1;
		//deleteVehicle _unit;
		hideObjectGlobal _unit;

	}else{

		if (FP_jrm_JIPTeleport) then {
			private ["_pos","_found","_goodPos"];
			_goodPos = {
				_pos = if (typename _this == typename objnull) then {_this modelToWorld [0,-2,0]}else{_this};
				_pos = (_pos call CBA_fnc_getPos);
				_realPos = (_pos findEmptyPosition [0,50]);
				if (count _realPos > 0) then {_pos = _realPos};
				_pos set [2,0];
				_pos
			};

			_tppos = [];
			if (leader group _unit == _unit) then {
				// unit is leader
				_averagex=0;
				_averagey=0;
				_sideUnits = [];

				if (count units group _unit == 1) then {
					// no units in group
					{
						if (alive _x && {side _x == side _unit} && {_x != _unit} && {(getPosATL _x) select 2 < 10} && {getPosATL _x distance [0,0,0] > 10}) then {
							_sideUnits pushBack _x;
						};
					}forEach ([]call CBA_fnc_players);
				}else{
					// units in group
					{
						if (alive _x && {(getPosATL _x) select 2 < 10} && {_x != _unit}) then {
							_sideUnits pushback _x;
						};
					}forEach (units group _unit);
				};

				if (count _sideUnits == 0) exitWith{};
				_divide = count _sideUnits;
				{_averagex=_averagex+(getPosATL vehicle _x select 0);_averagey=_averagey+(getPosATL vehicle _x select 1)} forEach _sideUnits;
				_tppos= [_averagex/_divide,_averagey/_divide,0];
				_tppos = _tppos call _goodPos;

			}else{
				// tp to leader
				_tppos = (leader group _unit) call _goodPos;
			};
			if (count _tppos > 0 && {_tppos distance [0,0,0] > 10}) then {
				_unit setPosATL _tppos;
			};
		};
	};
};

["FP_jrm_playerConnectedEV","onPlayerConnected",{if (time < 15 || {_name == "__SERVER__"}) exitWith {}; [_uid] spawn FP_jrm_playerConnected}] call BIS_fnc_addStackedEventHandler;

// If players disconnect while unconscious, count as a death
addMissionEventHandler ["HandleDisconnect", {
	if (FP_jrm_amountLives < 0) exitWith{false};
	_unit = _this select 0;
	_uid = [_this, 2, "", [""]] call BIS_fnc_param;
	if (_uid == "") exitWith {false};

	if (_unit getVariable ["AGM_isUnconscious", false]) then {
		_amountLives = [_uid] call FP_jrm_decreaseLives;
		if (_amountLives isEqualTo 0 && {!(_uid in FP_jrm_deadPlayers)}) then {
			FP_jrm_deadPlayers pushBack _uid;
		};
	};
	false
}];
