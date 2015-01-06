// F3 - Spectator Script
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ====================================================================================
// gets all the playable units and filter out the AI.
private ["_arr"];
_arr = [];
{
	if (getPosATL _x distance [0,0,0] > 10) then {
		_arr pushBack _x;
	};
}foreach ([] call CBA_fnc_players);

_arr