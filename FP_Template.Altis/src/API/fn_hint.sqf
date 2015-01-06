/*
///////////////////////////
	ARMA 3 function script
	Version: 0.1
	Author: Cuel
	Created: 2014-01-15
	Takes a String (or array) and sends it globally. Example:
	"Hello World" call FP_hint;
///////////////////////////
*/

if (typeName _this == typeName []) then {_this = _this select 0;};
if (typeName _this != typeName "")  exitWith {["Wrong parameters for FP_hint : %1",_this] call BIS_fnc_error; false};
[_this,"FP_fnc_local_hint",true,false] spawn BIS_fnc_MP;
true