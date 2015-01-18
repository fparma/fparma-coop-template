/*
    Function: spawnGarrison
    
    Description: 
        Takes units and puts them inside buildings (garrison). If not enough positions, units not in houses will be put into their own group and patrol around

    Parameters:
        _team - Team defined in getUnits [String]
        _position - Main position to spawn and search for buildings [Any]
        _amount - Amount of units to spawn [Integer]
        _radius - (Optional) The radius around spawn position to search for buildings [Integer, default 150]
        _putOnRoof - (Optional) Put units on rooftop if available [Boolean, default false]
        _fillEvenly - (Optional) Fill all buildings in the area evenly (true), Otherwise fill buildings until no more positions, continue on to next (false) [Boolean, default true]
        _lockUnits - (Optional) Lock units in place (cant rotate) until fired upon or enemies within 50m [Boolean, default true]

    Examples: 
    (begin example) 
        ["AAFD", getPos player, 8] call FP_fnc_spawnGarrison;
    (end) 

    Returns:
        Array of every created unit

    Author: 
    Cuel 2015-01-18
*/

if (!isServer) exitWith {};

private ["_grp","_buildingRadius","_putOnRoof","_fillEvenly","_lockUnits"];
_grp = _this call FP_fnc_spawnGroup;
_pos = ([_this,1] call BIS_fnc_param) call CBA_fnc_getPos;
if (_pos distance [0,0,0] < 5) exitWith  {["fnSpawnGarrison:Incorrect parameters (%1)",_this] call BIS_fnc_error};
_buildingRadius = [_this,3,150,[0]] call BIS_fnc_param;
_putOnRoof = [_this,4,false,[false]] call BIS_fnc_param;
_fillEvenly =  [_this,5,true,[true]] call BIS_fnc_param;
_lockUnits =  [_this,6,true,[true]] call BIS_fnc_param;

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

_center = _pos;
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

	//[_grp2, _center, _buildingRadius, 2, true] call CBA_fnc_taskDefend;
	[_grp2, _center, _buildingRadius, 6+(round (random 4)), "MOVE", "SAFE", "YELLOW", "LIMITED", "COLUMN", "[this] spawn CBA_fnc_searchNearby", [3+(random 4),10,10+(random 5)]] call CBA_fnc_taskPatrol;
};

if (_lockUnits) then {
	{
		_x disableAI "MOVE";
		_x addEventHandler ["Hit", {
			_unit = _this select 0;
			if (!alive _unit) exitWith {};
			_unit enableAI "MOVE";
			_unit doMove [(getPosATL _unit select 0)+1, (getPosATL _unit select 1) +1, getPosATL _unit select 2];
		}];
	}forEach units _grp;

	_grp spawn {
		_tmp = units _this;
		while {count _tmp > 0} do {
			{
				if (!alive _x) then {
					_tmp = _tmp - [_x];
				}else{
					if (_x distance (_x findNearestEnemy (getPosATL _x)) < 50 || {[_x,20] call CBA_fnc_nearPlayer}) then {
						_x enableAI "MOVE";
						_x doMove [(getPosATL _x select 0)+1, (getPosATL _x select 1) +1, getPosATL _x select 2];
						_tmp = _tmp - [_x];
					};
				};
			}forEach _tmp;
			sleep 1.56;
		};
	};
};

if (count _unUsedUnits == 0) exitWith{
	(units _grp);
};

(units _grp + units _grp2)