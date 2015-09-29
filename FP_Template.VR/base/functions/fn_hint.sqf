/*
	Function: FP_fnc_hint

	API:
		Any

	Description:
		Sends hint globally

	Parameters:
		_string - String to send globally

	Examples:
	(begin example)
		"hello world" call FP_fnc_hint;
	(end)

	Returns:
	BOOL

	Author:
	Cuel 2015-01-07
*/

params ["_str"];
[_str, "hint", true] call BIS_fnc_MP;

true
