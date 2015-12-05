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

params ["_unit", ["_disableWeapons", true]];
if (!local _unit) exitWith {};

private ["_evtIndex", "_firedEv";
 _evtIndex =  _unit getVariable ["FP_firedEV", -1];

if (_disableWeapons) exitWith {
	if (_evtIndex > -1) then {
		_firedEv =_unit addEventHandler ["Fired", {
			private _proj = param [6, objNull];
			[_proj] call ace_frag_fnc_addBlackList;
			deleteVehicle _proj;
		}];
	};
	_unit setVariable ["FP_firedEV", _firedEv];
};

_unit removeEventHandler ["Fired", _evtIndex];
