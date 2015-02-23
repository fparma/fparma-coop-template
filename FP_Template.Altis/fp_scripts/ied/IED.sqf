// by SSG Pelle
//	Call the IED via a trigger. Place the trigger near the IED.
//	Example trigger activation:  getposATL (thislist select 0) select 2 < 5
//	Example script call via trigger: 0 = [iedobject] execVM "fp_scripts\IED\IED.sqf";

if (!isServer) exitWith {};

_obj = _this select 0;
if (isNil "_obj") exitWith {};
if (!alive _obj) exitWith {};
//this is the explosion type
_pos = getPosATL _obj;
_ammoType = "M_Titan_AT";
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
	_bomb = _ammoType createVehicle[_pos select 0, _pos select 1, (_pos select 2)+0.1];
	sleep .1;
	_crater = createVehicle ["CraterLong_small", _pos, [], 0, "NONE"];
	_crater spawn {
		sleep 300;
		deleteVehicle _this;
	};
};