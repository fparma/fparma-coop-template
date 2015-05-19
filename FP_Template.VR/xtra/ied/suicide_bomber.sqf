// by SSG Cuel 2012
//Place a unit (civilian/opfor) that you want to be a suicide bomber, give him a name.
//trigger activation: getposATL (thislist select 0) select 2 < 10
// on act: 0 =[unitName] execVM "xtra\ied\suicide_bomber.sqf";
//will search for a nearby player in a 250m radius. if no player within 400m, it deletes the unit.

_unit  = _this select 0;
if (isNil "_unit") exitWith {"Invalid unit for suicide bomber." call BIS_fnc_error};
if (!local _unit) exitWith {"Not executed where unit is local" call BIS_fnc_error};
	
_bombtype = "M_Mo_82mm_AT_LG";
_bombfaction = faction _unit;

_unit setCaptive true;
_unit setBehaviour "CARELESS";
_unit setCombatMode "BLUE";
_unit setSpeedMode "LIMITED";
_unit disableAI "TARGET";
_unit disableAI "AUTOTARGET";
_unit enableAI "MOVE";
_unit setUnitPos "UP";
_unit setVariable ["KRON_exclude",true];
_unit removeAllEventHandlers "Killed";

_expl1 = "DemoCharge_Remote_Ammo" createVehicle [0,0,0];
_expl2 = "DemoCharge_Remote_Ammo" createVehicle  [0,0,0];
_expl3 = "DemoCharge_Remote_Ammo" createVehicle  [0,0,0];
sleep 0.01;
_expl1 attachTo [_unit, [-0.1,0.1,0.15],"Pelvis"];
_expl2 attachTo [_unit, [0,0.15,0.15],"Pelvis"];
_expl3 attachTo [_unit, [0.1,0.1,0.15],"Pelvis"];

[[[_expl1,_expl2,_expl3], {
	_expl1 = _this select 0;
	_expl2 = _this select 1;
	_expl3 = _this select 2;
	_expl1 setVectorDirAndUp [[0.5,0.5,0],[-0.5,0.5,0]];
	_expl1 setPosATL (getPosATL _expl1);
	_expl2 setVectorDirAndUp [[1,0,0],[0,1,0]];
	_expl2 setPosATL (getPosATL _expl2);
	_expl3 setVectorDirAndUp [[0.5,-0.5,0],[0.5,0.5,0]];
	_expl3 setPosATL (getPosATL _expl3);
}],"BIS_fnc_spawn", true] call BIS_fnc_MP;

_unit setVariable ["FP_iedBombs", [_expl1, _expl2, _expl3]];

//function to see if the unit is still capable of doing anything
_canAct = {
	if (damage _this < 0.4 && {!(_this getVariable ["ACE_isUnconscious", false])}) exitWith {true};
	false
};

//function to find the nearest target
_findNearest = {
	_targets = call CBA_fnc_players;
	_dist= 250;
	_nearest = objNull;
		{
			if (isTouchingGround _x) then {
				if ((faction _x) != _bombfaction) then {
					_distance=_unit distance (vehicle _x);
					if (_distance<_dist) then {
						_nearest=_x;
						_dist=_distance;
					};
				 };
			};
			sleep 0.01;
		} forEach _targets;
	_nearest
};

//loop
_exit = false;
while {_unit call _canAct && !_exit} do {
	_ret = call _findNearest;
	if (!isNull _ret) then {
		_unit reveal [_ret,4];
		_unit lookAt _ret;
		_sp = "LIMITED";
		if (_unit distance _ret < 20) then {_sp = "FULL"};
		_unit doMove (getposatl _ret);
		_unit setSpeedMode _sp;
	} else {
		sleep 8;
	};
	sleep 0.5;
	if ([getPosATL _unit,7] call CBA_fnc_nearPlayer) then
	{
		if (_unit call _canAct) then {
			[[_unit], "fp_akbar"] call CBA_fnc_globalSay;
			sleep 0.2;
			doStop _unit;
			sleep 0.3;
			_unit playmove "AmovPercMstpSsurWnonDnon";
			sleep 1;
		};
		if (_unit call _canAct) then
		{
			_pos = [getposatl _unit select 0,getposatl _unit select 1,0];
			_pos set [2, .2];
			_crater = createVehicle ["CraterLong_small", _pos, [], 0, "NONE"];
			_b = createVehicle [_bombtype, _pos, [], 0, "NONE"];
			_b setVelocity [0, 0, -10];
			_crater spawn {
				sleep 300;
				deleteVehicle _this;
			};
			_near = [];
			{if (_x distance _unit < 40) then {_near pushBack _x}}forEach call CBA_fnc_players;
			[[[2.5, 2, 25],{addCamShake _this}],"BIS_fnc_spawn", _near] call BIS_fnc_MP;
		} else {
			_exit = true
		};
	}
	else
	{
		if !([getPosATL _unit,400] call CBA_fnc_nearPlayer) exitWith {_unit setDamage 1; {deleteVehicle _x} forEach (_unit getVariable ["FP_iedBombs", []]); deleteVehicle _unit;};
	};
	sleep 2;
};

if (alive _unit) then {
	doStop _unit;
	_unit lookAt objNull;
	_unit setUnitPos "DOWN";
	{deleteVehicle _x} forEach (_unit getVariable ["FP_iedBombs", []]);
}else{
	{deleteVehicle _x} forEach (_unit getVariable ["FP_iedBombs", []]);
	sleep 60;
	hideBody _unit;
	sleep 5;
	deletevehicle _unit;
};

if (true) exitWith {};
