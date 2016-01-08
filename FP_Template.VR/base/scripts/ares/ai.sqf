/*
    Description:
        Handles FP group AI
*/

params ["_mode", "_grp"];
if (_grp isEqualType objNull) then {_grp = [_grp] call CBA_fnc_getGroup};
if (!(_grp isEqualType grpNull) || { {alive _x} count units _grp == 0}) exitWith {};

switch (toUpper _mode) do {
    case "PATROL": {
        private _radius = ["50", "100", "150", "200", "250", "300", "400", "500"];
        private _args = ["Patrol settings", [
            ["Radius (m)", _radius, 2],
            ["Search buildings", ["Yes", "No"], 0]
        ]] call Ares_fnc_ShowChooseDialog;

        _radius = parseNumber (_radius select (_args select 0));
        private _search = [true, false] select (_args select 1);
        [_grp, _radius, _search] remoteExecCall ["FP_fnc_patrol", leader _grp];
    };
    case "DEFEND": {
        private _radius = ["50", "100", "150", "200", "250", "300", "400", "500"];
        private _treshold = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
        private _args = ["Defend settings", [
            ["Radius (m)", _radius, 2],
            ["Building pos treshold", _treshold, 1]
        ]] call Ares_fnc_ShowChooseDialog;

        _radius = parseNumber (_radius select (_args select 0));
        _treshold = parseNumber (_treshold select (_args select 1));
        [_grp, _radius, _treshold] remoteExecCall ["FP_fnc_defend", leader _grp];
    };
    case "GARRISON": {
        private _radius = ["50", "100", "150", "200", "250", "300", "400", "500"];
        private _args = ["Garrison settings", [
            ["Radius (m)", _radius, 2],
            ["Put on roof", ["Yes", "No"], 0],
            ["Fill buildins evenly", ["Yes", "No"], 1],
            ["Lock units in place", ["Yes", "No"], 1]
        ]] call Ares_fnc_ShowChooseDialog;

        _radius = parseNumber (_radius select (_args select 0));
        [
            _grp,
            _radius,
            [true, false] select (_args select 1),
            [true, false] select (_args select 2),
            [true, false] select (_args select 3)
        ] remoteExecCall ["FP_fnc_garrison", leader _grp];
    };
};
