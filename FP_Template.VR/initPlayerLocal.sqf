/*
	Executed locally when player joins mission (includes both mission start and JIP).
  	This script guarantees that player object exists. Init.sqf does not
	See: https://community.bistudio.com/wiki/Functions_Library_(Arma_3)#Initialization_Order
		for details about when the script is exactly executed.
*/

[] call compile preprocessFileLineNumbers "briefing.sqf";

// Apply loadout
if (!isNil "FP_fnc_getLoadout") then {
  private _added = [player, typeOf player] call FP_fnc_getLoadout;

  // Respawn with gear
  if (_added) then {
    player addEventHandler ["Respawn", {
      [player, typeOf player] call FP_fnc_getLoadout;
    }];
  };

  if (!isMultiplayer) then {
    // Give AI loadouts
    {
      [_x, typeOf _x] call FP_fnc_getLoadout;
    } forEach (switchableUnits - (entities "HeadlessClient_F" + [player]));
  };
};

// Easier arsenal in editor, validate mission
if (!isMultiplayer) then {
  // Make arsenal easier to enter
  [["<t color='#ffff00'>[ Arsenal ]</t>", {[ace_player, ace_player, true] call ace_arsenal_fnc_openBox}, 0, -85, false, true, "", ""]] call CBA_fnc_addPlayerAction;
  
  // Validate unit descriptions and callsigns. Can be removed (description.ext)
  private _cfg = getMissionConfig "MissionSQM";
  if (!isNull _cfg) then {
    [_cfg] call fpa_common_fnc_validateMission;
  };
};
