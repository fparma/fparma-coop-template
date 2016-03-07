
if (!params [
    ["_unit", objNull, [objNull]],
    ["_type", "", ["", nil]],
    ["_script", FP_defaultLoadout, [""]]
]) exitWith {false};

if (!local _unit) exitWith {false};
if (isNil "_type" || {_type == ""}) then {_type = typeOf _unit};

_unit setVariable ["FP_loadout", [_type, _script]];
_unit setVariable ["BIS_enableRandomization", false];

removeHeadgear _unit;
removeAllContainers _unit;
removeAllItems _unit;
removeAllWeapons _unit;
removeAllAssignedItems _unit;

// Wait a second before applying loadout to avoid gear desync
[{
    params ["_unit"];
    if (local _unit) then {
        private __script = compile preprocessFileLineNumbers ("loadouts\" + _this select 2);
        [_unit, _this select 1] call __script;
    } else {
        [_this, {
            [_this select 0, _this select 1] call compile preprocessFileLineNumbers ("loadouts\" + _this select 2);
        }] remoteExec ["BIS_fnc_call", _unit];
    };
}, 1, [_unit, _type, _script]] call ACE_common_fnc_waitAndExecute;
