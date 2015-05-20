// Only allow people with map tools to draw on briefing
ACE_maptools_EveryoneCanDrawOnBriefing = false;

// View distance
FP_VD = 2000;
// object view distance
FP_OVD = 1800;

// Gear: A script file inside gear\loadouts that will be the "default" script for all units calling
// This is useful so unit inits does not have to be changed in every mission
FP_GEAR_DEFAULT = "vanilla_nato";

// Gear: If gear errors should be reported (Boolean). Shows stuff like failed to add etc.
FP_GEAR_REPORT_ERRORS = !isMultiplayer;

// Use clean up script. See base\scripts\clean_up
FP_use_cleanUp = true;

// The targets for teleport flag object. In format [displayName, objectName]. Must be string entries
FP_flag_targets = [
    ["Actual", "actual"],
    ["Alpha Actual","a0"],
    ["Bravo Actual","b0"],
    ["Charlie Actual","c0"],
    ["Delta Actual","d0"]
];

// Seconds when unit respawns before the TP flag can be used, if there is a flag
FP_respawnTeleportDelay = 180;

//Units that should have longer view distance when flying. Unit names in strings
FP_pilotNames = ["p1", "p2"];

// Players that are given the option to start the mission, comma separated strings representing object name
// Empty array ([])  = disabled. Weapons are hot from the go, and no players will locked to a 20m circle until mission has started.
FP_lockStarters = ["gm", "actual"];

// Object names that will not be locked in a 20m circle when mission is under "lock", as in, it has not started.
// Ignored if FP_lockStarters is an empty array. If empty, squad leaders can move by default
FP_lockCanMove = ["gm", "actual", "amed", "a0","b0", "c0", "d0","p1", "p2", "crew1", "crew2", "crew3"];

// === JiP and respawn manager settings (requires xtra) === //
// If you want to utilize wave respawn, the respawn of the mission must be BASE.

// Amount of respawns. 0 = no respawns. -1 will disable JRM and players may respawn infinite amount of times
FP_JRM_amountLives = -1;

// Amount of seconds that JIP is allowed. Units connecting after this time will be killed
// and forced into spectator. -1 = disabled
FP_JRM_timeBeforeJIPNotPossible = -1;

// If JIP players should be teleported.
// Group leader = teleport to group
// Member of group = teleport to leader
// No members in group = teleport to an average position of all players on side
FP_JRM_JIPTeleport = false;
