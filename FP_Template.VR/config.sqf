// Only allow people with map tools to draw on briefing
ACE_maptools_EveryoneCanDrawOnBriefing = false;

FP_VD = 2000; // View distance
FP_OVD = 1800; // object view distance

// Players (object names) that gets higher viewdistance in aircrafts
FP_pilots = ["p0", "p1"];

// Flag teleport targets in format [Display name, objectName]
FP_flag_targets = [
    ["Actual", "actual"],
    ["Alpha SQL", "a0"],
    ["Bravo SQL", "b0"],
    ["Charlie SQL", "c0"],
    ["Delta SQL", "d0"]
];

// The default gear script file. This is a file inside gear\loadouts
FP_gear_default = "vanilla_nato";

// Amount of respawns, -1 = infinite, 0 = none. Can also be higher
FP_JRM_respawns = -1;
