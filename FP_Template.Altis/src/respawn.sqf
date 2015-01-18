/*
	This file runs locally for each player when they respawn
*/

_unit = _this select 0;
_corpse = _this select 1;

// Time before the teleport flag (if available) can be used again, to prevent people from just teleporting after dying.
// The flag is for JiPs not deaths. 3 min default
FP_timeout = time + 180;

// Give gear back
if (!isNil "FP_kit_type" && {FP_kit_type != ""}) then {
		[_unit, FP_kit_type] call FP_fnc_getKit;
};

_corpse spawn {
	sleep 60;
	if (!isNull _this) then {
		hideBody _this;
		sleep 10;
		deleteVehicle _this;
	};
};

// Add new unit to zeus
[_unit, "FP_fnc_addCuratorObject", false] call BIS_fnc_MP;