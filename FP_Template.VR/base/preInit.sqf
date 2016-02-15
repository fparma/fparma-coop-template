/*
	General FP init. Should not be edited
*/

[] call compile preprocessFileLineNumbers "config.sqf";
FP_cachedGroups = [] call CBA_fnc_hashCreate;

enableSaving [false,false];
enableCamShake true;
setViewDistance FP_VD;
setObjectViewDistance FP_OVD;
setTerrainGrid 25;
