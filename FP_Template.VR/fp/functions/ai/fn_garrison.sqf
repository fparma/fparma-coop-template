/*
    Function: FP_fnc_garrison

    Description:
        Takes units and puts them inside nearby buildings (garrison).
        If not enough positions, units not in houses will be put into their own group and patrol around

    Parameters:
        _grp - Group to garrison
        _radius - (Optional) The radius to search for buildings [Integer, default 200]
        _putOnRoof - (Optional) Put units on rooftop if available [Boolean, default true]
        _fillEvenly - (Optional) default false
                        TRUE- Fill all buildings in the area evenly.
                        FALSE - Fill closest building until no more positions, continue on to next building
        _lockUnits - (Optional) Lock units in place (cant rotate) until fired upon or enemies within 60m [Boolean, default false]

    Returns:
        ARRAY: Units (might be in dfferent groups)

    Author:
    Cuel 2016-01-08
*/

params [
  ["_grp", grpNull],
  ["_buildingRadius", 200],
  ["_putOnRoof", true],
  ["_fillEvenly", false],
  ["_lockUnits", false]
];
_grp = [_grp] call CBA_fnc_getGroup;
if (!local _grp) exitWith {};

// Rest of script is made by Zenophon.
// Infantry Occupy House
// by Zenophon
// Released under Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)
// http://creativecommons.org/licenses/by-nc/4.0/
#define I(X) X = X + 1;
#define EYE_HEIGHT 1.53
#define CHECK_DISTANCE 5
#define FOV_ANGLE 15
#define ROOF_CHECK 4
#define ROOF_EDGE 2

private ["_center", "_units", "_Zen_ExtendPosition", "_buildingsArray", "_buildingPosArray", "_buildingPositions", "_posArray", "_unitIndex", "_j", "_building", "_posArray", "_randomIndex", "_housePos", "_startAngle", "_i", "_checkPos", "_hitCount", "_isRoof", "_edge", "_k", "_unUsedUnits"];

_center = getPosATL leader _grp;
_units = units _grp;

_Zen_ExtendPosition = {
  private ["_center", "_dist", "_phi"];

  _center = _this select 0;
  _dist = _this select 1;
  _phi = _this select 2;

  ([(_center select 0) + (_dist * (cos _phi)),(_center select 1) + (_dist * (sin _phi)), (_this select 3)])
};

if (_buildingRadius < 0) then {
  _buildingsArray = [nearestBuilding _center];
} else {
  _buildingsArray = nearestObjects [_center, ["house"], _buildingRadius];
};

_buildingPosArray = [];
{
  _buildingPositions = 0;
  for "_i" from 0 to 100 do {
    if ((_x buildingPos _buildingPositions) isEqualTo [0,0,0]) exitWith {};
    I(_buildingPositions)
  };

  _posArray = [];
  for "_i" from 0 to (_buildingPositions - 1) do {
    _posArray set [_i, _i];
  };

  _buildingPosArray set [_forEachIndex, _posArray];
} forEach _buildingsArray;

_unitIndex = 0;
for [{_j = 0}, {(_unitIndex < count _units) && {(count _buildingPosArray > 0)}}, {I(_j)}] do {
  scopeName "for";

  _building = _buildingsArray select (_j % (count _buildingsArray));
  _posArray = _buildingPosArray select (_j % (count _buildingsArray));

  if (count _posArray == 0) then {
    _buildingsArray set [(_j % (count _buildingsArray)), 0];
    _buildingPosArray set [(_j % (count _buildingPosArray)), 0];
    _buildingsArray = _buildingsArray - [0];
    _buildingPosArray = _buildingPosArray - [0];
  };

  while {(count _posArray) > 0} do {
      scopeName "while";
      if (_unitIndex >= count _units) exitWith {};

      _randomIndex = floor random count _posArray;
      _housePos = _building buildingPos (_posArray select _randomIndex);
      _housePos = [(_housePos select 0), (_housePos select 1), (_housePos select 2) + (getTerrainHeightASL _housePos) + EYE_HEIGHT];

      _posArray set [_randomIndex, _posArray select (count _posArray - 1)];
      _posArray resize (count _posArray - 1);

      _startAngle = (round random 10) * (round random 36);
    for "_i" from _startAngle to (_startAngle + 350) step 10 do {
        _checkPos = [_housePos, CHECK_DISTANCE, (90 - _i), (_housePos select 2)] call _Zen_ExtendPosition;
      if !(lineIntersects [_checkPos, [_checkPos select 0, _checkPos select 1, (_checkPos select 2) + 25], objNull, objNull]) then {
        if !(lineIntersects [_housePos, _checkPos, objNull, objNull]) then {
          _checkPos = [_housePos, CHECK_DISTANCE, (90 - _i), (_housePos select 2) + (CHECK_DISTANCE * sin FOV_ANGLE / cos FOV_ANGLE)] call _Zen_ExtendPosition;
          if !(lineIntersects [_housePos, _checkPos, objNull, objNull]) then {
            _hitCount = 0;
            for "_k" from 30 to 360 step 30 do {
              _checkPos = [_housePos, 20, (90 - _k), (_housePos select 2)] call _Zen_ExtendPosition;
              if (lineIntersects [_housePos, _checkPos, objNull, objNull]) then {
                  I(_hitCount)
              };

              if (_hitCount >= ROOF_CHECK) exitWith {};
            };

            _isRoof = (_hitCount < ROOF_CHECK) && {!(lineIntersects [_housePos, [_housePos select 0, _housePos select 1, (_housePos select 2) + 25], objNull, objNull])};
            if (!(_isRoof) || {((_isRoof) && {(_putOnRoof)})}) then {
              if (_isRoof) then {
                  _edge = false;
                for "_k" from 30 to 360 step 30 do {
                  _checkPos = [_housePos, ROOF_EDGE, (90 - _k), (_housePos select 2)] call _Zen_ExtendPosition;
                  _edge = !(lineIntersects [_checkPos, [(_checkPos select 0), (_checkPos select 1), (_checkPos select 2) - EYE_HEIGHT - 1], objNull, objNull]);

                  if (_edge) exitWith {
                    _i = _k;
                  };
                };
              };

              if (!(_isRoof) || {_edge}) then {
                (_units select _unitIndex) setPosASL [(_housePos select 0), (_housePos select 1), (_housePos select 2) - EYE_HEIGHT];
                (_units select _unitIndex) setDir (_i );

                if (_isRoof) then {
                  (_units select _unitIndex) setUnitPos "MIDDLE";
                } else {
                  (_units select _unitIndex) setUnitPos "UP";
                };

                (_units select _unitIndex) lookAt ([_housePos, CHECK_DISTANCE, (90 - _i), (_housePos select 2) - (getTerrainHeightASL _housePos)] call _Zen_ExtendPosition);
                doStop (_units select _unitIndex);

                I(_unitIndex)
                if (_fillEvenly) then {
                  breakTo "for";
                } else {
                  breakTo "while";
                };
              };
            };
          };
        };
      };
    };
  };
};

_unUsedUnits = [];

for [{_i = _unitIndex}, {_i < count _units}, {I(_i)}] do {
  _unUsedUnits set [(count _unUsedUnits), (_units select _i)];
};

private "_grp2";
if (count _unUsedUnits > 0) then {
  _grp2 = createGroup (side (_unUsedUnits select 0));
  {
    [_x] joinSilent _grp2;
  }foreach _unUsedUnits;

  [_grp2, _center, _buildingRadius, 6+(round (random 4)), "MOVE", "SAFE", "YELLOW", "LIMITED", "COLUMN", "[this] spawn CBA_fnc_searchNearby", [3+(random 4),10,10+(random 5)]] call CBA_fnc_taskPatrol;
};

if (_lockUnits) then {

  {
    _x disableAI "MOVE";
    _x addEventHandler ["Hit", {
      _unit = _this select 0;
      if (!alive _unit) exitWith {};
      _unit setVariable ["fp_enabled", true];
      _unit enableAI "MOVE";
      _unit doMove [(getPosATL _unit select 0)+1, (getPosATL _unit select 1) +1, getPosATL _unit select 2];
    }];
  }forEach units _grp;

  [{
    params ["_units", "_id"];
    if ({!alive _x || {_x getVariable ["fp_enabled", false]}} count _units == count _units) exitWith {
      [_id] call CBA_fnc_removePerFrameHandler;
    };

    {
      if (alive _x && {!(_x getVariable ["fp_enabled", false])} && {simulationEnabled _x}) then {
        if (_x distance (_x findNearestEnemy (getPosATL _x)) < 60 || {[_x,30] call CBA_fnc_nearPlayer}) then {
          _x setVariable ["fp_enabled", true];
          _x enableAI "MOVE";
          _x doMove [(getPosATL _x select 0)+1, (getPosATL _x select 1) +1, getPosATL _x select 2];
        };
      };
    } forEach _units;
  }, 3.23, units _grp] call CBA_fnc_addPerFrameHandler;
};

if (count _unUsedUnits == 0) exitWith {
  (units _grp);
};

(units _grp + units _grp2)
