/*
	Function: FP_fnc_isValidPos

	API:
		Any

	Description:
		Small helper to check that positions are not [0,0]

	Parameters:
		_pos - Position

	Examples:
	(begin example)
		[100,100,0] call FP_fnc_isValidPos
	(end)

	Returns:
		Bool

	Author:
		Cuel 2015-12-09
*/

private _pos = _this call CBA_fnc_getPos;
if (count _pos < 2) exitWith {false};
!([_pos select 0, _pos select 1] isEqualTo [0,0])
