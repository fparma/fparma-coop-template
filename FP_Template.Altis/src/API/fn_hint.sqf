/*
	Function: FP_fnc_hint
	
	Description: 
		Sends hint globally. Only call this function from ONE client or server

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

if (typeName _this == typeName []) then {_this = _this select 0;};
if (typeName _this != typeName "")  exitWith {
	["Wrong parameters: %1",_this] call BIS_fnc_error;
	false
};

[_this, "hint", true] call BIS_fnc_MP;

true