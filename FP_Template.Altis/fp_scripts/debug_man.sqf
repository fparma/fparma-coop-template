/*
	General debug script for mission makers
	Show all units on map, adds a few useful actions etc

	Place a unit on the map named "debugger"
	Remove said unit before mission time.
*/

if (tolower str player != "debugger") exitWith {};

if (isMultiplayer) then {
	[] spawn {
		sleep 5;
		format ["Debug script running for %1!", name player] call FP_fnc_hint;
	};
};

// Mark all units on map
[] execVM "src\spawn\debug.sqf";

FP_debug_godMode = true;
player addAction ["<t color='#ffff00'>[ God Mode ]</t> ON", {
	FP_debug_godMode = !FP_debug_godMode;
	player allowDamage FP_debug_godMode;
	_id = _this select 2;
	player setUserActionText [_id, format ["<t color='#ffff00'>[ God Mode ]</t> %1",if FP_debug_godMode then {"ON"}else{"OFF"}]];
}, nil, 99, false, true];

FP_debug_captive = false;
player addAction ["<t color='#ffff00'>[ Captive ]</t> ON", {
	FP_debug_captive = !FP_debug_captive;
	player setCaptive FP_debug_captive;
	_id = _this select 2;
	player setUserActionText [_id, format ["<t color='#ffff00'>[ Captive ]</t> %1", if FP_debug_captive then {"OFF"}else{"ON"}]];
}, nil, 98, false, true];

player addAction ["<t color='#ffff00'>[ Open Arsenal ]</t>", {
	["Open", true] spawn BIS_fnc_arsenal;
}, nil, 97, false, true];

player addAction ["<t color='#ffff00'>[ Mission Stats ]</t>", {
	hint format ["All units: %1 \nW: %2, E: %3, G: %4, C: %5\nAmount dead: %6 \n FPS: %7",
		count allUnits, {side _x == west} count allUnits, {side _x == east} count allUnits, {side _x == independent} count allUnits, {side _x == civilian} count allUnits, count allDeadMen, round diag_fps];	
}, nil, 96, false, true];