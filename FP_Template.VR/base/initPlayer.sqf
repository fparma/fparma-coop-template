/*
    Initializes the player
*/

// Custom ares funcs
if (isClass (configFile >> "CfgPatches" >> "Ares")) then {
    [] call compile preprocessFileLineNumbers "base\scripts\ares\init.sqf";
};

player addEventHandler ["Respawn", {
    // Add new unit to zeus
    [_this select 0] call FP_fnc_addToCurators;
}];

// Fix so player can't join "ENEMY" side
player addEventHandler ["HandleRating", {
    abs (_this select 1);
}];

// Delete grenades thrown in spawn
player addEventHandler ["Fired", {
    if (_this select 2 == "HandGrenadeMuzzle") then {
        private _proj = param [6, objNull];
        private _idx = [blufor, opfor, independent, civilian] find side player;
        private _mrk = markerPos (["respawn_west","respawn_east","respawn_guerrila","respawn_civilian"] select _idx);
        if ((_this select 0) distance _mrk < 80) then {
            [_proj] call ace_frag_fnc_addBlackList;
            deleteVehicle _proj;
            titleText ["G IS FOR GRENADES", "PLAIN", 2];
        };
    };
}];

// Longer view distance for pilots
if (player in ([FP_pilots, false, true] call ACE_common_fnc_parseList)) then {
    [] call compile preProcessFileLineNumbers "base\scripts\dynamic_vd.sqf";
};

[{time > 0}, {
    // Lower weapon after mission start
    if (primaryWeapon player != "") then {
        player switchMove "amovpercmstpslowwrfldnon";
    };
}, []] call ACE_common_fnc_waitUntilAndExecute;
