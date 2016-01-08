/*
    Description:
        Adds FP specific ares functions
*/
#define UTIL "FP Utils"
#define RESPAWN "FP Respawn"
#define AI "FP AI"

private _path = "base\scripts\ares\";
FP_ares_iedProximity = compile preprocessFileLineNumbers (_path + "ied_proximity.sqf");
FP_ares_cargoEject = compile preprocessFileLineNumbers (_path + "cargo_eject.sqf");
FP_ares_respawnAtPos = compile preprocessFileLineNumbers (_path + "respawn_at_position.sqf");
FP_ares_respawnInCargo = compile preprocessFileLineNumbers (_path + "respawn_in_cargo.sqf");
FP_ares_respawnSingle = compile preprocessFileLineNumbers (_path + "respawn_single.sqf");
FP_ares_ai = compile preprocessFileLineNumbers (_path + "ai.sqf");


// Spawns an IED
[UTIL, "IED - Proximity", {_this call FP_ares_iedProximity}] call Ares_fnc_RegisterCustomModule;

// Ejects whatever cargo is inside the vehicle
[UTIL, "Force eject vehicle cargo", {_this call FP_ares_cargoEject}] call Ares_fnc_RegisterCustomModule;

// Respawns and moves all dead players to a position
[RESPAWN, "All units at position", {_this call FP_ares_respawnAtPos}] call Ares_fnc_RegisterCustomModule;

// Respawns and moves all players (that can fit) inside the cargo of a specific vehicle
[RESPAWN, "Fill vehicle cargo", {_this call FP_ares_respawnInCargo}] call Ares_fnc_RegisterCustomModule;

// Respawns and moves all players (that can fit) inside the cargo of a specific vehicle
[RESPAWN, "Single unit at position", {_this call FP_ares_respawnSingle}] call Ares_fnc_RegisterCustomModule;

// FP AI commands
[AI, "Patrol area", {["PATROL", _this select 1] call FP_ares_ai}] call Ares_fnc_RegisterCustomModule;
[AI, "Defend area", {["DEFEND", _this select 1] call FP_ares_ai}] call Ares_fnc_RegisterCustomModule;
[AI, "Garrison", {["GARRISON", _this select 1] call FP_ares_ai}] call Ares_fnc_RegisterCustomModule;
