/*
	Function: FP_fnc_clearVehicle

	API:
		Single (server or client)

	Description:
		Clears a vehicle cargo etc

	Parameters:
	   _veh - Vehicle

	Example:
	(begin example)
        if (isServer) then {[this] call FP_fnc_clearVehicle};
	(end)

	Returns:
	   BOOL

	Author:
	   Cuel 2015-04-23
*/

if (!params [
  ["_veh", objNull, [objNull]]
]) exitWith {false};

clearWeaponCargoGlobal _veh;
clearMagazineCargoGlobal _veh;
clearBackpackCargoGlobal _veh;
clearItemCargoGlobal _veh;

true
