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
if (!params [["_veh", objNull, [objNull]]]) exitWith {false};

clearWeaponCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearBackpackCargoGlobal _veh;
clearItemCargoGlobal _veh;

true
