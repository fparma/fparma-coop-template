/*
	Function: FP_fnc_spectate

	API:
		Client

	Description:
		Puts the player in spectate (or not)

	Parameters:
		_spectate - Bool

	Examples:
	(begin example)
		[true] call FP_fnc_spectate
	(end)

	Author:
		Cuel 2015-12-09
*/

if (!hasInterface) exitWith {};
params [["_spectate", false]];

[{time > 0}, {
  [player, _this] call ace_spectator_fnc_stageSpectator;
  [_this] call ace_spectator_fnc_setSpectator;
}, _spectate] call ACE_common_fnc_waitUntilAndExecute;
