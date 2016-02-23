// Only allow people with map tools to draw on briefing (true = everyone can draw)
ACE_maptools_EveryoneCanDrawOnBriefing = false;

FP_VD = 2000; // View distance
FP_OVD = 1800; // object view distance

// Amount of respawns, -1 = infinite, 0 = no respawn. Can also be higher
// deaths are saved and units will spectate after that
// to respawn units, use Ares or setup a trigger (check base\functions\jrm\forceRespawn)
FP_JRM_respawns = -1;

// Units (object names, comma separated) that can start the mission from cold start
// If FP_coldStartCanStart is empty string (""), cold start is never activated.
FP_coldStartCanStart = "gm, actual";
// Units that can move during cold start (object names, comma separated)
FP_coldStartCanMove = "gm, actual, a0, b0, c0, d0, crew0, crew1, crew2, p0, p1";
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
