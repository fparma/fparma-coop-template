/*
///////////////////////////
	ARMA 3 function script
	Version: 0.1
	Author: Cuel
	Created: 2014-01-15
	Takes an object and animation name. Plays the switchMove globally. Example:
	 [player,"acts_CrouchingFiringLeftRifle01"] call FP_fnc_switchMove;
///////////////////////////
*/

_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_anim = [_this,1,"",[""]] call BIS_fnc_param;
if (isNull _unit)  exitWith {["Wrong parameters for FP_switchMove : %1 ",_this] call BIS_fnc_error; false};
[[_unit,_anim],"FP_fnc_local_switchMove",true,false] spawn BIS_fnc_MP;	
true