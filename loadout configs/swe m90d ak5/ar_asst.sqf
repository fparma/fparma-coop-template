#include "rifleman.sqf"

_unit addBackpack "B_Kitbag_rgr";
clearAllItemsFromBackpack _unit;
{_unit addItemToBackpack "hlc_200rnd_556x45_M_SAW"} count [1,2,3,4];
