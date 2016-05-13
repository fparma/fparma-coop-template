/*
Script: Laptop

Description:
Hack the laptop. Specify the time and info retrieved when hacked

Parameters:
_target - Laptop object
_info - Message from laptop [String]
_time - Seconds taken to finish hack [Integer, optional default 90]
_callback - Code to execute once hack is finished. Parameter is the laptop [Code, optional]
Examples:
(begin example)
0 = [theLaptop, "Intel for you", 100, {(_this select 0) setDamage 1}] execVM "scripts\intel_laptop.sqf";
(end)

Returns:
ID from addAction.

Author:
Cuel, 2015-12-08
*/

if (!hasInterface) exitWith {};

params ["_laptop", ["_info", ""], ["_time", 90], ["_callback", {}]];
if (_laptop getVariable "fp_hack" isEqualType []) exitWith {};
_laptop setVariable ["fp_hack", [_info, _time, _callback]];

private _runHack = {
  params ["_laptop", "", "_id"];
  _laptop setVariable ["fp_inUse", 1, true];
  private _speaker = createVehicle ["Land_HelipadEmpty_F", getPosATL _laptop, [], 0, "NONE"];
  _speaker attachTo [_laptop,[0,0,0.5]];
  (_laptop getVariable "fp_hack") params ["_info", "_time", "_callback"];

  private _onSuccess = {
    (_this select 0) params ["_laptop", "_speaker", "_info", "_callback", "_id"];
    deleteVehicle _speaker;
    [_laptop, _id] remoteExecCall ["removeAction", 0];

    if (count _info > 0) then {
      private _idx = player getVariable ["fp_amountIntel", 1];
      player createDiaryRecord ["Diary",[("Laptop intel #" + str _idx), _info]];
      player setVariable ["fp_amountIntel", _idx + 1];
      hintSilent "Briefing note added with laptop intel";
      [] spawn {sleep 5; hintSilent ""};
    };
    [_laptop] call _callback;
    _laptop setVariable ["fp_inUse", nil, true];
  };

  private _onFail = {
    (_this select 0) params ["_laptop", "_speaker"];
    deleteVehicle _speaker;
    _laptop setVariable ["fp_inUse", 0, true];
  };

  private _condition = {
    (_this select 0) params ["_laptop", "_speaker"];

    if (round (_this select 1) > 24) then {
      private _delay = _speaker getVariable ["fp_sndDelay", 0];
      if (time > _delay) then {
        [[_speaker],"fp_harddrive"] call CBA_fnc_globalSay;
        _speaker setVariable ["fp_sndDelay", time + 6];
      };
    };
    (alive player && alive _laptop && !(player getVariable ["ACE_isUnconscious", false]) && player distance _laptop < 4)
  };
  [[_speaker], "fp_modem"] call CBA_fnc_globalSay;
  [_time, [_laptop, _speaker, _info, _callback, _id], _onSuccess, _onFail, "HACKING", _condition, []] call ace_common_fnc_progressBar;
};

(_laptop addAction ["<t color='#ff8a00'>\\ Download data //</t>", _runHack, 0, 9, false, true, "", "alive _target && _this distance _target < 4 && ((_target getVariable ['fp_inUse', 0]) != 1)"])
