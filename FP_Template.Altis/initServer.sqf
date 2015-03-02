/*
	Executed only on server when mission is started.
	See: https://community.bistudio.com/wiki/Functions_Library_(Arma_3)#Initialization_Order
		for details about when the script is exactly executed.
*/

createCenter west;
createCenter east;
createCenter resistance;
createCenter civilian;

{
	_x addCuratorEditableObjects [vehicles,true];
	_x addCuratorEditableObjects [(allMissionObjects "Man"),false];
	_x addCuratorEditableObjects [(allMissionObjects "Air"),true];
	_x addCuratorEditableObjects [(allMissionObjects "Ammo"),false];
}forEach allCurators;

// clean up script
// will not delete units dead on mission start
// will not delete units where "this setVariable ["fp_noDelete", true]"
[] execVM "src\cleanup\clean.sqf";
