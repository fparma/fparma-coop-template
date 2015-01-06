// by SSG Pelle
//	Call the IED via a trigger. Place the trigger near the IED.
//	Example trigger activation:  getposATL (thislist select 0) select 2 < 5
//	Example script call via trigger: 0 = [iedobject] execVM "fp_scripts\IED\IED.sqf";

if (!isServer) exitWith {};

_obj = _this select 0;
if (isNil "_obj") exitWith {};
if (!alive _obj) exitWith {};
//this is the explosion type
_ammoType = "M_Mo_82mm_AT_LG";
//create the sound array
_buzzArray = ["fp_iedbuzz1", "fp_iedbuzz2", "fp_iedbuzz3", "fp_iedbuzz4", "fp_iedbuzz5"];
//Select random sound
_iedSound = _buzzArray select (floor (random (count _buzzArray)));

//play the sound
[[_obj], _iedSound] call CBA_fnc_globalSay;

//If the object is not destroyed
if (alive _obj) then 
{
	//wait for the sound to finish
	sleep 3.3;
	//remove the exploding object
	deletevehicle _obj;
	//create the explosion
	_ammoType createVehicle[(getposatl _obj select 0),(getposatl _obj select 1), (getposatl _obj select 2)+0.5];
};
