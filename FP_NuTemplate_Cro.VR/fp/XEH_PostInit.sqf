/*
    Initializes the player
*/

if (!hasInterface) exitWith {};

// Add JIP players to zeus
if (didJIP) then {[player] call FP_fnc_addToCurators};

// Initialize jip and respawn manager
[] call FP_JRM_fnc_init;

player addEventHandler ["Respawn", {
  // Add new unit to zeus
  [_this select 0] call FP_fnc_addToCurators;
}];

// Fix so player can't join "ENEMY" side
player addEventHandler ["HandleRating", {
  abs (_this select 1);
}];

// When piloting or gunning air vehicle, increase view distance
["playerVehicleChanged", {
  if (!((vehicle ACE_player) isKindOf "Air")) exitWith {
    setViewDistance FP_VD;
    setObjectViewDistance FP_OVD;
  };

  private _veh = vehicle ACE_player;
  if (ACE_player in [driver _veh, gunner _veh]) then {
    setViewDistance FP_VD_AIR;
    setObjectViewDistance FP_OVD_AIR;
  };
}] call ACE_common_fnc_addEventHandler;

// Delete grenades thrown in spawn
player addEventHandler ["Fired", {
  if ((_this select 2) == "HandGrenadeMuzzle") then {
    private _proj = param [6, objNull];
    private _idx = [blufor, opfor, independent, civilian] find side player;
    if (_idx == -1) exitWith {};

    private _mrk = markerPos (["respawn_west","respawn_east","respawn_guerrila","respawn_civilian"] select _idx);
    if ((_this select 0) distance _mrk < 80) then {
        [_proj] call ace_frag_fnc_addBlackList;
        deleteVehicle _proj;
        titleText ["G IS FOR GRENADES", "PLAIN", 2];
    };
  };
}];

[{
  // Lower weapon after mission start
  if (primaryWeapon player != "") then {
    player switchMove "amovpercmstpslowwrfldnon";
  };

  // Disable remote sensors for regular clients (not server, hc, zeus)
  // Curator logic might be null at time 0
  if (!isServer &&
    {isNull (getAssignedCuratorLogic player)}
  ) then {
    disableRemoteSensors true;
  };
}, [], 0.2] call ACE_common_fnc_waitAndExecute;
