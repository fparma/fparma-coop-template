/*
	Function: FP_fnc_disableWeapons

	API:
		Unit must be local

	Description:
        Disables unit bullets, grenades etc.

	Parameters:
        _unit - Unit to disable weapons on
        _disable - True to disable weapons, false for vice versa

	Returns: BOOL
	Author:
		Cuel 2015-10-29
*/

params ["_unit", "_disable"];

if (!local _unit) exitWith {};
local _evtIndex =  _unit getVariable ["FP_firedEV", -1];

if (_disable) then {
	if (_evtIndex > -1) exitWith {};

	local _firedEv =_unit addEventHandler ["Fired", {
		local _proj = param [6, objNull];
		if (!isNull _proj) then {
			[_proj] call ace_frag_fnc_addBlackList;
    		deleteVehicle _proj;
		};
	}];
	_unit setVariable ["FP_firedEV", _firedEv];
} else {
	_unit removeEventHandler ["Fired", _evtIndex];
};
