/*
	Function: FP_fnc_switchMove

	API:
		Any

	Description:
		Plays animation globally using switchMove. Only call this function from ONE client or the server.

	Parameters:
		_obj - Target to playMove on [Object]
		_id -  Name of animation [String]

	Examples:
	(begin example)
		[player,"acts_CrouchingFiringLeftRifle01"] call FP_fnc_switchMove;
	(end)

	Returns:
	BOOL

	Author:
	Cuel 2015-01-07
*/

params [["_unit", objNull, [objNull]], ["_anim", "", [""]]];

if (isNull _unit)  exitWith {
	["Wrong parameters: %1", _this] call BIS_fnc_error;
	false
};

[[[_unit, _anim],{(_this select 0) switchMove (_this select 1)}], "BIS_fnc_spawn", true] call BIS_fnc_MP;

true
