// Only allow people with map tools to draw on briefing (true = everyone can draw)
ACE_maptools_EveryoneCanDrawOnBriefing = false;

// Units (object names) that can start the mission from cold start, and units that can move during cold start
// If canStart is empty string (""), cold start is not activated.
FP_coldStartCanStart = "gm, actual";
FP_coldStartCanMove = "gm, actual, a0, b0, c0, d0, crew0, crew1, crew2, p0, p1";

FP_VD = 2000; // View distance
FP_OVD = 1800; // object view distance

// Players (object names) that gets higher viewdistance in aircrafts
FP_pilots = "p0, p1";

// Flag teleport targets in format [Display name, objectName]
FP_flagTargets = [
    ["Actual", "actual"],
    ["Alpha SQL", "a0"],
    ["Bravo SQL", "b0"],
    ["Charlie SQL", "c0"],
    ["Delta SQL", "d0"]
];

// The default gear script file. This is a file inside gear\loadouts
FP_gearDefault = "vanilla_nato";

// Amount of respawns, -1 = infinite, 0 = no respawn. Can also be higher
FP_JRM_respawns = -1;
