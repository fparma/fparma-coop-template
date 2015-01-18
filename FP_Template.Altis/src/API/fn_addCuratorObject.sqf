/*
	Function: FP_fnc_addCuratorObject
	
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

_add = if (typeName _this != typeName []) then {[_this]} else {_this};

{
	_x addCuratorEditableObjects [_add,  true];
} foreach allCurators;