/*
///////////////////////////
	ARMA 3 function script
	Version: 0.1
	Author: Cuel
	Created: 2014-01-15
	Takes an object and an integer (number), removes action (globally). Also removes it for jips.
	Remember that addAction returns an integer, alternatively it is the second (_this select 2) argument in whatever script that runs from an addAction. Example:
	[theVIP,0] call FP_removeAction;
	
///////////////////////////
*/
_obj = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_id = [_this,1,-99,[0]] call BIS_fnc_param;
if (isNull _obj || _id == -99)  exitWith {["Wrong parameters for FP_removeAction : %1 - %2",_obj,_id] call BIS_fnc_error; false};
[[_obj,_id],"FP_fnc_local_removeAction",true,true] spawn BIS_fnc_MP;
true