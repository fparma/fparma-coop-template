#include "../config_mission.hpp"

if (is3DEN) exitWith {};

enableSaving [false, false];
setViewDistance CFG_VIEWDISTANCE;
setObjectViewDistance CFG_VIEWDISTANCE_OBJECT;

[CFG_JRM_RESPAWNS] call fpa_jrm_fnc_init;

if (!hasInterface) exitWith {};

disableRemoteSensors true;

// When piloting or gunning air vehicle, increase view distance
["vehicle", {
  private _veh = vehicle ACE_player;
  if (!(_veh isKindOf "Air")) exitWith {
    setViewDistance CFG_VIEWDISTANCE;
    setObjectViewDistance CFG_VIEWDISTANCE_OBJECT;
  };

  if (ACE_player in [driver _veh, gunner _veh]) then {
    setViewDistance CFG_AIR_VIEWDISTANCE;
    setObjectViewDistance CFG_AIR_VIEWDISTANCE_OBJECT;
  };
}] call CBA_fnc_addPlayerEventHandler;
