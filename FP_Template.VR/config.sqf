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
FP_coldStartCanStart = "gm, gm2, plt0";
// Units that can move during cold start (object names, comma separated)
FP_coldStartCanMove = "gm, gm2, plt0, plt1, a0, a1, a2, b0, b1, b2, e0, q0, q1, q2, w0, w1, l0, l1";
// Players (object names) that gets higher viewdistance in aircrafts
FP_pilots = "p0, p1";

// Flag teleport targets in format [Display name, objectName]
FP_flagTargets = [
    ["Plt Command", "plt0"],
    ["Alpha Actual", "a0"],
    ["Bravo Actual", "b0"]
];

// The default loadout script file to use. This is a sqf file in \loadouts
FP_defaultLoadout = "template.sqf";
