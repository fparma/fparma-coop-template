//Allow everyone to draw when mission is in "briefing" mode
//Otherwise, only people with AGM_MapTools in their inventory may draw
AGM_Map_EveryoneCanDrawOnBriefing = false;

// Seconds when unit respawns before the TP flag can be used, if available
FP_tp_respawnDelay = 180;

//Units that should have longer view distance when flying. Unit names in strings
FP_pilotNames = ["p1", "p2"];

//Players that are given the option to start the mission, comma separated strigs representing object name
//Empty array = disabled. Weapons are hot from the go, and no players will locked to a 20m circle until mission has started.
FP_missionStarters = ["debugger","gm", "actual"];

//Unit names that will not be locked in a 20m circle when mission is under "lock", as in, it has not started.
//Ignored if no units in FP_missionStarters
FP_noLockUnits = ["debugger","gm", "actual", "amed", "a0","b0", "c0", "d0","p1", "p2", "crew1", "crew2", "crew3"];

/* === JiP and respawn manager parameters === */

	/* If enabled at all, no other settings matter if this is not true. NOTE: Respawn must be BASE when using JRM */
	FP_jrm_enabled = false;

	// Amount of times player can respawn. -1 = unlimited
	FP_jrm_amountLives = -1;

	/*Seconds before JiP will not be possible anymore */
	FP_jrm_timeBeforeJIPNotPossible = -1; // -1 disabled

	/* If JIP player should be teleported to his group, or if no group members, players on his side */
	FP_jrm_JIPTeleport = false;

/* ===  === */
