// Allow everyone to draw when mission is in "briefing" mode
// Otherwise, only people with AGM_MapTools in their inventory
AGM_Map_EveryoneCanDrawOnBriefing = false;

// Units that should have longer view distance when flying. Unit names in strings
FP_pilotNames = ["p1", "p2"];

/* === JiP and respawn manager parameters === */

	/* If enabled at all, NOTE: Respawn must be BASE when using JRM */
	FP_jrm_enabled = false;

	/* If players can respawn, at all. true disables spectator */
	FP_playerCanRespawn = true;

	/* If players die, they can not reconnect and respawn  */
	FP_savePlayerDeathsAndPreventRespawn = false;

	/*Seconds before JIP will not be possible anymore */
	FP_timeBeforeJIPNotPossible = -1; // -1 disabled

	/* If JIP player should be teleported to his group, or if no group members, players on his side */
	FP_JIPTeleport = false;

/* ===  === */