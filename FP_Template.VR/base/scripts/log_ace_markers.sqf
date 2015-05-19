/*
    Logs when markers are placed (in ACE)
*/

#include "\z\ace\addons\markers\functions\script_component.hpp"

disableserialization;
PARAMS_2(_display,_closeNum);

if (_closeNum == 1) then {
    if (time < 1) then { // only at mission briefing
        [[
            [player, GETGVAR(currentMarkerConfigName, ""), mapGridPosition (GETGVAR(currentMarkerPosition, ""))],
            {
                systemChat format ["SERVER: %1 placed a '%2' marker at %3",
                name (_this select 0),
                if ((_this select 1) != "") then {getText (configFile >> "cfgMarkers" >> (_this select 1) >> "name")} else {""},
                if (playerSide == side (_this select 0)) then {_this select 2} else {"<redacted>"}]
            }
        ], "BIS_fnc_spawn", true] call BIS_fnc_MP;
    };

    [{
        [QGVAR(setMarkerNetwork), [
        allMapMarkers select (count allMapMarkers - 1), [
        GETGVAR(currentMarkerConfigName,""),
        GETGVAR(currentMarkerColorConfigName,""),
        GETGVAR(currentMarkerPosition,[]),
        GETGVAR(currentMarkerAngle,0)
        ]
        ]] call EFUNC(common,globalEvent);

    }, []] call EFUNC(common,execNextFrame);
};
