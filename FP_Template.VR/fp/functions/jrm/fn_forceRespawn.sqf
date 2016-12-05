/*
	Function: FP_JRM_fnc_forceRespawn

	Description:
		Force respawns of all current dead units
		Should be called on all computers if it is a global respawn
		Can also be used to respawn a single unit when called locally

	Parameters:
	_posOrCode - A marker, object, position,  or code (can also be string code) (_this select 0 will be the unit for code)
		If position, will be teleported there after exiting spectator
    If code, the code is assumed to handle turning spectator off (FP_fnc_spectate)
		If nil, ace spectator will teleport the unit back to where he was when entering spectator (respawn pos)
	_reset - Clear all previous dead units [Default: false]

    Example:
    (begin example)
        ["respawn_west", true] call FP_JRM_fnc_forceRespawn;
    (end)

	Author:
	Cuel 2015-05-15
*/

params ["_posOrCode", ["_reset", false]];

if (_reset) then {
  FP_JRM_lives = FP_JRM_respawns;
  if (isServer) then {
    FP_JRM_savedState = [];
    publicVariable "FP_JRM_savedState";
  };
};

if (!hasInterface || {!ACE_spectator_isSet}) exitWith {};

// Figure out if a marker or code was passed, or a position
private ["_function", "_pos"];
if (!isNil "_posOrCode") then {
  if (_posOrCode isEqualType {}) then {
    _function = _posOrCode;
  } else {
    if (_posOrCode isEqualType "") then {
      _function = missionNamespace getVariable _posOrCode;
      if (isNil "_function") then {
        _pos = markerPos _posOrCode;
      };
    } else {
      _pos = _posOrCode call CBA_fnc_getPos;
    };
  };
};


if (!isNil "_pos") then {
  [false] call FP_fnc_spectate;
  // avoid putting everyone at the same pos, make it random
  player setPos ([_pos, 10] call CBA_fnc_randPos);
  {player reveal [_x, 4]} forEach nearestObjects [player, ["All"], 100];

  [player, true] call FP_fnc_disableWeapons;
  [{[player, false] call FP_fnc_disableWeapons}, [], 3] call CBA_fnc_waitAndExecute;
} else {
  if (!isNil "_function") then {
    [player] call _function;
  } else {
    // ace spectator handles the teleport
    [false] call FP_fnc_spectate;
  };
};
