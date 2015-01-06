If a unit have this in its init:

[this,"SQL"] call FP_fnc_getKit

It will execute the file called fn_getKit.sqf in the folder where this file is.


Inside there, you can change the _GEAR variable to the path where you want units to get their loadouts from.

For example, consider the following:

_GEAR = "opfor\taki_caf_hlc";

That would mean that the unit will execute the file called "SQL.sqf" inside opfor\taki_caf_hlc folder.


If you want to create new loadouts, simply copy paste a folder for the correct side and edit the files 
to have the loadout that you want.

_defineItems.sqf is important and will define most items that units have. It is not required but needed if any file have 
#include "_defineItems.sqf" in it, or will cause a game crash.

"_after.sqf" should be included in the last line of loadout files and will provide common items for all units.