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

  (_this select 0) removeAction (_this select 1);