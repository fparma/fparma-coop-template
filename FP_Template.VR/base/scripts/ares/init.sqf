/*
    Description:
        Adds FP specific ares functions
*/
#define UTIL "FP Utils"
#define RESPAWN "FP Respawn"

private _path = "base\scripts\ares\";
FP_ares_iedProximity = compile preprocessFileLineNumbers (_path + "ied_proximity.sqf");
FP_ares_cargoEject = compile preprocessFileLineNumbers (_path + "cargo_eject.sqf");
FP_ares_respawnAtPos = compile preprocessFileLineNumbers (_path + "respawn_at_position.sqf");
FP_ares_respawnInCargo = compile preprocessFileLineNumbers (_path + "respawn_in_cargo.sqf");
FP_ares_respawnSingle = compile preprocessFileLineNumbers (_path + "respawn_single.sqf");


// Spawns an IED
[UTIL, "[IED] Proximity", {_this call FP_ares_iedProximity}] call Ares_fnc_RegisterCustomModule;

// Ejects whatever cargo is inside the vehicle
[UTIL, "Force eject vehicle cargo", {_this call FP_ares_cargoEject}] call Ares_fnc_RegisterCustomModule;

// Respawns and moves all dead players to a position
[RESPAWN, "[Respawn] At position", {_this call FP_ares_respawnAtPos}] call Ares_fnc_RegisterCustomModule;

// Respawns and moves all players (that can fit) inside the cargo of a specific vehicle
[RESPAWN, "[Respawn] Fill vehicle cargo", {_this call FP_ares_respawnInCargo}] call Ares_fnc_RegisterCustomModule;

// Respawns and moves all players (that can fit) inside the cargo of a specific vehicle
[RESPAWN, "[Respawn] Single unit at pos", {_this call FP_ares_respawnSingle}] call Ares_fnc_RegisterCustomModule;
