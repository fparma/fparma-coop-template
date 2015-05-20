 /*
	Function: FP_fnc_getKit

	Description:
		This function will give units a predefined kit.

		To change the "default" gear (when callign without a scriptFile), edit config.sqf

		As an example if a unit have [this, "PLT", "vanilla_nato"] call FP_fnc_getKit;
		It will do the case "PLT" inside gear\loadouts\vanilla_nato.sqf

	Parameters:
		_obj - Unit to apply loadout to [Object].
		_kit - Name of an SQF file inside the _folder [String]
		_scriptFile - (Optional) Override the default folder (see config.js). Useful for AI or players that are on different sides [String]

	Examples:
	(begin example)
		// unit init in editor
		[this, "ATASS"] call FP_fnc_getKit; // would apply the gear in the case "ATASS" inside whatever FP_GEAR_DEFAULT is defined as (see config.sqf)

		[this, "PLT", "taki"] call FP_fnc_getKit; // would aply "PLT" from gear\loadouts\taki.sqf
	(end)

	Author:
	Cuel 2015-01-07
*/

private ["_unit", "_kit", "_scriptFile", "_script"];
_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_kit = toUpper ([_this,1,"",[""]] call BIS_fnc_param);
_scriptFile = [_this, 2, FP_GEAR_DEFAULT] call BIS_fnc_param;

// For respawn, retrieved in base init after player is inited
_unit setVariable ["FP_kit_type", [_kit, _scriptFile]];
_unit setVariable ["BIS_enableRandomization", false];

if (!local _unit) exitWith {};

removeHeadgear _unit;
removeAllContainers _unit;
removeAllItems _unit;
removeAllWeapons _unit;
removeAllAssignedItems _unit;

// Shows errors after 3 seconds, all units are done then
if (FP_GEAR_REPORT_ERRORS && {isNil "FP_gear_errs"}) then {
	FP_gear_errs = [];
	[] spawn {
		sleep 3;
		if (count FP_gear_errs > 0) then {
	    _structured = [];
      {
          _structured pushBack _x;
          _structured pushBack lineBreak;
      }forEach FP_gear_errs;

			"GEAR ERRORS" hintC composeText _structured;
			FP_gear_errs = nil; // reset for later calls
		};
	};
};

_script = compile preprocessFileLineNumbers ("gear\loadouts\" + _scriptFile + ".sqf");
[_unit, _kit] call _script;
