/*
	Function: FP_fnc_getCurrentScript
	
	Description: 
		Returns the script name of the file executing this function.

	Parameters:
		__FILE__ - C Macro containing the whole path to a file.

	Examples: 
	(begin example) 
		// From another script
		__FILE__ call FP_fnc_getCurrentScript
	(end) 

	Returns:
	String - name of file

	Author: 
	Cuel 2015-01-07
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