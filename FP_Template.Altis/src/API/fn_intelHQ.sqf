/*
///////////////////////////
	ARMA 3 function script
	Version: 0.1
	Author: Cuel
	Created: 2014-01-15
	Send broadcast message with some sounds
	@param {Object | Array} 
		- Sending unit or side e.g [WEST,"HQ"] or object name
	@param {Array}
		- Objects where sound should be played. Empty array defaults to template units.
	@param {String}
		- Message showed after "message in ten"
	[[WEST,"HQ"],[],"Message"] call FP_fnc_intelHQ
///////////////////////////
*/
_this spawn {
	_obj = [_this,0,objNull,[[],objNull],[2]] call BIS_fnc_param;
	if (typeName _obj == typeName objNull && {isNull _obj}) exitWith {
		["INTELHQ: faulty speaking object  : %1",_this] call BIS_fnc_error;
	};
	_speakers = [_this,1,[],[[]]] call BIS_fnc_param;
	if (count _speakers == 0) then {
		_speakers = ["actual","a0","b0","c0","d0","p1","crew1","crew2"];
	};
	_msg = [_this,2,"",[""]] call BIS_fnc_param;
	if (_msg == "") exitWith {
		["INTELHQ: Empty string for message! ",_this] call BIS_fnc_error;
	};
	private ["_temp","_unit"];
	[[_obj,"All units, be advised: Message in ten seconds.",_speakers,"fp_msg1"],"FP_fnc_local_intelHQ",true,false] call BIS_fnc_MP;
	sleep 16;
	[[_obj,_msg,_speakers,"fp_msg2"],"FP_fnc_local_intelHQ",true,false] call BIS_fnc_MP;

};