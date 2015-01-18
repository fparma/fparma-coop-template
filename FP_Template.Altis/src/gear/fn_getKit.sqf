/*
	Function: FP_fnc_getKit
	
	Description: 
		This function will give units a predefined kit.

		Change the _GEAR variable to change side, loadout etc. 

		As an example, if I wanted to give BLUFOR british loadouts I'd change _GEAR to 

		_GEAR = "blufor\britbong";

		Note that the "kit" string must be an existing .SQF file inside the _GEAR path folder.

		The _defineItems.sqf inside the folders is used to define stuff that later can be referenced in the gear scripts.

	Parameters:
		_obj - Unit to apply loadout to [Object].
		_kit - Name of SQF file inside the _GEAR path folder. [String]

	Examples: 
	(begin example) 
		// unit init in editor
		[this, "ATASS"] call FP_fnc_getKit; // would apply the gear defined in ATASS.sqf inside "blufor\vanilla" if path is set to that
	(end) 

	Author: 
	Cuel 2015-01-07
*/

_GEAR = "blufor\vanilla";

_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_kit = toUpper ([_this,1,"",[""]] call BIS_fnc_param);
_unit setVariable ["FP_kit_type", _kit]; // for respawn

if (local _unit) then {
	removeHeadgear _unit;
	removeAllContainers _unit;
	removeAllItems _unit;
	removeAllWeapons _unit;
	removeAllAssignedItems _unit;

	// assign gear
	_FULLPATH = ("src\gear\" + _GEAR + "\" + _kit + ".sqf");
	[_unit] call compile preprocessFileLineNumbers _FULLPATH;
};