/*
///////////////////////////
	ARMA 3 "data downloader" script
	Author: T-800a
	Edited by: Cuel 2013
	Created: 2013-10-15
	Purpose: Adds action to laptop and a nice little dialog when you use it. Takes about a minute to complete.
	Takes an array: [LAPTOP_OBJECT,"STRING_INFO" or ["INFO","INFO2"]]
	Example init:
	0 = [this,["INFO1","INFO2"]] execVM "fp_scripts\laptop.sqf";
	Returns : ID
///////////////////////////
*/

if (count _this in [1,2]) exitWith {
	private ["_id","_laptop"];
	// This runs from init (only one time)
	_laptop = [_this,0,objNull,[objNull]] call BIS_fnc_param;
	if (isNull _laptop) exitWith {["LAPTOP.SQF: Laptop does not exist! (%1)",_laptop] call BIS_fnc_error };
	_id = _laptop addAction ["<t color='#ff8a00'>\\ Download data //</t>", "fp_scripts\laptop.sqf",0, 9, false, true, "", "((_target getVariable ['fp_inUse',0]) != 1)"];
	_laptop allowDamage false;
	if (count _this == 2) then {
		// store info on the laptop and show it later
		_laptop setVariable ["fp_info",(_this select 1)];
	};
	_id
};

// This runs from action menu
private [ "_laptop","_size","_newFile", "_dlRate" ,"_exit","_percent","_speaker","_delay","_d","_state","_info","_finished"];
_laptop = [_this,0,objNull,[objNull]] call BIS_fnc_param;
if (isNull _laptop) exitWith {["LAPTOP.SQF: Laptop does not exist! (%1)",_laptop] call BIS_fnc_error };
_laptop setVariable ["fp_inUse",1,true];
T8_abort = false;

_size = 32645;
_exit = false;
_newFile = 0;
_speaker = createVehicle ["Land_HelipadEmpty_F",[0,0,0],[],0,"NONE"];
_speaker attachTo [_laptop,[0,0,0.5]];
_state = animationState player;
_delay = 0;
_finished = false;

createDialog "T8_DataDownloadDialog";
sleep 0.5;
ctrlSetText [ 8001, "Connecting" ];
_d = 0;
[[_speaker],"fp_modem"] call CBA_fnc_globalSay;
for "_i" from 0 to 24 do {
	if (T8_abort || !alive player  || (animationState player != _state))  exitWith {T8_abort = true};
	ctrlSetText [ 8001, format ["Connecting%1",([".","..","..."] select _d)]];
	_d = _d + 1;
	if (_d > 2) then {_d = 0};
	sleep 1;
};

if (!T8_abort) then 
{
	ctrlSetText [ 8001, "Connected:" ];		
	ctrlSetText [ 8003, format [ "%1 kb", _size ] ];		
	ctrlSetText [ 8004, format [ "%1 kb", _newFile ] ];		

	while { (!_finished && alive player && animationState player == _state) } do
	{
		if (time > _delay) then {
			[[_speaker],"fp_harddrive"]call CBA_fnc_globalSay;
			_delay = time + 6;
		};
		_dlRate = 200 + random 80;
		_newFile = _newFile + _dlRate;

		if ( _newFile > _size ) then {
			_finished = true;
			_dlRate = 0;		
			_newFile = _size;
			ctrlSetText [ 8001, "Download finished!" ];	
		};
		ctrlSetText [ 8002, format [ "%1 KB/s", _dlRate ] ];		
		_percent =  (_newFile/ _size);
		_percent = toArray str _percent; 
		_percent resize 4;
		{_percent set [_x,-1]} forEach [0,1]; 
		_percent = _percent - [-1];
		_percent resize 2;
		_percent = toString _percent ;
		ctrlSetText [ 8004, format [ "%1 kb (%2%3)", _newFile,if (_finished) then {100}else{_percent},"%"]];				
		sleep 0.2;
	};
};
if (!_finished) then {
	T8_abort = true;
};
deleteVehicle _speaker;
if (T8_abort) exitWith {
	if (dialog) then {closeDialog 0};
	_laptop setVariable ["fp_inUse",0,true];
	0 = 0 spawn {
		hint "Interrupted";
		sleep 5;
		hint "";
	};
};

// we have now downloaded the data!
sleep 3;
if (dialog) then {closeDialog 0};
_info =_laptop getVariable "fp_info";
if (!isNil "_info") then {
	private ["_str","_id"];
	player setVariable ["fp_amountIntel",(player getVariable ["fp_amountIntel",1]) +1 ];
	_str = "";
	if (typeName _info == typeName []) then 
	{
		{
			player sideChat str _x;
			_str = format ["%1 %2*%3",_str,"<br/><br/>",_x];
			sleep 3;
		}forEach _info;
	}else{
		player sideChat _info;
		_str = _info;
	};
	_id = player getVariable ["fp_amountIntel",0];
	player createDiaryRecord ["Diary",[("Laptop intel #" + str _id),_str]];
	hintSilent "Briefing note added with laptop intel";
	sleep 5;
	hintSilent "";
};
