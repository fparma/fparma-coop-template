/*
	Function: FP_JRM_fnc_onPlayerConnected
	Description:
		Called when a player connects. Only on server.
        Server finds the unit connected with the UID, and checks if he is allowed to be alive
        (hasn't died earlier, didn't disconnect while unconscious, did not JiP after JIP maxiumum time)
	Parameters:
		_uid - Client UID
	Author:
	Cuel 2015-03-03
*/

_this spawn {

_uid = [_this,0,"",[""]] call BIS_fnc_param;
if (_uid == "") exitWith {["Faulty UID received"] call BIS_fnc_error};

_timeout = time + 20;
_unit = objNull;

// Find the player object that has the UID
while {isNull _unit} do
{
    { // forEach all players
        if (getPlayerUID _x == _uid) exitWith{
            _unit = _x;
        };
    }foreach ([] call CBA_fnc_players);
    sleep .2;
    if (time > _timeout) exitWith{};
};

if (isNull _unit) exitWith{};

// We have the player object
if (_uid in FP_jrm_deadPlayers || {FP_jrm_timeBeforeJIPNotPossible > -1 && (time > (1 max FP_jrm_timeBeforeJIPNotPossible))}) then {
    /* Let player init this script so he has the killed EV */
    waitUntil {isNull _unit || (_unit getVariable ["FP_jrm_isInit",false])};
    // Timeout
    if (isNull _unit) exitWith {};

    _unit setDamage 1;
    sleep 1;
    deleteVehicle _unit;
}else{
    [_unit] call FP_JRM_fnc_jipTeleport;
};

};
