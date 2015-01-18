/*
	Function: FP_fnc_addTrash
	
	Description:
	Adds (whatever) to BI trash collector.
*/

_unit = [_this,0,objNull,[objNull]] call BIS_fnc_param;
if (isNull _unit) exitWith {};

addToRemainsCollector [_unit];
