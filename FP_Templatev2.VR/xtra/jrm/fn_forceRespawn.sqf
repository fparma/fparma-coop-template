/*
	Function: FP_JRM_fnc_forceRespawn

	Description:
		Force respawns of all current dead units

	Author:
	Cuel 2015-05-15
*/

["FP_ScreenSpect", true] call BIS_fnc_blackOut;
uiSleep 2;

[] call F_fnc_forceExit;
_pos = (markerPos (["respawn_west", "respawn_east", "respawn_guer", "respawn_civilian"] select ([blufor, opfor, independent, civilian] find side player)));
player setPosATL ([_pos, 5] call CBA_fnc_randPos);

uiSleep 2;
["FP_ScreenSpect"] call BIS_fnc_blackIn;
