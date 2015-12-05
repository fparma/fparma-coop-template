/*
	Function: FP_fnc_addNVG

	API:
		Any

	Description:
        Helper to add NVGs and not looking around for the class name
        values can be
        pvs14, pvs15, gen1, gen2, gen3, gen4, wide, blufor, opfor, indep

        NVG will be added on head if daytime is not between 0700 and 2000
        Otherwise in the inventory

	Parameters:
		_unit - Unit to add stuff to
        _kind - String of a matching value from above

	Examples:
	(begin example)
		[_unit, "wide"] call FP_fnc_addNVG;
	(end)

	Author:
	Cuel 2015-04-30
*/

#include "helpers.hpp";
params [
    ["_unit", objNull, [objNull]],
    ["_kind", [], [[], ""]]
];

if (IS_ARRAY(_kind)) then {_kind = _kind select 0};

private _add = {
    if !(daytime > 7 && daytime < 20) then {
        _unit linkItem _this;
    }else{
        // canAdd might report false when adding to inventory, but the nvg can still be added using linkItem?
        if (!(_unit canAdd _this)) then {
            _unit linkItem _this;
        }else{
            _unit addItem _this;
        };
    };
};

// eh,  allow to pass the real names aswell
if (_kind in ["rhsusf_ANPVS_14","rhsusf_ANPVS_15","ACE_NVG_Gen1","ACE_NVG_Gen2","ACE_NVG_Gen4","ACE_NVG_Wide","NVGoggles_OPFOR","NVGoggles","NVGoggles_INDEP"]) exitWith {
    _kind call _add;
};

switch _kind do {
    case "pvs14": {"rhsusf_ANPVS_14" call _add};
    case "pvs15": {"rhsusf_ANPVS_15" call _add};
    case "gen1": {"ACE_NVG_Gen1" call _add};
    case "gen2": {"ACE_NVG_Gen2" call _add};
    case "gen4": {"ACE_NVG_Gen4" call _add};
    case "wide": {"ACE_NVG_Wide" call _add};
    case "opfor": {"NVGoggles_OPFOR" call _add};
    case "blufor": {"NVGoggles" call _add};
    case "indep": {"NVGoggles_INDEP" call _add};
    default {if (!isNil "FP_gear_errs") then {FP_gear_errs pushBack format ["%1 - addNVG: Unknown NVG: %2",str _unit, _kind]}};
};
