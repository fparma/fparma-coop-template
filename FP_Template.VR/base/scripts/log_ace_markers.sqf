/*
 * Author: commy2
 * Edited by Cuel
 * MarkerPlacement closed
 *
 * Arguments:
 * 0: RscDisplayInsertMarker <DISPLAY>
 * 1: CloseNumber (1 = ButtonOk) <NUMBER>
 *
 * Return Value:
 * None
 *
 * Example:
 * [onUnloadEvent] call ace_markers_fnc_placeMarker;
 *
 * Public: No
 */
#include "\z\ace\addons\markers\functions\script_component.hpp"

disableserialization;
params ["_display", "_closeNum"];
TRACE_2("params",_display,_closeNum);

if (_closeNum == 1) then {
    // set and send marker data the next frame. the actual marker isn't created yet
    [{
        if (time < 1) then { // only at mission briefing
            [[
                [player, GETGVAR(currentMarkerConfigName, ""), mapGridPosition (GETGVAR(currentMarkerPosition, []))],
                {
                    systemChat format ["SERVER: %1 placed a '%2' marker at %3",
                    name (_this select 0),
                    if ((_this select 1) != "") then {getText (configFile >> "cfgMarkers" >> (_this select 1) >> "name")} else {""},
                    if (playerSide == side (_this select 0)) then {_this select 2} else {"<redacted>"}]
                }
            ], "BIS_fnc_spawn", true] call BIS_fnc_MP;
        };

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
