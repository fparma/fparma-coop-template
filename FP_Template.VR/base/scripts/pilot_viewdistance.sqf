if (!hasInterface) exitWith {};

["playerVehicleChanged", {
	local _veh = vehicle player;
	if !(_veh isKindOf "Air") exitWith {
		setViewDistance FP_VD;
		setObjectViewDistance FP_OVD;
	};
	if (ACE_player in [driver _veh, gunner _veh]) exitWith {
		setViewDistance 8000;
		setObjectViewDistance 5000;
	};
}] call ACE_common_fnc_addEventHandler;
