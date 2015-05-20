/*
	Function: FP_JRM_fnc_forceRespawn

	Description:
		Force respawns of all current dead units
		Must be called on all computers including server

		Player will be invulnerable until the blackout has finished.

	Parameters:
	_posOrCode - A position or code/function. If nil, normal "respawn_X" markers will be used
	_blackOutDelay - The delay for the black screen to fade back in. [Default: 2]

	Examples:
	(begin example)
		[] call FP_JRM_fnc_forceRespawn; // units will respawn at their respective "respawn_X" markers

		["marker1", 4] call FP_JRM_fnc_forceRespawn; // units will be spawned at that marker and black screen will last 4 seconds

		[{_unit = _this select 0; _unit setPosASL myBoat}] call FP_JRM_fnc_forceRespawn; // unit will exit and call the code
		["customFunction", 4] call FP_JRM_fnc_forceRespawn; // unit will exit and call function, black screen lasts 4 seconds
	(end)

	Author:
	Cuel 2015-05-15
*/


if (isServer) then {
	FP_JRM_deadPlayers = [];
	publicVariable "FP_JRM_deadPlayers";
};

if (isNil "FP_JRM_playerDead" || {!FP_JRM_playerDead} || {isDedicated}) exitWith {};
_this spawn {

FP_JRM_playerDead = false;

if (typeName _this != typeName []) then {_this = [_this]};
_posOrCode = _this select 0;
_blackOutDelay = [_this, 1, 2, [0]] call BIS_fnc_param;

// safe spawn back in if users are clicking around in the spec UI
_firedEV = player addEventHandler ["Fired", {
	[_this select 6] call ace_frag_fnc_addBlackList;
	deleteVehicle (_this select 6);
}];

["FP_ScreenSpect", true] call BIS_fnc_blackOut;
sleep 2;
[] call F_fnc_forceExit;

// Figure out if a marker or code was passed, or a position
private ["_function", "_pos"];
if (isNil "_posOrCode") then {
	_pos = (["respawn_west", "respawn_east", "respawn_guerrila", "respawn_civilian"]
		select ([blufor, opfor, independent, civilian] find side player)) call CBA_fnc_getPos;
} else {
		if (typeName _posOrCode == typeName {}) then {
			_function = _posOrCode;
		} else {
			if (typeName _posOrCode == typeName "") then {
				_function = missionNamespace getVariable _posOrCode;
				if (isNil "_function") then {
					_pos = markerPos _posOrCode;
				};
			} else {
				_pos = _posOrCode call CBA_fnc_getPos;
			};
		};
};

if (!isNil "_pos") then {
	player setPos _pos;
}else{
	[player] call _function;
};

sleep _blackOutDelay;
["FP_ScreenSpect"] call BIS_fnc_blackIn;

uiSleep 2;
player removeEventHandler ["Fired", _firedEV];
player allowDamage true;

};
