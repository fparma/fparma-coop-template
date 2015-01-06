_unit = _this select 0;
_corpse = _this select 1;

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

[_unit, "FP_addCuratorObject", false] call BIS_fnc_MP;