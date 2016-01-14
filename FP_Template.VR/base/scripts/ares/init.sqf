/*
    Description:
        Adds FP specific ares functions
*/
#define UTIL "FP Utils"
#define RESPAWN "FP Respawn"
#define AI "FP AI"

private _path = "base\scripts\ares\";
FP_ares_cam = compile preprocessFileLineNumbers (_path + "camera.sqf");
FP_ares_iedProximity = compile preprocessFileLineNumbers (_path + "ied_proximity.sqf");
FP_ares_cargoEject = compile preprocessFileLineNumbers (_path + "cargo_eject.sqf");
FP_ares_ai = compile preprocessFileLineNumbers (_path + "ai.sqf");
FP_ares_jrm = compile preprocessFileLineNumbers (_path + "respawn_jrm.sqf");

// Spawns an IED
[UTIL, "BI Camera at position", {_this call FP_ares_cam}] call Ares_fnc_RegisterCustomModule;
// Spawns an IED
[UTIL, "IED - Proximity", {_this call FP_ares_iedProximity}] call Ares_fnc_RegisterCustomModule;
// Ejects whatever cargo is inside the vehicle
[UTIL, "Force eject vehicle cargo", {_this call FP_ares_cargoEject}] call Ares_fnc_RegisterCustomModule;

// Respawns and moves all players (that can fit) inside the cargo of a specific vehicle
[RESPAWN, "Single unit at position", {["SINGLE", _this select 0] call FP_ares_jrm}] call Ares_fnc_RegisterCustomModule;
// Respawns and moves all dead players to a position
[RESPAWN, "All units at position", {["POSITION", _this select 0] call FP_ares_jrm}] call Ares_fnc_RegisterCustomModule;
// Respawns and moves all players (that can fit) inside the cargo of a specific vehicle
[RESPAWN, "Fill vehicle cargo", {["CARGO", _this select 1] call FP_ares_jrm}] call Ares_fnc_RegisterCustomModule;

// === FP AI commands
[AI, "Patrol area", {["PATROL", _this select 1] call FP_ares_ai}] call Ares_fnc_RegisterCustomModule;
[AI, "Defend area", {["DEFEND", _this select 1] call FP_ares_ai}] call Ares_fnc_RegisterCustomModule;
[AI, "Garrison", {["GARRISON", _this select 1] call FP_ares_ai}] call Ares_fnc_RegisterCustomModule;
