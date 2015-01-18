/*
	Function: FP_fnc_addAction
	
	Description: 
		Adds action to object and broadcasts it, including JiPs
		This function should only be called from ONE client or server.

	Parameters:
		_obj - Target to addAction to
		_actionArray - Normal addAction array with parameters.

	Examples: 
	(begin example) 
		[theVIP,["<t color='#ffff00'>[ Free VIP ]</t>","free.sqf",0, 100, true, true,"","_this distance _target < 4 && vehicle player == player"]] call FP_fnc_addAction;

		[player,["Free VIP","free.sqf"]] call FP_fnc_addAction;	
	(end) 

	Returns:
	BOOL

	Author: 
	Cuel 2015-01-07
*/

_obj = [_this,0,objNull,[objNull]] call BIS_fnc_param;
_actionArray = [_this,1,[],[[]]] call BIS_fnc_param;

if (isNull _obj || (count _actionArray < 2)) exitWith {
	["Wrong parameters: %1",_this] call BIS_fnc_error; 
	false
};

[[[_obj, _actionArray],{(_this select 0) addAction (_this select 1)}], "BIS_fnc_spawn", true, true] call BIS_fnc_MP;

true
