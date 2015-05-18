/*
	Function: FP_fnc_getPlayer

	API:
		Any

	Description:
		Takes a string and returns a player object if found, otherwise objNull

		Can be used partially, to find "cuel" you can pass ["cu"]

		Will be objNull if not found, or if theres more than one match

		Case insensitive

	Parameters:
		_name - Player name

	Examples:
	(begin example)
		_cuel = ["Cuel"] call FP_fnc_getPlayer;
	(end)

	Returns:
	OBJECT

	Author:
	Cuel 2015-04-21
*/

private ["_ret", "_matches"];
_ret = objNull;
_matches = [];

if (typeName _this == typeName []) then {_this = _this select 0};
if (typeName _this != typeName "")  exitWith {
	["Wrong parameters: %1",_this] call BIS_fnc_error;
	_ret
};

{
	if ([_this, name _x] call bis_fnc_inString) then {
		_matches pushBack _x;
	};
}forEach ([] call CBA_fnc_players);

if (count _matches == 1) then {
	_ret = _matches select 0;
};

_ret
