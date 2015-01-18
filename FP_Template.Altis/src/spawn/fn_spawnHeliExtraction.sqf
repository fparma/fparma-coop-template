/*
	Function: spawnHeliExtraction
		Not AI compatible.
		Spawns a helicopter that flies in, picks up units and lands somewhere to drop them off.
		Then returns to spawnPos and gets deleted
		It is recommended to manully place an invisible helicopter landing pad near the LZ (both pickup and dropoff)
		Found under Empty -> Objects -> Helipad (invisble)
		Espescially important if using multiple helicopters since they will try to land on the same spot otherwise.

	Arguments:
		_heliType - Type of helicopter to spawn. Crew will be created using createVehicleCrew
		_spawnPos - Position to spawn helicopter (flying)
		_movePos1 - Positon where helicopter should fly before landing
		_landPos - Position where helicopter touches down and awaits troops loading
		_unitsToBoard - Group or array of units that should be inside the helicopter before it leaves [Array, Group]
		_maxDistanceForUnit - The maximum distance a unit in the above array can be from the helicopter to be considered for pickup
		_movePos2 - Position to move before extraction
		_dropPos - Position to drop units off. When helicopter is empty, it returns to spawnPos and is deleted
		_captiveHelictoper - If helicopter should be "civilian" and thus ignored by all hostiles [Boolean - default false]

	Examples:
	(begin example)
		["B_Heli_Transport_01_camo_F", "hspawn", "hmove1", "hland", call CBA_fnc_players, 150, "hmove2", "hend"] call FP_fnc_spawnHeliExtraction;
	(end)

	Returns:
	Helicopter object (OK) | objNull (FAIL)
*/

if (!isServer) exitWith {};

#define isBadPos(X) (X isEqualTo [0,0,0] or surfaceIsWater X)

_heliType = [_this, 0, "", [""]] call BIS_fnc_param;
_spawnPos = (_this select 1) call CBA_fnc_getPos;
_movePos1 = (_this select 2) call CBA_fnc_getPos;
_landPos = (_this select 3) call CBA_fnc_getPos;
_unitsToBoard = [_this, 4, [], [[], grpNull]] call BIS_fnc_param;
if (typeName _unitsToBoard == typeName grpNull) then {_unitsToBoard = units _unitsToBoard};
_maxDistanceForUnit = ([_this, 5, 100, [0]] call BIS_fnc_param) max 80;
_movePos2 = (_this select 6) call CBA_fnc_getPos;
_dropPos = (_this select 7) call CBA_fnc_getPos;
_captiveHelictoper = [_this, 8, true, [true]] call BIS_fnc_param;

if (_heliType == "" || count _unitsToBoard == 0 || {isBadPos(_x)} count [_spawnPos, _movePos1, _landPos, _movePos2, _dropPos] > 0) exitWith {
	["Bad parameters (check no pos is water)!: (%1, %2, %3, %4, %5, %6, %7)", _heliType, _unitsToBoard, _spawnPos, _movePos1, _landPos, _movePos2, _dropPos] call BIS_fnc_error;
	objNull
};

 _LZtypes = ["Land_HelipadSquare_F","Land_HelipadRescue_F","Land_HelipadEmpty_F","Land_HelipadCircle_F","Land_HelipadCivil_F"];

 _findOrMakeLZ = {
 	private ["_LZtype", "_lzPos","_maxDist", "_near"];
 	_lzPos = _this;
 	_near = nearestObjects [_lzPos, _LZtypes, _maxDistanceForUnit];
	 if (count _near == ({_x getVariable ["fp_inUse", false]} count _near)) then {
		_LZtype = "Land_HelipadEmpty_F";
		for "_i" from 0 to 10 do {
			_maxDist = if (_i == 0) then {_maxDistanceForUnit * 0.3} else {_maxDistanceForUnit + (10 * _i)};
			_lzPos = [_this, 0, _maxDist, 10, 0, 0.2, 0, [], [_this]] call BIS_fnc_findSafePos;
			if !(_lzPos isEqualTo _this) exitWith {};
		};
		(createVehicle [_LZtype, _lzPos, [], 0, "CAN COLLIDE"]) setVariable ["fp_inUse", true];
		// [str random 1000, _lzPos, "Rectangle", [10, 10], "COLOR:", "ColorRed"] call CBA_fnc_createMarker;
	};
	(_lzPos)
};

_landPos = _landPos call _findOrMakeLZ;
_dropPos = _dropPos call _findOrMakeLZ;

_heli = createVehicle [_heliType, _spawnPos, [], random 10, "FLY"];
_heliVarName = format ["FP_heli_extract_%1", round (time * random 50)];
missionNamespace setVariable [_heliVarName, _heli];
clearItemCargoGlobal _heli;
clearWeaponCargoGlobal _heli;
clearMagazineCargoGlobal _heli;
// keep bps?

createVehicleCrew _heli;
if (_captiveHelictoper) then {
	_heli setCaptive true;
};

_heli setDir ([_spawnPos, _movePos1] call BIS_fnc_dirTo);
_heli setBehaviour "CARELESS";
_heli setSpeedMode "FULL";
_heli flyInHeight 60;

[_heli, _movePos1, 30, "MOVE"] call CBA_fnc_addWaypoint;

[_heli, _landPos, 30, "MOVE", "CARELESS", "RED", "LIMITED", "STAG COLUMN", "(vehicle this) flyInHeight 25; (vehicle this) land 'GET IN' "] call CBA_fnc_addWaypoint;
_pickUpWP = [_heli, _landPos, 10, "HOLD", "CARELESS", "RED", "FULL", "STAG COLUMN", ""] call CBA_fnc_addWaypoint;

// Condition:
// 1) ANY of the defined units are nearby the LZ
// AND
// 2) The amount of nearby units defined equals the amount of defined units in the heli

_unitsLoadedCondition = format 
["
	{(vehicle _x) distance %1 < %4} count %3 > 0
	&&
	{(
		(
			{alive _x && ((vehicle _x) distance %1) < %4 && _x in %2} count %3
		)
		== 
		(
			{alive _x && ((vehicle _x) distance %1) < %4} count %3
		)
	)}
", _landPos, _heliVarName, _unitsToBoard, _maxDistanceForUnit];

_landSwitchTrigger = ([_landPos,  "AREA:", [5, 5, 0, false], "ACT:", ["NONE", "PRESENT", false], "STATE:", [_unitsLoadedCondition, format ["%1 setVariable ['FP_hasPickedUp', true]", _heliVarName], ""]] call CBA_fnc_createTrigger) select 0;
_landSwitchTrigger setTriggerType "SWITCH";
_landSwitchTrigger synchronizeTrigger [_pickUpWP];

[_heli, _movePos2, 30, "MOVE", "CARELESS", "RED", "FULL"] call CBA_fnc_addWaypoint;
[_heli, _dropPos, 50, "MOVE", "CARELESS", "RED", "FULL", "STAG COLUMN", " (vehicle this) flyInHeight 25; (vehicle this) land 'GET OUT' "] call CBA_fnc_addWaypoint;

_dropOffWP = [_heli, _dropPos, 10, "HOLD", "CARELESS", "RED", "FULL"] call CBA_fnc_addWaypoint;

_dropCondition = format ["%1 getVariable ['FP_hasPickedUp', false] && {alive _x && !(_x in %1)} count %2 == {alive _x} count %2", _heliVarName, _unitsToBoard];
_goHome = format ["%1 flyInHeight 60; [%1, %2, 50, 'MOVE', 'CARELESS', 'RED', 'FULL', 'STAG COLUMN', 'deleteVehicle (vehicle this); {deleteVehicle _x} forEach (units group this)'] call CBA_fnc_addWaypoint", _heliVarName, _spawnPos];

_dropOffSwitchTrigger = ([_dropPos, "AREA:", [5, 5, 0, false], "ACT:", ["NONE", "PRESENT", false], "STATE:", [_dropCondition, _goHome, ""]] call CBA_fnc_createTrigger) select 0;
_dropOffSwitchTrigger setTriggerType "SWITCH";
_dropOffSwitchTrigger synchronizeTrigger [_dropOffWP];

(_heli)