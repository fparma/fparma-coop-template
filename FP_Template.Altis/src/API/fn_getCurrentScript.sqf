/*
///////////////////////////
	ARMA 3 function script
	Version: 0.1
	Author: Cuel
	Created: 2014-01-15
	@param {__FILE__}
	@return scriptfile executing this function
///////////////////////////
*/

private ["_scr","_index","_builder"];

_scr = toArray _this;

for "_i" from (count _scr)-1 to 0 step -1 do {
	if (_scr select _i == 47 || _scr select _i == 92) exitWith {
		_index = _i+1;
	};
};

_builder = [];
for "_i" from _index to (count _scr)-1 do  {
	_builder pushBack (_scr select _i);
};

_scr = toString _builder;

_scr