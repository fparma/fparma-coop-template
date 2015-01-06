 /*
///////////////////////////
	ARMA 3 group and vehicle unit tests
	Version: 0.1
	Author: Cuel
	Created: 2013-10-13
	Purpose: Tests the spawning functions to see if they work correctly 
///////////////////////////
*/


#define __LOG(tmsg) _str =format ["UNIT TEST: T%1,%2, MSG: %3", time, __LINE__, tmsg]; diag_log _str; player sidechat _str;
_rndpos = {_ret = [position player, (random 150) * 1, random 360] call BIS_fnc_relPos; _ret};
player setCaptive true;

_mrk = createMarker [format ["%1",random 1000], call _rndpos];
_mrk setMarkerShape "ELLIPSE";
_mrk setMarkerSize [100,100];

sleep 1;

__LOG("Testing spawnPatrol! TEAM: CSAT, amount : 4");
_grp = ["CSAT",_mrk,_mrk,4] call FP_fnc_spawnPatrol;
_str = format ["Testing complete: Units in group: %1",{alive _x} count units _grp];
__LOG(_str);

sleep 1;

__LOG("Testing spawnDefense! TEAM: CSAT, amount : 4");
_grp = ["CSAT",call _rndpos,4,200,true] call FP_fnc_spawnDefense;
_str = format ["Testing complete: Units in group: %1",{alive _x} count units _grp];
__LOG(_str);

sleep 1;

__LOG("Testing spawn group WP! TEAM: CSAT, amount : 4");
_grp =  ["CSAT",call _rndpos,4,[call _rndpos,call _rndpos],"SAD"] call FP_fnc_spawnGroupWP;
_str = format ["Testing complete: Units in group: %1. Waypoints:  %2",{alive _x} count units _grp,count waypoints _grp];
__LOG(_str);


sleep 1;

__LOG("Testing spawn group WP! TEAM: CSAT, amount : 4");
_grp =  ["CSAT",call _rndpos,4,100] call FP_fnc_spawnHousePatrol;
_str = format ["Testing complete: Units in group: %1. Waypoints: %2 ",{alive _x} count units _grp,count waypoints _grp];
__LOG(_str);

sleep 1;

__LOG("Testing spawn vehicle using UPS");
_veh = ["O_MRAP_02_F",call _rndpos,_mrk] call FP_fnc_spawnVehicle;
_str = format ["Testing complete: Vehicle alive: %1. Crew: %2",alive _veh,count crew _veh];
__LOG(_str);

sleep 1;

__LOG("Testing spawn vehicle with move waypoints");
_veh = ["O_MRAP_02_F",call _rndpos,[call _rndpos, call _rndpos call _rndpos,call _rndpos,call _rndpos],"SAD"] call FP_fnc_spawnVehicle;
_str = format ["Testing complete: Vehicle alive: %1. Crew: %2. Waypoints : %3",alive _veh,count crew _veh,count waypoints (group (driver _veh))];
__LOG(_str);
