/*
	Function: FP_fnc_disableWeapons

	API:
		Local unit

	Description:
        Disables unit bullets, grenades, detonating explosives etc.

	Parameters:
        _unit - Unit to disable weapons on
        _disable - True to disable weapons, false for vice versa

  Examples:
    (begin)
      [player, true] call FP_fnc_disableWeapons;
    (end)

	Returns: BOOL

	Author:
		Cuel 2015-10-29
*/

params [["_unit", player], ["_disable", false]];
if (!local _unit) exitWith {false};

if (_disable) then {
  if (player == _unit) then {
    _unit setVariable ["FP_disableID",
        [_unit, "DefaultAction", {true}, {}] call ace_common_fnc_addActionEventHandler
    ];
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
    [_unit, "DefaultAction", _unit getVariable ["FP_disableID", -1]] call ACE_common_fnc_removeActionEventHandler;
  };
  _unit removeEventHandler ["Fired", _unit getVariable ["FP_firedID", -1]];
};

true
