/*
	Function: FP_fnc_addContainers

	API:
		Any

	Description:
        Adds uniform, vest, head and backapck to a unit
        Can pass strings or array of strings, if array a random will be selected
        Elements that you do not wish to change can be passed as nil.

	Parameters:
		_unit - Unit to add stuff to
        _elems - An array of strings or arrays of strings
        _clearBP - Clear backpack (default true)

	Examples:
	(begin example)
		[_unit, ["uniform1"]] call FP_fnc_addContainers;

        [_unit, ["uniform1", "vest", "headgear", "backpack"], false] call FP_fnc_addContainers; // dont clear bp

        [_unit, [["uniform1", "uniform2", ["uniform3", "uniform4"]], nil, nil, "backpack1"]] call FP_fnc_addContainers;
        // ^ 33% to get any of the uniforms, if the array, they have an equal 50% chance to be selected
	(end)

	Author:
	Cuel 2015-04-30
*/

#define IS_VALID(X) (!isNil {(X)} && {count (X) > 0})
params [
    ["_unit", objNull, [objNull]],
    ["_elems", [], [[]]],
    ["_clearBP", true, [true]]
];
_elems params [["_uniform", ""],["_vest", ""],["_headgear", ""],["_backpack", ""]];
private _single = {while {_this isEqualType []} do {_this = selectRandom _this}; _this};

if (IS_VALID(_uniform)) then {
    _unit forceAddUniform (_uniform call _single);
};

if (IS_VALID(_vest)) then {
    _unit addVest (_vest call _single);
};

if (IS_VALID(_headgear)) then {
    _unit addHeadgear (_headgear call _single);
};

if (IS_VALID(_backpack)) then {
    _unit addBackpack (_backpack call _single);
    if (_clearBP) then {clearAllItemsFromBackpack _unit};
};
