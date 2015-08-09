/*
	Function: FP_fnc_removeAction

	API:
		Any

	Description:
		Removes an action from target globally. Only call this function from ONE client or the server.

	Parameters:
		_obj - Target to remove action from [Object]
		_id - action ID to remove [Integer]

	Examples:
	(begin example)
		[theVIP,0] call FP_fnc_removeAction;
	(end)

	Returns:
	BOOL

	Author:
	Cuel 2015-01-07
*/

params [["_obj", objNull, [objNull]], ["_id", -999, [0]]];

if (isNull _obj || _id == -999)  exitWith {
	["Wrong parameters : %1", _this] call BIS_fnc_error;
	 false
};

[[[_obj, _id],{(_this select 0) removeAction (_this select 1)}], "BIS_fnc_spawn", true, true] call BIS_fnc_MP;

true
