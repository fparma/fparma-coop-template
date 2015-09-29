/*
	Function: FP_fnc_addCuratorObject

	API:
		Server only

	Description:
		Adds <whatever> to Curators ( zeus )

	Parameters:
		_obj - Target to add

	Examples:
	(begin example)
		[someObject] call FP_fnc_addCuratorObject
	(end)

	Author:
	Cuel 2015-01-16
*/

if (!isServer) exitWith {};
params ["_add"];

{
	_x addCuratorEditableObjects [_add,  true];
} foreach allCurators;
