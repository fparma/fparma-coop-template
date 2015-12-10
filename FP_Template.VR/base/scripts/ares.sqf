// Ares util functions
private _DISPLAY_NAME = "FP Utils";

/*
 Ejects whatever cargo is inside the vehicle
*/
[_DISPLAY_NAME, "Force eject vehicle cargo", {
	params ["", "_veh"];
	if (isNull _veh || {_veh isKindOf "Man"} || {speed _veh > 2}) exitWith {};

    private _units = [_veh, ["ffv", "cargo"]] call ACE_common_fnc_getVehicleCrew;

    [_units, {
        {
            _x leaveVehicle (vehicle _x);
            _x action ["Eject", vehicle _x]
        } forEach _this;
    }] remoteExecCall ["BIS_fnc_call", _units];

}] call Ares_fnc_RegisterCustomModule;

/*
 Respawns and moves all players (that can fit) inside the cargo of a specific vehicle
*/
[_DISPLAY_NAME, "[Respawn] Fill vehicle cargo", {
    params ["", "_veh"];
    if (isNull _veh) exitWith {};
    private _maxAmount = _veh emptyPositions "cargo";
    private _deadPlayers = [FP_JRM_savedState, {(_x select 1) == 0}] call ACE_common_fnc_filter;
	if (_maxAmount isEqualTo 0 || {count _deadPlayers == 0}) exitWith {["ERROR: No cargo slots / no dead players"] call ares_fnc_ShowZeusMessage};

    private _code = {
        ["FP_screen"] call BIS_fnc_blackOut;
        [{
            [false] call FP_fnc_spectate;
            player assignAsCargo _this;
            player moveInCargo _this;
            ["FP_screen"] call BIS_fnc_blackIn;
        }, _this select 0, 2 + random 2] call ACE_common_fnc_waitAndExecute;
    };

    private _playerObjects = [];
    {
        private _uid = _x select 0;
        {if (getPlayerUID _x == _uid && alive _x) then {_playerObjects pushBack _x}} forEach allPlayers;
        if (count _playerObjects isEqualTo _maxAmount) exitWith {};
    }forEach _deadPlayers;

    [[_veh], _code] remoteExecCall ["BIS_fnc_call", _playerObjects];
    ["Moved %1 players", count _playerObjects] call ares_fnc_ShowZeusMessage;
}] call Ares_fnc_RegisterCustomModule;

/*
     Respawns and moves all dead players to a position
*/
[_DISPLAY_NAME, "[Respawn] To position", {
    params ["_pos"];
    if (!(_pos call FP_fnc_isValidPos)) exitWith {};
    private _deadPlayers = [FP_JRM_savedState, {(_x select 1) == 0}] call ACE_common_fnc_filter;
    if (count _deadPlayers == 0) exitWith {["ERROR: No dead players"] call ares_fnc_ShowZeusMessage};

    private _playerObjects = [];
    {
        private _uid = _x select 0;
        {if (getPlayerUID _x == _uid && alive _x) then {_playerObjects pushBack _x}} forEach allPlayers;
        if (count _playerObjects isEqualTo _maxAmount) exitWith {};
    } forEach _deadPlayers;

    [_pos] remoteExecCall ["FP_JRM_fnc_forceRespawn", _playerObjects];
    ["Respawned %1 players", count _playerObjects] call ares_fnc_ShowZeusMessage;
}] call Ares_fnc_RegisterCustomModule;

/*
    Spawns an IED
*/
[_DISPLAY_NAME, "[IED] Proximity", {
    params ["_pos"];
    if (!(_pos call FP_fnc_isValidPos)) exitWith {};

    private _objects = ["Land_Sack_F","Land_GarbageBarrel_01_F","Land_BarrelTrash_F","Land_GarbagePallet_F","Land_GarbageWashingMachine_F","Land_Tyres_F"];
    (["IED Settings", [
        ["IED Object", ["Random", "Sack", "Barrel (smiley)", "Barrel (trash)", "Garbage (pallet)", "Garbage (washing machine)", "Pile of tires"], 0],
        ["Trigger distance (m)", ["3", "5", "7", "10"], 1],
        ["Only players can trigger", ["No", "Yes"], 1],
        ["Only targets on foot", ["No", "Yes"], 1]
    ]] call Ares_fnc_ShowChooseDialog) params ["_iedType", "_distance", "_onlyPlayers", "_onlyOnFoot"];

    private _className = if (_iedType == 0) then {_objects call BIS_fnc_selectRandom} else {_objects select (_iedType -1)};
    _distance = parseNumber (["3", "5", "7", "10"] select _distance);
    _onlyPlayers = [false, true] select _onlyPlayers;
    _onlyOnFoot = [false, true] select _onlyOnFoot;

    private _condition = "this";
    if (_onlyPlayers && _onlyOnFoot) then {
        _condition = _condition  + "&& {{isPlayer _x && (vehicle _x == _x)} count thisList > 0}";
    } else {
        if (_onlyPlayers) then {_condition = _condition + "&& {{isPlayer _x} count thisList > 0}"};
        if (_onlyOnFoot) then {_condition = _condition  + "&& {vehicle _x  == _x} count thisList > 0"};
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
    private _trigger = ([getposATL _ied, "AREA:", [_distance, _distance, 0, false], "ACT:", ["ANY", "PRESENT", true]] call CBA_fnc_createTrigger) select 0;
    _trigger setVariable ["fp_ied", _ied];
    _trigger setTriggerStatements [_condition, _statement, ""];
    _trigger attachTo [_ied, [0,0,0]];
}] call Ares_fnc_RegisterCustomModule;
