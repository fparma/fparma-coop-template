/*
  General debug script for mission makers
  Show all units on map, adds a few useful actions etc

    Usage:
    [] call compile preprocessFileLineNumbers "scripts\debug.sqf";
*/

FP_debug_godMode = true;
[["<t color='#ffff00'>[ God Mode ]</t> ON", {
  FP_debug_godMode = !FP_debug_godMode;
  player allowDamage FP_debug_godMode;
  private _id = _this select 2;
  player setUserActionText [_id, format ["<t color='#ffff00'>[ God Mode ]</t> %1",if FP_debug_godMode then {"ON"}else{"OFF"}]];
}, 0, 99, false, true, "", ""]] call CBA_fnc_addPlayerAction;

FP_debug_captive = false;
[["<t color='#ffff00'>[ Captive ]</t> ON", {
  FP_debug_captive = !FP_debug_captive;
  player setCaptive FP_debug_captive;
  private _id = _this select 2;
  player setUserActionText [_id, format ["<t color='#ffff00'>[ Captive ]</t> %1", if FP_debug_captive then {"OFF"}else{"ON"}]];
}, 0, 98, false, true, "", ""]] call CBA_fnc_addPlayerAction;

[["<t color='#ffff00'>[ Open Arsenal ]</t>", {
  ["Open", true] spawn BIS_fnc_arsenal;
}, 0, 97, false, true, "", ""]] call CBA_fnc_addPlayerAction;

[["<t color='#ffff00'>[ Mission stats ]</t>", {
  hint format ["All units: %1 \nW: %2, E: %3, G: %4, C: %5\nAmount dead: %6 \n FPS: %7",
    count allUnits, {side _x == west} count allUnits, {side _x == east} count allUnits, {side _x == independent} count allUnits, {side _x == civilian} count allUnits, count allDeadMen, round diag_fps];
}, 0, 96, false, true, "", ""]] call CBA_fnc_addPlayerAction;


/*
Author: Quiksilver
Script Name: Soldier Tracker v1.0.2
Contact: camball@gmail.com ||  http://forums.bistudio.com/showthread.php?184108-Soldier-Tracker-(-Map-and-GPS-Icons-)
Created: 8/08/2014
Version: v1.0.1
Last modified: 14/10/2014 ArmA 1.30 by Quiksilver
Installation: Follow instructions posted in the below link

http://forums.bistudio.com/showthread.php?184108-Soldier-Tracker-(-Map-and-GPS-Icons-)

DESCRIPTION:

  A CPU-friendly Player Icons script for showing players and vehicles on the map interfaces.
  Developed for my in-development co-op mission, decided to package and release it by itself.
  This version contains the basics.
  Designed for realism. No fancy frills, bright colors or gimmicky features.
  Enjoy!

  Note:

    Common medical variables for icon color.
    Replace the relevant line in QS_fnc_iconColor (~line 37) with the correct line below:

      BTC Revive:       if (format [""%1"", _u getVariable ""BTC_need_revive""] == ""1"") exitWith {_c = [1,1,1,1];_c;};
      Farooq's Revive:     if (format [""%1"", _u getVariable ""FAR_isUnconscious""] == ""1"") exitWith {_c = [1,1,1,1];_c;};
      AIS Wounding System:   if (_u getVariable ""unit_is_unconscious"") exitWith {_c = [1,1,1,1];_c;};
_________________________________________________________________*/

//=============================================================== FUNCTIONS

//======================== ICON COLOR

QS_fnc_iconColor = compileFinal "
  private [""_u"",""_c"",""_a""];
  _u = _this select 0;
  _a = 0.7;

  if ((group _u) == (group player)) then {_a = 0.9;};

  if (format [""%1"", _u getVariable ""BTC_need_revive""] == ""1"") exitWith {_c = [1,0.41,0,1];_c;};

  if (side _u == east) exitWith {_c = [0.5,0,0,_a];_c;};
  if (side _u == west) exitWith {_c = [0,0.3,0.6,_a];_c;};
  if (side _u == independent) exitWith {_c = [0,0.5,0,_a];_c;};
  if (side _u == civilian) exitWith {_c = [0.4,0,0.5,_a];_c;};
  _c = [0.7,0.6,0,_a];_c;
";

//======================== ICON TYPE

QS_fnc_iconType = compileFinal "
  private [""_v"",""_i""];
  _v = _this select 0;
  _i = _v getVariable [""icontype"",""""];
  if (_i == """") then {
    _i = getText (configFile >> ""CfgVehicles"" >> typeOf _v >> ""icon"");
    _v setVariable [""icontype"",_i];
  };
  _i;
";

//======================== ICON SIZE

QS_fnc_iconSize = compileFinal "
  private [""_v"",""_i""];
  _v = _this select 0;
  if (_v isKindOf ""Man"") exitWith {_i = 22;_i;};
  if (_v isKindOf ""LandVehicle"") exitWith {_i = 28;_i;};
  if (_v isKindOf ""Air"") exitWith {_i = 28;_i;};
  if (_v isKindOf ""Ship"") exitWith {_i = 26;_i;};
";

//======================== ICON TEXT

QS_fnc_iconText = compileFinal "
  private [""_n"",""_v"",""_y"",""_vt"",""_t"",""_vn""];
  _v = _this select 0;
  _vt = _v getVariable [""vt"",""""];
  if (_vt == """") then {
    _vt = getText (configFile >> ""CfgVehicles"" >> typeOf _v >> ""displayName"");
    _v setVariable [""vt"",_vt];
  };
  _vn = if (isPlayer (crew _v select 0)) then {name (crew _v select 0)}else{""""};
  if (((_v distance player) < 3500) || {(serverCommandAvailable ""#kick"")}) then {
    _t = format [""%1 [%2]"",_vn,_vt];
  } else {
    _t = format [""%1"",_vn];
  };
  if (_v isKindOf ""LandVehicle"" || _v isKindOf ""Air"" || _v isKindOf ""Ship"") then {
    _n = 0;
    _n = ((count crew _v) - 1);

    if (_n > 0) then {
      if (!isNull driver _v) then {
        _t = format [""%1 [%2] +%3"",_vn,_vt,_n];
      } else {
        _t = format [""[%1] %2 +%3"",_vt,_vn,_n];
      };
    } else {
      if (!isNull driver _v) then {
        _t = format [""%1 [%2]"",_vn,_vt];
      } else {
        _t = format [""[%1] %2"",_vt,_vn];
      };
    };
    if (!isPlayer _v) then {
      _au = [""I_UAV_01_F"",""B_UAV_01_F"",""O_UAV_01_F"",""I_UAV_02_F"",""O_UAV_02_F"",""I_UAV_02_CAS_F"",""O_UAV_02_CAS_F"",""B_UAV_02_F"",""B_UAV_02_CAS_F"",""O_UAV_01_F"",""O_UGV_01_F"",""O_UGV_01_rcws_F"",""I_UGV_01_F"",""B_UGV_01_F"",""I_UGV_01_rcws_F"",""B_UGV_01_rcws_F"",""B_GMG_01_A_F"",""B_HMG_01_A_F"",""O_GMG_01_A_F"",""O_HMG_01_A_F"",""I_GMG_01_A_F"",""I_HMG_01_A_F""];
      _iau = ({typeOf _v == _x} count _au) > 0;
      if (_iau) exitWith {
        if (isUavConnected _v) then {
          _y = (UAVControl _v) select 0;
          _t = format [""%1 [%2]"",name _y,_vt]; _t;
        } else {
          _t = format [""[AI] [%1]"",_vt]; _t;
        };
      };
    };
  };
  _t;
";

//======================== DRAW MAP

QS_fnc_iconDrawMap = compileFinal "
  private [""_v"",""_iconType"",""_color"",""_pos"",""_iconSize"",""_dir"",""_text"",""_shadow"",""_textSize"",""_textFont"",""_textOffset"",""_units""];
  _shadow = 1;
  _textSize = 0.05;
  _textFont = 'puristaMedium';
  _textOffset = 'right';
  {
    _v = vehicle _x;
    _iconType = [_v] call QS_fnc_iconType;
    _color = [_x] call QS_fnc_iconColor;
    _pos = getPosASL _v;
    _iconSize = [_v] call QS_fnc_iconSize;
    _dir = getDir _v;
    _text = [_v] call QS_fnc_iconText;

    if (_x == crew _v select 0 || {(_x in allUnitsUav)}) then {
      _this select 0 drawIcon [
        _iconType,
        _color,
        _pos,
        _iconSize,
        _iconSize,
        _dir,
        _text,
        _shadow,
        _textSize,
        _textFont,
        _textOffset
      ]
    };
  } count (allUnits);
";

//======================== DRAW GPS

QS_fnc_iconDrawGPS = compileFinal "
  private [""_v"",""_iconType"",""_color"",""_pos"",""_iconSize"",""_dir"",""_text"",""_shadow"",""_textSize"",""_textFont"",""_textOffset""];
  _text = """";
  _shadow = 1;
  _textSize = 0.05;
  _textFont = 'puristaMedium';
  _textOffset = 'right';
  {
    _v = vehicle _x;

    if ((_x distance player) < 300) then {
      _iconType = [_v] call QS_fnc_iconType;
      _color = [_x] call QS_fnc_iconColor;
      _pos = getPosASL _v;
      _iconSize = [_v] call QS_fnc_iconSize;
      _dir = getDir _x;

      if (_x == crew _v select 0 || {(_x in allUnitsUav)}) then {
        _this select 0 drawIcon [
          _iconType,
          _color,
          _pos,
          _iconSize,
          _iconSize,
          _dir,
          _text,
          _shadow,
          _textSize,
          _textFont,
          _textOffset
        ]
      };
    };
  } count (playableUnits + switchableUnits + allUnitsUav);
";

//=============================================================== INITIALIZATION

[] spawn {
  sleep 0.1;

  //===== INIT MAP

  waitUntil {sleep 0.1; !(isNull (findDisplay 12))};
  clientEhDrawMap = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw",QS_fnc_iconDrawMap];

  //===== INIT GPS (waits for GPS to open)

  disableSerialization;
  _gps = controlNull;
  while {isNull _gps} do {
    {
      if !(isNil {_x displayctrl 101}) then {
        _gps = _x displayctrl 101
      };
    } count (uiNamespace getVariable "IGUI_Displays");
    sleep 1;
  };
  clientEhDrawGps = _gps ctrlAddEventHandler ["Draw", QS_fnc_iconDrawGPS];

  //===== INIT RESPAWN MENU MAP - UNSUPPORTED v1.0.2
  //===== INIT ZEUS MAP - UNSUPPORTED v1.0.2
  //===== INIT ARTILLERY COMPUTER - UNSUPPORTED v1.0.2
  //===== INIT UAV TERMINAL MAP - UNSUPPORTED v1.0.2
};
