/*
	Function: intelHQ
	
	Description: 
		Sends a message to a side, plays some sounds and uses sideChat.
		1: "Message in ten seconds" are played and shown.
		2: The actual message is shown with some sounds.
		This function should only be called from ONE client or server.

	Parameters:
		_obj - Unit or SIDE broadcasting the message. [Object, Array]
		_speakers - Units where sound will be played (e.g leaders). If empty array, template units will be used. Can be either object name or string (will be parsed). [Array]
		Good practice to use strings.

	Examples: 
	(begin example) 
		[[WEST,"HQ"],[],"Hello world"] call FP_fnc_intelHQ

		[player,["customUnit1", customUnit2],"Hello world"] call FP_fnc_intelHQ
	(end) 

	Returns:
	BOOL

	Author: 
	Cuel 2015-01-07
*/

_obj = [_this,0,objNull,[[],objNull],[2]] call BIS_fnc_param;
if (typeName _obj == typeName objNull && {isNull _obj}) exitWith {
	["faulty sender: %1",_this] call BIS_fnc_error;
};

_speakers = [_this,1,[],[[]]] call BIS_fnc_param;
if (count _speakers == 0) then {
	_speakers = ["actual","a0","b0","c0","d0","p1","crew1","crew2"];
};

_msg = [_this,2,"",[""]] call BIS_fnc_param;
if (_msg == "") exitWith {
	["Empty string for message! ",_this] call BIS_fnc_error;
};

[_obj, _speakers,_msg] spawn {
	_obj = _this select 0;
	_speakers = _this select 1;
	_msgInTen = "All units, be advised: Message in ten seconds.";
	_msg = _this select 2;

	[[_obj, _msgInTen, _speakers, "fp_msg1"],"FP_fnc_local_intelHQ",true] call BIS_fnc_MP;
	sleep 16;
	[[_obj,_msg,_speakers,"fp_msg2"],"FP_fnc_local_intelHQ",true] call BIS_fnc_MP;
};

true