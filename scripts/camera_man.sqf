/*
	Script: Camera_man

	Description:
		Provdes camera man utilities. Execute from initPlayerLocal.sqf and change
        "unitName" in the example to the object name of the unit that should have
        camera utils.

        Can open BIS camera,
        Ctrl + B Disabled hud

    Parameters
        _unit = Unit to give camera utils to

    Examples:
    (begin example)
        // initPlayerLocal.sqf
        [missionNamespace getVariable ["ChangeMeToObjectName", objNull]] call compile preprocessFileLineNumbers "scripts\camera_man.sqf";
    (end)

	Author:
	Cuel 2016-01-14
*/

params ["_unit"];
if (!hasInterface || {!(local _unit)}) exitWith {};

_unit createDiaryRecord
["Diary",["CAMERA MAN INFORMATION","
  You can turn on BIS camera with the action menu.<br />
  Pressing L in BIS camera disables HUD<br /><br /><br />
  Camera man can toggle HUD outside BIS cam by pressing Ctrl+B (won't hide ST HUD)
  To turn off ST Hud, press alt+shift+H<br /><br />
"]];

[["<t color='#ff8a00'>\\ Open BIS Cam //</t>", {
  ["Init"] spawn BIS_fnc_camera;
}, 0, -99, false, true, "", ""]] call CBA_fnc_addPlayerAction;

[] spawn {
  FP_shownHud = true;
  waitUntil {!isNull (findDisplay 46)};
  (findDisplay 46) displayAddEventHandler ["keyDown", {
    params ["", "_dikCode", "", "_ctrl"];
    private _res = false;
    if (_ctrl && _dikCode ==  48) then {
      showHUD [!FP_shownHud, !FP_shownHud, !FP_shownHud, !FP_shownHud, !FP_shownHud, !FP_shownHud, !FP_shownHud, !FP_shownHud];
      FP_shownHud = !FP_shownHud;
      _res = true;
    };
    _res
  }];
};
