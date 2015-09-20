/*
	Function: FP_JRM_fnc_forceRespawn

	Description:
		Force respawns of all current dead units
		Must be called on all computers including server

	Parameters:
	_posOrCode - A position or code (_this select 0 is the unit)
		If nil, ace spectator will teleport the unti back to where he was when entering spectator (respawn pos)

	Author:
	Cuel 2015-05-15
*/

if (!hasInterface) exitWith {};
_this spawn {

_posOrCode = _this select 0;
_blackOutDelay = [_this, 1, 2, [0]] call BIS_fnc_param;

["FP_ScreenSpect", true] call BIS_fnc_blackOut;
sleep 2;

// Figure out if a marker or code was passed, or a position
private ["_function", "_pos"];
if (!isNil "_posOrCode") then {
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

[false] call ace_spectator_fnc_stageSpectator;
if (!isNil "_pos") then {
	player setPos _pos;
}else{
	[player] call _function;
};

sleep _blackOutDelay;
["FP_ScreenSpect"] call BIS_fnc_blackIn;
};
