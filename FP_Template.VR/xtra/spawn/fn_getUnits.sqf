/*
	Function: FP_fnc_getUnits

	Description:
		Main definition for teams and units used in spawn scripts.

		You can create your own team by adding a case.

	Notes:

		The first two units in _units should be "leaders" of a group

		_specialUnits are stuff like AT, AR. They have a base 5% chance to spawn, increases with the amount in _units. Only once per call tho.

		_airDropUnits is used for helicopter type for spawnPara.

	Author:
	Cuel 2015-01-18
*/

private  ["_specialUnits","_units","_type","_airdropUnit"] ;
_units = [];
_specialUnits = [];
_type = [_this,0,""] call BIS_fnc_param;
_air = [_this,1,false,[false]] call BIS_fnc_param;

switch (toUpper _type) do {
	case "CSAT": {
		_units = ["O_Soldier_SL_F","O_Soldier_TL_F","O_medic_F","O_Soldier_AR_F","O_Soldier_A_F","O_Soldier_GL_F","O_Soldier_F","O_Soldier_lite_F"];
		_specialUnits = ["O_Soldier_LAT_F"];
		_airdropUnit = "O_Heli_Light_02_F";
	};
	case "NATO":{
		_units = ["B_Soldier_TL_F","B_Soldier_SL_F","B_Soldier_A_F","B_soldier_AR_F","B_medic_F","B_Soldier_GL_F","B_Soldier_F","B_Soldier_lite_F"];
		_specialUnits = ["B_soldier_LAT_F"];
		_airdropUnit = "B_Heli_Transport_01_camo_F";
	};
	case "FIA":{
		_units = ["B_G_Soldier_SL_F","B_G_Soldier_TL_F","B_G_Soldier_A_F","B_G_Soldier_AR_F","B_G_medic_F","B_G_Soldier_GL_F","B_G_Soldier_F","B_G_Soldier_lite_F"];
		_specialUnits = ["B_G_Soldier_LAT_F"];
		_airdropUnit = "";
	};
	case "AAF":{
		_units = ["I_Soldier_TL_F","I_Soldier_SL_F","I_Soldier_lite_F","I_soldier_F","I_Soldier_GL_F","I_medic_F","I_Soldier_AR_F","I_Soldier_A_F"];
		_specialUnits = ["I_Soldier_LAT_F"];
		_airdropUnit = "I_Heli_Transport_02_F";
	};
	case "RHSMSV":{
		_units = ["rhs_msv_sergeant","rhs_msv_junior_sergeant","rhs_msv_machinegunner","rhs_msv_machinegunner_assistant","rhs_msv_rifleman","rhs_msv_efreitor","rhs_msv_grenadier"];
		_specialUnits = ["rhs_msv_at","rhs_msv_strelok_rpg_assist"];
		_airdropUnit = "RHS_Mi8AMT_vvsc";
	};
	default {["fn_unitsArray: Tried to select non existing units: (%1)",_type] call BIS_fnc_error};
};

// Return
if (_air) exitWith {
	if (_airdropUnit == "") then {["fn_getUnits: Team (%1) are missing an air drop heli.",_type] call BIS_fnc_error};
	_airdropUnit
};

[_units,_specialUnits]
