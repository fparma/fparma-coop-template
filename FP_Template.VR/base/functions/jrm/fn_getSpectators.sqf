/*
	Function: FP_JRM_fnc_getSpectators

	Description:
        Returns (alive and connected) spectators as player objects

    Parameter:
        _amount - Max ammount to return (default: all)

    Returns:
        Array

	Author:
	Cuel 2015-12-10
*/

params [["_amount", count FP_JRM_savedState]];
private _plrs = allPlayers;
private _ret = [];

{
    _x params ["_uid"];
    {
        if (alive _x && {getPlayerUID _x == _uid}) exitWith {
            _ret pushBack _x;
        };
    } forEach _plrs;

    if (count _ret >= _amount) exitWith {};
} forEach ([FP_JRM_savedState, {(_x select 1) == 0}] call ACE_common_fnc_filter);

_ret
