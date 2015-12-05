// Ares util functions
#define DISP_NAME "FP Utils"

[DISP_NAME, "Eject cargo", {
	private _obj = _this select 1;
	if (isNull _obj || {_obj isKindOf "Man"} || {speed _obj > 2}) exitWith {};

	private _units = assignedCargo _obj;
	{
		_x leaveVehicle (vehicle _x);
		_x action ["Eject", vehicle _x];
	}forEach _units;
}] call Ares_fnc_RegisterCustomModule;
