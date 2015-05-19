/*
	Function: FP_fnc_clearVehicle

	API:
		Server

	Description:
		Clears a vehicle cargo etc

	Parameters:
		_veh - Vehicle

	Examples:
	(begin example)
        [car1] call FP_fnc_clearVehicle;
	(end)

	Returns:
	BOOL

	Author:
	Cuel 2015-04-23
*/

if (!isServer) exitWith {};

_veh = [_this,0,objNull, [objNull]] call BIS_fnc_param;
if (isNull _veh) exitWith {false};

clearWeaponCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearBackpackCargoGlobal _veh;
clearItemCargoGlobal _veh;

true
