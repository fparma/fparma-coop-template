/*
    Description:
        Spawns a custom IED with settings
*/

params ["_pos"];
if (!(_pos call FP_fnc_isValidPos)) exitWith {};

private _args = ["IED Settings", [
    ["IED Object", ["Random", "Sack", "Barrel (smiley)", "Barrel (trash)", "Garbage (pallet)", "Garbage (washing machine)", "Pile of tires"], 0],
    ["Trigger distance (m)", ["3", "5", "7", "10"], 1],
    ["Only players can trigger", ["No", "Yes"], 1],
    ["Only targets on foot", ["No", "Yes"], 1]
]] call Ares_fnc_ShowChooseDialog;

_args params ["_iedType", "_distance", "_onlyPlayers", "_onlyOnFoot"];
private _objects = ["Land_Sack_F","Land_GarbageBarrel_01_F","Land_BarrelTrash_F","Land_GarbagePallet_F","Land_GarbageWashingMachine_F","Land_Tyres_F"];
private _className = if (_iedType == 0) then {_objects call BIS_fnc_selectRandom} else {_objects select (_iedType -1)};

_distance = [3, 5, 7, 10] select _distance;
_onlyPlayers = [false, true] select _onlyPlayers;
_onlyOnFoot = [false, true] select _onlyOnFoot;

private _condition = "count thisList > 0";
if (_onlyPlayers && _onlyOnFoot) then {
    _condition = _condition  + "&& {{isPlayer _x && (vehicle _x == _x)} count thisList > 0}";
} else {
    if (_onlyPlayers) then {_condition = _condition + "&& {{isPlayer _x} count thisList > 0}"};
    if (_onlyOnFoot) then {_condition = _condition  + "&& {{vehicle _x  == _x} count thisList > 0}"};
};

private _statement = {
    private _ied = thisTrigger getVariable ["fp_ied", objNull];
    deletevehicle thisTrigger;
    if (!alive _ied) exitWith {};

    [_ied] spawn {
        params ["_ied"];
        private _pos = getposATL _ied;
        [[_ied], ["fp_iedbuzz1", "fp_iedbuzz2", "fp_iedbuzz3", "fp_iedbuzz4", "fp_iedbuzz5"] call BIS_fnc_selectRandom] call CBA_fnc_globalSay;
        sleep 3.3;
        deleteVehicle _ied;
        ("M_Titan_AT" createVehicle [_pos select 0, _pos select 1, (_pos select 2) + 0.1]) setVelocity [0, 0, -50];
        [2.5, 2, 25] remoteExecCall ["addCamShake", ({isPlayer _x} count (_pos nearEntities ["CAManBase", 40]))];
        sleep .1;
        _crater = createVehicle ["CraterLong_small", _pos, [], 0, "NONE"];
        [{
            deleteVehicle _this;
        }, _crater, 300] call ACE_common_fnc_waitAndExecute;
    };
} call ACE_common_fnc_codeToString;

private _ied = createVehicle [_className, [0, 0, 0], [], 0, "NONE"];
_ied setPosATL _pos;
private _trigger = ([_pos, "AREA:", [_distance, _distance, 0, false], "ACT:", ["ANY", "PRESENT", false]] call CBA_fnc_createTrigger) select 0;
_trigger setVariable ["fp_ied", _ied];
_trigger setTriggerStatements [_condition, _statement, ""];
_trigger attachTo [_ied, [0,0,0]];
[_ied] call FP_fnc_addToCurators;
