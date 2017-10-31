/*
    Author: Cuel

    Description:
      Applies loadout to a unit. This function is called from initPlayerlocal.sqf normally
      See README.txt for instructions

    Parameters
      _unit - Unit to apply loadout to
      _type - The "typeOf" unit to match in _loadout_config.sqf.
          This can be overriden. Or just use custom strings if needed

    Returns: BOOLEAN
*/

params [
  ["_unit", objNull, [objNull]],
  ["_type", "", [""]]
];

if (!local _unit) exitWith {false};

if (canSuspend) exitWith {
  [FP_fnc_getLoadout, _this] call CBA_fnc_directCall;
};

private _conf = call compile preprocessFileLineNumbers "loadouts\_loadout_config.sqf";
if (count _conf == 0) exitWith {false};

private _ele = _conf select {(toLower (_x select 0)) == (toLower _type)};

if (count _ele != 1) exitWith {
  if (!isMultiplayer) then {
    if (isNil "FP_LOADOUT_ERR") then {
      FP_LOADOUT_ERR = [];
      [{time > 2}, {"LOADOUT ERRORS" hintC composeText FP_LOADOUT_ERR; FP_LOADOUT_ERR = nil}, []] call CBA_fnc_waitUntilAndExecute;
    };
    FP_LOADOUT_ERR pushBack format ["LOADOUT: Found zero or duplicate loadouts for %1. (type %2)", str _unit, _type];
    FP_LOADOUT_ERR pushBack lineBreak;
  } else {
    diag_log format ["LOADOUT: Found zero or duplicate loadouts for %1. (type %2)", str _unit, _type];
  };
  false
};

_unit setVariable ["BIS_enableRandomization", false];
removeHeadgear _unit;
removeAllContainers _unit;
removeAllItems _unit;
removeAllWeapons _unit;
removeAllAssignedItems _unit;

[{
  params ["_args", "_script"];
  _args call compile preprocessFileLineNumbers ("loadouts\" + _script);
  if (player == (_args select 0)) then {[] call fpa_common_fnc_lowerPlayerWeapon};
}, [[_unit, _type], (_ele select 0) select 1]] call CBA_fnc_execNextFrame;

true
