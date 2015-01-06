/*
by SSG Cuel

put a small trigger near your IED, activation once

in trigger:
condition: getposATL (thisList select 0) select 2 < 5 && (vehicle (thisList select 0)) isKindOf "Car" 
use this if you do not want AI to trigger
condition: getposATL (thisList select 0) select 2 < 5 && (vehicle (thisList select 0)) isKindOf "Car" && {isPlayer _x }count thisList > 0

on act: 0 = [(vehicle (thisList select 0)),nameOfIED] execVM "fp_scripts\IED\vehicle_IED.sqf";

params:
1 : (vehicle (thisList select 0)) << car
2:  name of object (ied);
*/

_car = _this select 0;
_ied = _this select 1;

if (isNil "_ied") exitWith {};
if (!(local _car)) exitWith {};

if (alive _ied) then 
{
	deleteVehicle _ied;
	"M_Mo_82mm_AT_LG" createVehicle [(getPosATL _ied select 0),(getPosATL _ied select 1),((getPosATL _ied select  2)-.2)];
	sleep 0.1;
	_car setHit ["wheel_1_1_steering",1];
	_car setHit ["wheel_2_1_steering",1];
};