/*
    Script: Heli extraction
	Author: Cuel 

    Description:
        Spawns a helicopter (or uses an already existing heli) that flies in, picks up units and lands somewhere to drop them off.
        Then returns to spawnPos and gets deleted / lands (if existed)

        It is recommended to manually place an invisible helicopter landing pad near the LZ (both pickup and dropoff)
        Found under Empty -> Objects -> Helipad (invisble)

        Especially important if using multiple helicopters
        Note: Cannot pickup AI unless they are ordered to enter the helicopter.



    Parameters:
        _heli - An existing helicopter OR , type of helicopter to spawn. Crew will be created using createVehicleCrew
        _unitsToBoard - Group or array of units that should be inside the helicopter before it leaves [Array, Group]
        _spawnPos - Position to spawn helicopter (flying). Ignored if existing helicopter
        _pickupPos - Position where helicopter touches down and awaits troops
        _extractPos - Position to drop units off. When helicopter is empty, it returns to spawnPos and is deleted or lands
        _maxDistanceForUnit - The maximum distance a unit in the above array can be from the helicopter to be considered for pickup (default 100)

    Examples:
    (begin example)
        ["B_Heli_Transport_01_camo_F", "hspawn", "hland", call CBA_fnc_players, "hend", 150] execVM "scripts\heli_extraction.sqf"
    (end)

    Returns:
    Helicopter object (OK) | objNull (FAIL)
*/

params [
  ["_heliType", "", ["", objNull]],
  ["_unitsToBoard", []],
  "_spawnPos",
  "_pickupPos",
  "_extractPos",
  ["_maxDistanceForUnit", 100]
];

if (_unitsToBoard isEqualType objNull) then {_unitsToBoard = [_unitsToBoard]};
if (_unitsToBoard isEqualType grpNull) then {_unitsToBoard = units _unitsToBoard};
if (count _unitsToBoard == 0) exitWith {["No units %1", _this] call BIS_fnc_error; objNull};

private "_heli";
if (_heliType isEqualType "") then {
  _heli = createVehicle [_heliType, _spawnPos, [], random 10, "FLY"];
  _heli setDir ([_spawnPos, _pickupPos] call BIS_fnc_dirTo);
  clearItemCargoGlobal _heli;
  clearWeaponCargoGlobal _heli;
  clearMagazineCargoGlobal _heli;
  createVehicleCrew _heli;
} else {
  _heli = _heliType;
  _spawnPos = getPosATL _heli;
};
if (isNull _heli) exitWith {["Bad helicopter", _this] call BIS_fnc_error; objNull};

_heliVarName = format ["fp_heli_%1", round random 10000];
missionNamespace setVariable [_heliVarName, _heli];

_heli land "NONE";
private _grp = group driver _heli;
while {count (waypoints _grp) > 0} do {
    deleteWaypoint [_grp, 0];
};

private _LZtypes = [
  "Land_HelipadSquare_F",
  "Land_HelipadRescue_F",
  "Land_HelipadEmpty_F",
  "Land_HelipadCircle_F",
  "Land_HelipadCivil_F"
];

private _findOrMakeLZ = {
 private _lzPos = _this;
 private _near = nearestObjects [_lzPos, _LZtypes, _maxDistanceForUnit];
  if (count _near == ({_x getVariable ["fp_inUse", false]} count _near)) then {
    private _LZtype = "Land_HelipadEmpty_F";
    for "_i" from 0 to 10 do {
      private _maxDist = if (_i == 0) then {3} else {15 * _i};
      _lzPos = [_this, 0, _maxDist, 10, 0, 0.2, 0, [], [_this]] call BIS_fnc_findSafePos;
      if !(_lzPos isEqualTo _this) exitWith {};
    };
    private _lz = createVehicle [_LZtype, _lzPos, [], 0, "CAN COLLIDE"];
    _lz setVariable ["fp_inUse", true];
    private _lzs = _heli getVariable ["fp_lz", []];
    _lzs pushBack _lz,
    _heli setVariable ["fp_lz", _lzs];
 };
 (_lzPos)
};

_pickupPos = _pickupPos call _findOrMakeLZ;
_extractPos = _extractPos call _findOrMakeLZ;

_heli setBehaviour "CARELESS";
_heli setSpeedMode "FULL";
_heli flyInHeight 60;

[_heli, _pickupPos, 30, "MOVE", "CARELESS", "RED", "LIMITED", "STAG COLUMN", "(vehicle this) flyInHeight 25; (vehicle this) land 'GET IN' "] call CBA_fnc_addWaypoint;
private _pickUpWP = [_heli, _pickupPos, 10, "HOLD", "CARELESS", "RED", "FULL", "STAG COLUMN", ""] call CBA_fnc_addWaypoint;

// Condition:
// 1) ANY of the defined units are nearby the LZ, AND
// 2) The amount of nearby units defined equals the amount of defined units in the heli
private _unitsLoadedCondition = format [
"{(vehicle _x) distance %1 < %4} count %3 > 0
  &&
  {((
    {alive _x && ((vehicle _x) distance %1) < %4 && _x in %2} count %3
 )
  ==
 (
   {alive _x && ((vehicle _x) distance %1) < %4} count %3
  ))}
", _pickupPos, _heliVarName, _unitsToBoard, _maxDistanceForUnit];

private _landSwitchTrigger = ([
  _pickupPos,
  "AREA:", [5, 5, 0, false],
  "ACT:", ["NONE", "PRESENT", false],
  "STATE:", [_unitsLoadedCondition, format ["%1 setVariable ['FP_hasPickedUp', true]", _heliVarName], ""]
] call CBA_fnc_createTrigger) select 0;
_landSwitchTrigger setTriggerType "SWITCH";
_landSwitchTrigger synchronizeTrigger [_pickUpWP];

// Drop off units
[_heli, _extractPos, 50, "MOVE", "CARELESS", "RED", "FULL", "STAG COLUMN", " (vehicle this) flyInHeight 25; (vehicle this) land 'GET OUT' "] call CBA_fnc_addWaypoint;
private _dropOffWP = [_heli, _extractPos, 10, "HOLD", "CARELESS", "RED", "FULL"] call CBA_fnc_addWaypoint;
private _dropCondition = format ["%1 getVariable ['FP_hasPickedUp', false] && {{alive _x && !(_x in %1)} count %2 == {alive _x} count %2}", _heliVarName, _unitsToBoard];

// Once all units out, return to spawnpos and get deleted / land
private _goHome = format [
  "%1 flyInHeight 60;
  [%1, %2, 50, 'MOVE', 'CARELESS', 'RED', 'FULL', 'STAG COLUMN', %3] call CBA_fnc_addWaypoint",
  _heliVarName,
  _spawnPos,
  if (_heliType isEqualType "") then {
    '''{deleteVehicle _x} forEach ((vehicle this) getVariable ["fp_lz", []]); deleteVehicle (vehicle this); {deleteVehicle _x} forEach (units group this)''';
  } else {
    _spawnPos call _findOrMakeLZ;
    '''(vehicle this) land "LAND"; (vehicle this) setVariable ["FP_hasPickedUp", nil]; (vehicle this) spawn {sleep 10; {deleteVehicle _x} forEach (_this getVariable ["fp_lz", []])}''';
  }
];

_dropOffSwitchTrigger = ([_extractPos, "AREA:", [5, 5, 0, false], "ACT:", ["NONE", "PRESENT", false], "STATE:", [_dropCondition, _goHome, ""]] call CBA_fnc_createTrigger) select 0;
_dropOffSwitchTrigger setTriggerType "SWITCH";
_dropOffSwitchTrigger synchronizeTrigger [_dropOffWP];

(_heli)
