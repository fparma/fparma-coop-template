/*
	Function: FP_JRM_fnc_forceRespawnClient

	Description:
    	Should not be used on its own, only call from FP_JRM_fnc_forceRespawn (server)

    Parameters:
		_pos - position to tp players after they respawn. [Optional]

	Author:
	Cuel 2015-03-13
*/


if (isDedicated) exitWith {};
if (alive player) exitWith {};

_pos = _this select 0;
if (isNil "_pos") then {
    _pos = [];
};

if (!isNull FP_JRM_deadPlayerUnit) then {
    deleteVehicle FP_JRM_deadPlayerUnit;
};

setPlayerRespawnTime 3;
cutText ["", "BLACK OUT", 2];
[_pos] spawn {
    _pos = _this select 0;
    waitUntil {alive player};
    [] call F_fnc_forceExit;
    if (count _pos > 0) then {
        sleep random 1;
        player setPos _pos;
    };
    cutText ["", "BLACK IN", 2];
};
