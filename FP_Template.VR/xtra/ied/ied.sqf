// by SSG Pelle
//	Call the IED via a trigger. Place the trigger near the IED.
//	Example trigger activation:  getposATL (thislist select 0) select 2 < 5
//	Example script call via trigger: 0 = [iedobject] execVM "xtra\ied\ied.sqf";

_obj = _this select 0;
if (isNil "_obj") exitWith {};
if (!alive _obj) exitWith {};

_pos = getPosATL _obj;
_ammoType = "M_Titan_AT";
_buzzArray = ["fp_iedbuzz1", "fp_iedbuzz2", "fp_iedbuzz3", "fp_iedbuzz4", "fp_iedbuzz5"];
_iedSound = _buzzArray select (floor (random (count _buzzArray)));
[[_obj], _iedSound] call CBA_fnc_globalSay;

if (alive _obj) then
{
	sleep 3.3;
	deletevehicle _obj;
	_bomb = _ammoType createVehicle[_pos select 0, _pos select 1, (_pos select 2)+0.1];
	sleep .1;
	_crater = createVehicle ["CraterLong_small", _pos, [], 0, "NONE"];
	[{
		deleteVehicle _this;
	}, _crater, 300] call ACE_common_fnc_waitAndExecute;
};
