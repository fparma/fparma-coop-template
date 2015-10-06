/*
	Function: FP_fnc_coldStart

	API:
		Client

    Parameters:
        _canStart - Units that can remove the lock and start mission
        _canMove - Units that are able to move

	Description:
        Disables player moving, bullets fired etc.


	Returns: BOOL
	Author:
		Cuel 2015-10-29
*/

params [
    ["_canStart", [], [[]]]
    ["_canMove", ["gm", "actual", "amed", "a0", "b0", "c0", "d0", "p0", "p1", "crew0", "crew1", "crew2"], [[]]]
]
if (count _canStart == 0) exitWith {};

if (str player in _canStart) then {
    FP_coldStartActionIdx = player addAction
};
