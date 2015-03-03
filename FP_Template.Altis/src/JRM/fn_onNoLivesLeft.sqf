/*
	Function: FP_JRM_fnc_onNoLivesLeft

	Description:
		Called when player has no remaining respawns

        Can be called from both client and server but will only be executed on the server.

        Server saves that death and will prevent any further respawns, even when client disconnects

	Parameters:
        _uid - Player UID

	Author:
	Cuel 2015-03-03
*/

if (!isServer) exitWith {
    [[FP_clientUID] ,"FP_jrm_playerDied",false, false] call BIS_fnc_MP;
};

_uid = [_this, 0, "", [""]] call BIS_fnc_param;
if (_uid == "") exitWith {["Faulty UID received"] call BIS_fnc_error};

if  (time > 1 && {!(_uid in FP_jrm_deadPlayers)}) then  {
    FP_jrm_deadPlayers pushback _uid;
};
