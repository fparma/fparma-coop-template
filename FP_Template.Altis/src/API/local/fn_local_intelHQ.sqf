/*
///////////////////////////
	ARMA 3 function script
	Version: 0.1
	Author: Cuel
	Created: 2014-01-15
	Send broadcast message with some sounds
	[SENDER,SPEAKERS,"Message"] call FP_fnc_intelHQ
	SENDER = [West,"HQ"]
	SPEAKERS = objects to play sou nd
	MESSAGE = message.
	 actions are added for join in progress players.
///////////////////////////
*/
_obj = [_this,0,objNull] call BIS_fnc_param;
_msg = [_this,1,"",[""]] call BIS_fnc_param;
_speakers = [_this,2,[]] call BIS_fnc_param;
_snd = [_this,3,""] call BIS_fnc_param;
if (count _speakers > 0 && _snd != "") then 
{
	private "_unit";
	{
		if (!isNil "_x") then {
			if (typeName _x == typeName objNull) then {
				_x say _snd;
			}else{
				_unit = missionNamespace getVariable [_x,objNull];
				_unit say _snd;
			};
		};
	}foreach _speakers;
};

_obj sideChat _msg;