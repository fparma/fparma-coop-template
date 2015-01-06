// gives PLT same items as SQL
#include "SQL.sqf";
// but change the hat and uniform:)
_plt_items = uniformItems _unit;
removeUniform _unit;
_unit forceAddUnifrm "U_I_OfficerUniform";
{_unit addItemToUniform _x} foreach _plt_items;
_unit addHeadGear "H_MilCap_dgtl";

