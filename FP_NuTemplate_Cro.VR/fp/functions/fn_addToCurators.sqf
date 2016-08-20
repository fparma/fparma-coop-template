/*
	Function: FP_fnc_addToCurators

	API:
		Server only

	Description:
		Adds <whatever> to Curators ( zeus )

	Parameters:
		_obj - Target to add

	Example:
	(begin example)
		[someObject] call FP_fnc_addToCurators
	(end)

	Author:
		Cuel 2015-01-16
*/

if (!isServer) exitWith {
  _this remoteExecCall ["FP_fnc_addToCurators", 2];
};

private _add = if (typeName _this != typeName []) then {[_this]} else {_this};

{
  _x addCuratorEditableObjects [_add,  true];
} foreach allCurators;
