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
        [car1, "Car One"] call FP_fnc_setVehicleName;
	(end)

	Returns:
	   BOOL

	Author:
	   Cuel 2015-04-23
*/

if (!hasInterface) exitWith {};

params [
    ["_veh", objNull],
    ["_name", "", ["", objNull]]
];

if (isNull _veh) exitWith {["Faulty parameters %1", _this] call BIS_fnc_error};

if (typeName _name == typeName objNull && {!isNull _name}) then {
    // Vehicle respawned
    private _oldveh = _this select 1;
    _name =  _oldveh getVariable ["fp_name","Vehicle"];

    private _varName = format ["VEH%1",round random 1000];
    _oldveh setVehicleVarName _VarName;
    _oldveh call compile format ["%1=_this ; publicVariable ""%1""",_varName];
    deleteVehicle _oldveh;
};

_veh addAction (call compile format ['["<t color=""#ffa500"">[ %1 ]</t>","",0, 100, true, true,"","_this distance _target < 6 && vehicle player == player"]', _name]);
_veh setVariable ["fp_name",_name];

true
