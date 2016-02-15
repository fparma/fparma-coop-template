if (!hasInterface) exitWith {};

["playerVehicleChanged", {
    if (!((vehicle player) isKindOf "Air")) exitWith {
        setViewDistance FP_VD;
        setObjectViewDistance FP_OVD;
    };

    setViewDistance 8000;
    setObjectViewDistance 5000;
}] call ACE_common_fnc_addEventHandler;
