/*
	Function: FP_fnc_removeAction
	
	Description: 
		Removes an action from target globally. Only call this function from ONE client or the server.

	Parameters:
		_obj - Target to remove action from [Object]
		_id - action ID to remove [Integer]

	Examples: 
	(begin example) 
		[theVIP,0] call FP_removeAction;
	(end) 

	Returns:
	BOOL

	Author: 
	Cuel 2015-01-07
*/

_obj = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_id = [_this,1,-999,[0]] call BIS_fnc_param;

if (isNull _obj || _id == -999)  exitWith {
	["Wrong parameters for FP_removeAction : %1", _this] call BIS_fnc_error;
	 false
};

[[[_obj, _id],{(_this select 0) removeAction (_this select 1)}], "BIS_fnc_spawn", true, true] call BIS_fnc_MP;

true