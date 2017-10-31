/*
	Script cold_start.sqf

	Description:
    Cold start disables firing, throwing grenades etc at mission until
    Until someone who can start the mission starts it.

    Parameters:
      _starters - Array, comma separated list of units who can start the mission
      _movers - Array, comma separated list of units who can move. _starters is added to this list automatically

    Example:
      initPlyerLocal.sqf
      (begin)
        [
          "gm0, gm1, plt0", // can start
          "plt1, a0, a1, a2, b0, b1, b2, e0, q0, q1, q2, w0, w1, l0, l1" // can move
        ] call compile preprocessFileLineNumbers "scripts\cold_start.sqf";
      (end)

  Returns: BOOLEAN

	Author:
		Cuel 2015-12-08
*/

if (!hasInterface || {!isNil "FP_coldStartStarted"}) exitWith {false};

if (!params [
  ["_starters", "", [""]],
  ["_movers", ""]
]) exitWith {false};
if (!isNil "FP_coldStartStarted" && {FP_coldStartStarted}) exitWith {false};

private _canStart = [_starters, false, true] call ACE_common_fnc_parseList;
private _canMove = [_starters + "," + _movers, false, true] call ACE_common_fnc_parseList;

if (count _canStart == 0) exitWith {false};

// event to handle mission start
FP_coldStartIdx = ["FP_coldStart", {
  if (!isNil "FP_coldStartAction") then {
    player removeAction FP_coldStartAction;
    FP_coldStartAction = nil;
  };
  hintSilent "Mission going live, weapons hot";
  [] spawn {
    sleep 4;
    [player, false] call FP_fnc_disableWeapons;
    hintSilent "";
  };
  ["FP_coldStart", FP_coldStartIdx] call CBA_fnc_removeEventHandler;
  FP_coldStartIdx = nil;
}] call CBA_fnc_addEventHandler;

// Disable weapons
[player, true] call FP_fnc_disableWeapons;

if (player in _canStart) then {
  // Action to start mission
  FP_coldStartAction = player addAction ["<t color='#ffff00'>[ Start mission (weapons hot) ]</t>", {
      FP_coldStartStarted = true;
      publicVariable "FP_coldStartStarted";
      ["FP_coldStart"] call CBA_fnc_globalEvent;
  }, nil, 99, false, true];
};

if (player in _canMove) exitWith {true};
// Units that can't move
[{
  if (!isNil "FP_coldStartStarted") exitWith {[_this select 1] call CBA_fnc_removePerFrameHandler};
  if (player distance (_this select 0) > 20) then {
    (vehicle player) setVelocity [0,0,0];
    player setPosATL (_this select 0);
    hintSilent "You can't move until the mission has started";
    [] spawn {sleep 4; hintSilent ""};
  };
}, 1.23, getPosATL player] call CBA_fnc_addPerFrameHandler;

true
