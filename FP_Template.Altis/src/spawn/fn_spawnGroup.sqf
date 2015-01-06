/*
///////////////////////////
	ARMA 3 Group spawning script
	Version: 0.1
	Author: Cuel
	Created: 2013-10-13
	Purpose: Spawns a group at designated location with the specific amount. Takes an array format ["TEAM",position,amount (optional)]
	Example: ["CSAT","myMarker",4] call FP_fnc_spawnGroup;
	Returns: Created group
///////////////////////////
*/

if (!isServer) exitWith {};

#ifdef FP_spawn_dbg
	#include "x_dbg.sqf"
#endif

private ["_team","_pos","_amount","_unitArray","_units","_special","_grp","_tmpunits","_specialUsed","_ldr","_type","_tmppos"];
_team = [_this,0,"",[""]] call BIS_fnc_param;
_pos = ([_this,1,""] call BIS_fnc_param) call CBA_fnc_getPos;
_amount = [_this,2,4,[0]] call BIS_fnc_param;
_unitArray =  _team call FP_fnc_getUnits;
_units = _unitArray select 0;
_special = if (count _unitArray > 1) then {((_unitArray select 1)  call BIS_fnc_selectRandom)}else {""};
if (typeName _special == typeName []) then {_special = _special call BIS_fnc_selectRandom};
if ((count _units < 1) || count (_pos - [0]) == 0) exitWith {["fn_spawnGroup: Received incorrect team (%1) or spawn position (%2)",_team,_pos] call BIS_fnc_error};

// manually try to find a safe spot to spawn
for "_i" from 0 to 10 do {
	// if we can fit an MRAP, units can spawn :)
	_tmppos  = _pos findEmptyPosition[0 ,100,"B_MRAP_01_F"];
	if (count (_tmppos - [0]) != 0) then {
		_pos = _tmppos;
	};
};
 _grp = createGroup ([OPFOR,BLUFOR,independent,CIVILIAN] select (getNumber (configfile >> "CfgVehicles" >>(_units select 0) >> "side")));
_tmpunits =+ (_units - [_units select 0,_units select 1]);
_specialUsed = false;

_ldr = _grp createUnit [[_units select 0,_units select 1] select floor random 2,_pos, [], random 3, "CAN_COLLIDE"]; 
_types = [];
for "_y" from 1 to _amount - 1 do 
{
	if (count _tmpunits < 1) then {_tmpunits =+ (_units - [_units select 0,_units select 1]);};
	_type = _tmpunits call BIS_fnc_selectRandom;
	if (!_specialUsed && random 100 > 90 && _special != "") then {_specialUsed = true; _type = _special};
	_tmpunits = _tmpunits - [_type];
	_types set [count _types, _type];
	_grp createUnit [_type,_pos, [], random 3, "CAN_COLLIDE"]; 
};

// Optimisation thanks to BL1P & Fred41
/*
[_grp, _pos, _types] spawn {
	_grp = _this select 0;
	_pos = _this select 1;
	_types = _this select 2;
	{
		_delay = ((abs(50 - diag_fps) / (50 - 20))^2) * 4;
		player sideChat  str _delay;
		sleep _delay;
		_grp createUnit [_x,_pos, [], random 3, "CAN_COLLIDE"]; 	
	}foreach _types;
};
*/

//  Specific stuff.
{
	_x addEventHandler ["Killed",{
		[_this select 0] call FP_fnc_addTrash;
	}];
	if ("optic_Arco" in (primaryWeaponItems _x)) then  
	{
		_x removePrimaryWeaponItem "optic_Arco";
		_x addPrimaryWeaponItem "optic_Aco";
	};
	if (daytime > 7 && daytime < 20) then {
		if (side _x == CIVILIAN) then {
			_x unlinkItem "NVGoggles";
		}else{
			_x unlinkItem (["NVGoggles","NVGoggles_OPFOR","NVGoggles_INDEP"] select ([west,east,independent] find side _x));
		};
	};
	if (_specialUsed) then 
	{
		if (typeOf _x  == _special) then 
		{
			removeBackpack _x; // remove AT bp to make it less OP
		};
	};

}forEach units _grp;

{
	_x addCuratorEditableObjects [units _grp, true];
}forEach allCurators;

if (_team == "RUSHUSOCP") then {
	{
		[_x] call FP_changeGearToWinter;
	}foreach units _grp;
};

_grp setBehaviour "SAFE";

/*
{
	_x setUnitAbility 0.2;
	_x setskill ["aimingAccuracy",0.2];
	_x setskill ["aimingShake",1];
	_x setskill ["aimingSpeed",0.6];
	_x setskill ["Endurance",0.8];
	_x setskill ["spotDistance",0.5];
	_x setskill ["spotTime",0.5];
	_x setskill ["courage",0.6];
	_x setskill ["reloadSpeed",1];
} forEach units _grp;
*/

_grp