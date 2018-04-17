/*
///////////////////////////
  ARMA 3 Teleport script
  Author: Cuel
  Created: 2013-09-25
  Purpose: Allows units to use an object to teleport, sends a request and the receiver has to allow or decline
  Takes an array format: [ADDACTION_OBJECT, ["DISPLAY_NAME","unitName"],["DISPLAY_NAME2","unitName2"]]
  Note the string format for units.
  Version: 0.1
  example initPlayerLocal.sqf: [flag_obj,["Alpha 1", "a1"]] execVM "scripts\teleport_flag.sqf";
///////////////////////////
*/

if (!hasInterface) exitWith {};
private ["_tpobj","_tptargets","_idx","_cnt"];
_tpobj = [_this,0,objNull] call BIS_fnc_param;
_tptargets = [_this,1,[],[[]]] call BIS_fnc_param;
if (isNull _tpobj || (count (_tptargets - [0])) < 1) exitWith {["Wrong parameters for teleport script, exiting"] call BIS_fnc_log};

_idx = 100;
_cnt = {_idx = _idx -1 ;_idx};
_tpobj addAction ["<t color='#FF00FF'>-- TP FLAG for JiPs - ASK FIRST! --</t>", "",0,call _cnt,false,true,"","(vehicle player == player && player distance _target < 5)"];
_tpobj addAction ["-----------------------", "",0,call _cnt,false,true,"","(vehicle player == player && player distance _target < 5)"];
for "_i" from 0 to (count _tptargets)-1 do {
  _tptar = (_tptargets select _i) select 1;
  if (!isNull (missionNamespace getVariable [_tptar, objNull])) then {
    _tpobj addAction (call compile format ['[" >> %1", {[%2] call FP_query_TP},"",call _cnt,false,true,"","(vehicle player == player && alive %2 && player distance _target < 5)"]',(_tptargets select _i) select 0,_tptar]);
  };
};
_tpobj addAction ["-----------------------", "",0,call _cnt,false,true,"","(vehicle player == player && player distance _target < 5)"];

if (!isNil "FP_teleport_init") exitWith {};
FP_teleport_init = true;

FP_tp_timeout = 0;
player addEventHandler ["Respawn", {
  FP_tp_timeout = time + 180;
}];

// commading menu entry
FP_query_TPMenu = [
  ["TP REQ.",false],
  ["Allow user teleport ?",[2],"",-5,[["expression",'true']],"1","0"],
  ["Allow",[3],"",-5,[["expression",'FP_tp_menuAccept = 1']],"1","1"],
  ["Decline",[4],"",-5,[["expression",'FP_tp_menuAccept = 0']],"1","1"]
];

// CLIENT1:  gets called from flag action menu, sends a request
FP_query_TP = {
  _unit = [_this,0,objNull] call BIS_fnc_param;
  if (isNull _unit) exitWith {};
  if ((getPosATL _unit) distance [0,0,0] < 120) exitWith {hint 'Target not available at the moment.'};
  if (vehicle _unit != _unit) exitWith {hint "Target is currently inside a vehicle"};
  if (!isPlayer _unit) exitWith {[_unit,1] call FP_handleTPAnswer };
  if (time < FP_tp_timeout) exitWith {hint format ['You have recently died and must wait before you can teleport (%1s)',round FP_tp_timeout - time]};
  if (isNil "FP_TP_Req_Busy") then {FP_TP_Req_Busy = false};
  if (FP_TP_Req_Busy) exitWith {hint "Please wait."};
  FP_TP_Req_Busy = true;
  [player,"FP_receiveTPQuery",_unit,false] spawn BIS_fnc_MP;
  _str =  "<t font='TahomaB' size='0.5' shadow='1' color='#11C6F7'>" +  format['Sending request to %1',name _unit] +  "</t>";
  [_str,0,1,4,0,0,499] spawn BIS_fnc_dynamicText;
};

// CLIENT2: receives request, shows who sent it and then shows the command menu and awaits user input
FP_receiveTPQuery = {
  _requestingUnit = [_this,0,objNull] call BIS_fnc_param;
  if (isNull _requestingUnit) exitWith {["Received incorrect TP request (query)"] call BIS_fnc_error};
  if (isNil "FP_TP_busy") then {FP_TP_busy = false};
  if (FP_TP_busy) exitWith {[[player, 2],"FP_handleTPAnswer", _requestingUnit, false] spawn BIS_fnc_MP};
  FP_TP_busy = true;
  _str =  "<t font='TahomaB' size='0.5' shadow='1' color='#11C6F7'>" +  format['%1 is requesting to be teleported to you', name _requestingUnit] +  "</t>";
  [_str,0,1,6,0,0,499] spawn BIS_fnc_dynamicText;
  [_requestingUnit] spawn FP_handleTPWindow;
};

//CLIENT2: wait for user input in the commanding menu and send answer back to sender
FP_handleTPWindow = {
  params [["_requestingUnit", objNull]];
  if (isNull _requestingUnit) exitWith {["Received incorrect TP request (handleTPWindow)"] call BIS_fnc_error};
  _wait = time + 12;
  FP_tp_menuAccept = 2;
  showCommandingMenu "#USER:FP_query_TPMenu";
  sleep 2;
  waitUntil {commandingMenu  != "#USER:FP_query_TPMenu" || FP_tp_menuAccept in  [0,1] || _wait < time || !alive player};

  if (_wait < time || !alive player) then {showCommandingMenu ""};
  _selection = FP_tp_menuAccept;
  if (_wait < time) then {_selection = 4};
  if (!alive player) then {_selection = 3};
  [[player,_selection],"FP_handleTPAnswer",_requestingUnit,false] spawn BIS_fnc_MP;
  FP_TP_busy = false;
};

// CLIENT1: process the answer
FP_handleTPAnswer = {
  private ["_str"];
  _sender =  [_this,0,objNull] call BIS_fnc_param;
  _selection =  [_this,1,-1,[0]] call BIS_fnc_param;
  FP_TP_Req_Busy = false;
  if (isNull _sender || _selection == -1) exitWith {["Received incorrect information in TP message : %1 - %2",_sender,_selection] call BIS_fnc_error};
  _success = false;

  switch (_selection) do {
    case 0: {
      // unit declined
      _str = "<t font='TahomaB' size='0.5' shadow='1' color='#DE2A2A'>" +  format['%1 denied your request.',name _sender] +  "</t>";
    };
    case 1: {
      // unit accepted
      _str = "<t font='TahomaB' size='0.5' shadow='1' color='#11C6F7'>" +  format['Teleporting to %1',name _sender] +  "</t>";
      _success = true;
    };
    case 2: {
      // unit busy
      _str = "<t font='TahomaB' size='0.5' shadow='1' color='#FF9500'>" +  format['%1 is busy.',name _sender] +  "</t>";
    };
    case 3: {
      // unit dead
      _str = "<t font='TahomaB' size='0.5' shadow='1' color='#DE2A2A'>" +  format['%1 is dead.',name _sender] +  "</t>";
    };
    case 4: {
      // time out
      _str = "<t font='TahomaB' size='0.5' shadow='1' color='#FF9500'>" +  format['Your request to %1 timed out',name _sender] +  "</t>";
    };
    default {["Incorrect selection from sender (FP_TP)"] call BIS_fnc_error;};
  };

  [_str,0,1,4,0,0,499] spawn BIS_fnc_dynamicText;

  if (_success) then {
    [_sender] spawn {
      params ["_sender"];
      sleep 2;
      player setPosAtl (_sender modelToWorld [0,-1,0]);
      if (getPosATL player select 2 < 0) then {
        player setposATL [getposatl player select 0, getposatl player select 1,0];
      };
      sleep 1;
      _stuff = nearestObjects [player, ["All"], 100];
      {player reveal [_x,4]} forEach _stuff;
    };
  };
};
