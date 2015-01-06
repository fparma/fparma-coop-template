/*
///////////////////////////
	ARMA 3 function script
	Version: 0.1
	Author: Cuel
	Created: 2014-01-15
	 Takes an object and ARRAY. Adds action globally. Example:
	 [theVIP,["<t color='#ffff00'>[ Free VIP ]</t>","free.sqf",0, 100, true, true,"","_this distance _target < 4 && vehicle player == player"]] call FP_fnc_addAction;
	 OR : 
	 [player,["Free VIP","free.sqf"]] call FP_fnc_addAction;
	 actions are added for join in progress players.
///////////////////////////
*/

_obj = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_actionArray = [_this,1,[],[[]]] call BIS_fnc_param;
if (isNull _obj || (count (_actionArray-[0]) < 1))  exitWith {["Wrong parameters for FP_addAction : %1",_this] call BIS_fnc_error; false};
[[_obj,_actionArray],"FP_fnc_local_addAction",true,true] spawn BIS_fnc_MP;
true