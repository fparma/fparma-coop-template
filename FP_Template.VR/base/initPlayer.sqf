
// is set by fn_getKit
FP_kit_type = player getVariable ["FP_kit_type", []];

player addEventHandler ["Respawn", {
	// Time before the teleport flag (if available) can be used again, to prevent people from just teleporting after dying.
	// The flag is for JiPs not deaths. 3 min default. Edit in config.sqf
	FP_tp_timeout = time + FP_respawnTeleportDelay;

	// Add new unit to zeus
	[_this select 0, "FP_fnc_addCuratorObject", false] call BIS_fnc_MP;

	// Respawn with gear if using template gear
	if (count FP_kit_type > 0) then {
		[_this select 0, FP_kit_type select 0, FP_kit_type select 1] call FP_fnc_getKit;
	};
}];

// Fix so player cant join ENEMY side, where all sides fires on him
player addEventHandler ["HandleRating", {
	_rating = _this select 1;
	(abs _rating)
}];

// Lower weapon after mission start
[{
	player switchMove "amovpercmstpslowwrfldnon";
}, []] call ACE_common_fnc_execNextFrame;
