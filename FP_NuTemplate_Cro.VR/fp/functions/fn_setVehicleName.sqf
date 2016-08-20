/*
	Function: FP_fnc_setVehicleName

	API:
		Client

	Description:
		Adds action to vehicle to display its name

	Parameters:
		_veh - Vehicle
		_name - String, vehicle name

	Examples:
	(begin example)
        [this, "Car One"] call FP_fnc_setVehicleName;
	(end)

	Returns:
	   BOOL

	Author:
	   Cuel 2015-04-23
*/

if (!hasInterface) exitWith {};
if (!params [
  ["_veh", objNull, [objNull]],
  ["_name", "", [""]]
]) exitWith {false};

_veh addAction ["<t color=""#ffa500"">[ " + _name + " ]</t>",
  "", 0, 100, true, true,"",
  "_this distance _target < 6 && vehicle ACE_player == ACE_player"
];

true
