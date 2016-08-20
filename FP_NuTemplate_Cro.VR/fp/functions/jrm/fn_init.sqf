/*
	Function: FP_JRM_fnc_init

	Description:
        Initializes the jip and respawn manager.
        This function is called automatically.
*/
if (isNil "FP_JRM_savedState") then {FP_JRM_savedState = []};
if (FP_JRM_respawns < 0) exitWith {};
if (!isNil "FP_JRM_initialized") exitWith {};
FP_JRM_initialized = true;

if (isServer) then {
  // If players disconnect while unconscious, count as a death
  addMissionEventHandler ["HandleDisconnect", {
    params ["_unit", "", ["_uid", ""]];

    if (!alive _unit || _uid == "" || {!(_unit getVariable ["ACE_isUnconscious", false])}) exitWith {false};
    private _idx = -1;
    private _livesLeft = (FP_JRM_respawns - 1) max 0;

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
    Clients
*/
if (!hasInterface) exitWith {};
FP_JRM_lives = FP_JRM_respawns;

player addEventHandler ["Respawn", {
  private _idx = -1;
  private _uid = getPlayerUID player;
  FP_JRM_lives = (FP_JRM_lives - 1) max 0;

  if (FP_JRM_lives == 0) then {[true] call FP_fnc_spectate};

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
private _uid = getPlayerUID player;
{
  if (_x select 0 == _uid) exitWith {
    FP_JRM_lives = _x select 1;
    if (FP_JRM_lives == 0) then {
      [{time > 0.1}, {
        [true] call FP_fnc_spectate;
      }, []] call ace_common_fnc_waitUntilAndExecute;
    };
  };
} forEach FP_JRM_savedState;

// Add ARES respawn functionality
if (!isNil "Ares_fnc_RegisterCustomModule" && isNil "FP_ares_jrm") then {
  FP_ares_jrm = compile preprocessFileLineNumbers "fp\functions\jrm\ares_respawn_functions.sqf";
  private _text = "FP - Respawn";
  // Respawns and moves all players (that can fit) inside the cargo of a specific vehicle
  [_text, "Single unit at position", {["SINGLE", _this select 0] call FP_ares_jrm}] call Ares_fnc_RegisterCustomModule;
  // Respawns and moves all dead players to a position
  [_text, "All units at position", {["POSITION", _this select 0] call FP_ares_jrm}] call Ares_fnc_RegisterCustomModule;
  // Respawns and moves all players (that can fit) inside the cargo of a specific vehicle
  [_text, "Fill vehicle cargo", {["CARGO", _this select 1] call FP_ares_jrm}] call Ares_fnc_RegisterCustomModule;
};
