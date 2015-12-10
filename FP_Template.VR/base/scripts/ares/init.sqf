/*
    Description:
        Adds FP specific ares functions
*/

private _path = "base\scripts\ares\";
FP_ares_cargoEject = compile preprocessFileLineNumbers (_path + "cargo_eject.sqf");
FP_ares_respawnAtPos = compile preprocessFileLineNumbers (_path + "respawn_at_position.sqf");
FP_ares_respawnInCargo = compile preprocessFileLineNumbers (_path + "respawn_in_cargo.sqf");
FP_ares_iedProximity = compile preprocessFileLineNumbers (_path + "ied_proximity.sqf");

private _DISPLAY_NAME = "FP Utils";
// Ejects whatever cargo is inside the vehicle
[_DISPLAY_NAME, "Force eject vehicle cargo", {_this call FP_ares_cargoEject}] call Ares_fnc_RegisterCustomModule;
// Respawns and moves all dead players to a position
[_DISPLAY_NAME, "[Respawn] At position", {_this call FP_ares_respawnAtPos}] call Ares_fnc_RegisterCustomModule;
// Respawns and moves all players (that can fit) inside the cargo of a specific vehicle
[_DISPLAY_NAME, "[Respawn] Fill vehicle cargo", {_this call FP_ares_respawnInCargo}] call Ares_fnc_RegisterCustomModule;
// Spawns an IED
[_DISPLAY_NAME, "[IED] Proximity", {_this call FP_ares_iedProximity}] call Ares_fnc_RegisterCustomModule;
