/*
	Function: FP_fnc_intelHQ

	API:
		Any

	Description:
		Sends a message to a side, plays some sounds and uses sideChat.
		1: "Message in ten seconds" are played and shown.
		2: The actual message is shown with some sounds.
		This function should only be called from ONE client or server.

	Parameters:
		_obj - Unit or SIDE broadcasting the message. [Object, Array]
		_speakers - Units where sound will be played (e.g leaders). If empty array, template units will be used. Array of strings. [Array]

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
	false
};

_actualSpeakers = [];
if (count _speakers > 0) then {
	private "_unit";
	{
		if (!isNil "_x" && {!isNull(missionNamespace getVariable [_x,objNull])}) then {
			_actualSpeakers pushBack (missionNamespace getVariable _x);
		};
	}foreach _speakers;
};

[_obj, _actualSpeakers, _msg] spawn {
	_obj = _this select 0;
	_speakers = _this select 1;
	_msgInTen = "All units, be advised: Message in ten seconds.";
	_msg = _this select 2;

	[[[_obj, _msgInTen], {(_this select 0) sideChat (_this select 1)}],"BIS_fnc_spawn",true] call BIS_fnc_MP;
	[_speakers, "fp_msg1"] call CBA_fnc_globalSay;
	sleep 16;
	[[[_obj, _msg], {(_this select 0) sideChat (_this select 1)}],"BIS_fnc_spawn",true] call BIS_fnc_MP;
	[_speakers, "fp_msg2"] call CBA_fnc_globalSay;
};

true
