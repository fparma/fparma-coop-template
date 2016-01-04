/*
	Function: FP_fnc_disableWeapons

	API:
		Local unit

	Description:
        Disables unit bullets, grenades, detonating explosives etc.

	Parameters:
        _unit - Unit to disable weapons on
        _disable - True to disable weapons, false for vice versa

	Returns: BOOL
	Author:
		Cuel 2015-10-29
*/

params ["_unit", "_disable"];
if (!local _unit) exitWith {false};
if (isNil "FP_disableWeaponsID") then {FP_disableWeaponsID = -1};

if (_disable) then {
    if (player == _unit) then {
        FP_oldAce_detonate = ACE_explosives_fnc_detonateExplosive;
        ACE_explosives_fnc_detonateExplosive = {false};
        FP_disableWeaponsID = [_unit, "DefaultAction", {true}, {}] call ace_common_fnc_addActionEventHandler;
    };
    _unit setVariable ["FP_firedID",
        _unit addEventHandler ["Fired", {
            private _obj = param [6, objNull];
            if (!isNil "ace_frag_fnc_addBlackList") then {
                [_obj] call ace_frag_fnc_addBlackList;
            };
            deleteVehicle _obj;
        }]
    ];
} else {
    if (player == _unit) then {
        ACE_explosives_fnc_detonateExplosive = FP_oldAce_detonate;
        FP_oldAce_detonate = nil;
        [_unit, "DefaultAction", FP_disableWeaponsID] call ACE_common_fnc_removeActionEventHandler;
    };
    _unit removeEventHandler ["Fired", _unit getVariable ["FP_firedID", -1]];
};

true
