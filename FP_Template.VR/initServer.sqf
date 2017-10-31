/*
    Executed only by server
    See: https://community.bistudio.com/wiki/Functions_Library_(Arma_3)#Initialization_Order
        for details about when the script is exactly executed.
*/

// Track casualties for each side and show on mission end
// Must be used in combination with fpa_common_fnc_endMissionServer
[] call fpa_common_fnc_trackKills;