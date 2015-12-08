
// Respawn with gear, is set by fn_getKit
FP_kit_type = player getVariable ["FP_kit_type", []];

player addEventHandler ["Respawn", {

	// Add new unit to zeus
	[_this select 0] remoteExecCall ["FP_fnc_addToCurators", 2];

	// Respawn with gear if using template gear
	if (count FP_kit_type > 0) then {
		[_this select 0, FP_kit_type select 0, FP_kit_type select 1] call FP_fnc_getKit;
	};
}];

// Fix so player can't join "ENEMY" side
player addEventHandler ["HandleRating", {
    abs (_this select 1);
}];

// Delete grenades thrown in spawn
player addEventHandler ["Fired", {
	if (_this select 2 == "HandGrenadeMuzzle") then {
		private _proj = param [6, objNull];
		private _idx = [blufor, opfor, independent, civilian] find side player;
		private _mrk = markerPos (["respawn_west","respawn_east","respawn_guerrila","respawn_civilian"] select _idx);
		if ((_this select 0) distance _mrk < 80) then {
			[_proj] call ace_frag_fnc_addBlackList;
			deleteVehicle _proj;
			titleText ["G IS FOR GRENADES", "PLAIN", 2];
		};
	};
}];

// Custom ares funcs
if (!isNil "Ares_fnc_RegisterCustomModule") then {
	[] call compile preprocessFileLineNumbers "base\scripts\ares.sqf";
};

// Lower weapon after mission start
if (primaryWeapon player != "") then {
	[{
		player switchMove "amovpercmstpslowwrfldnon";
	}, []] call ACE_common_fnc_execNextFrame;
};

// Longer view distance for pilots
if (player in ([FP_pilots, false, true] call ACE_common_fnc_parseList)) then {
	[] call compile preProcessFileLineNumbers "base\scripts\dynamic_vd.sqf";
};

[] call FP_fnc_coldStart;

// monkey patch ace markers temporarly to show messages during briefing
if (time > 0) exitWith {};

FP_ace_placeMarker = ACE_markers_fnc_placeMarker;
ACE_markers_fnc_placeMarker = {
	if (_this select 1 == 1) then {
		private _mrkName = missionNamespace getVariable ["ACE_markers_currentMarkerConfigName", ""];
		private _grid = mapGridPosition (missionNamespace getVariable ["ACE_markers_currentMarkerPosition", []]);
		private _msg = format ["SERVER: %1 placed a '%2' marker at %3", name player, _mrkName, _grid];
		_msg remoteExecCall ["systemChat", side player];
	};
	_this call FP_ace_placeMarker;
};

// Line markers
FP_ace_placeLineMarker = ACE_maptools_fnc_handleMouseButton;
ACE_maptools_fnc_handleMouseButton = {
	if (ACE_maptools_drawing_isDrawing) then {
		private _clr = ["black", "red", "green", "blue", "yellow", "white"]
			select (["ColorBlack", "ColorRed","ColorGreen","ColorBlue","ColorYellow","ColorWhite"]
			find (ACE_maptools_drawing_tempLineMarker) select 3);
		private _grid = mapGridPosition (ACE_maptools_drawing_tempLineMarker select 1);
		private _msg = format ["SERVER: %1 placed a %2 line at %3", name player, _clr, _grid];
		_msg remoteExecCall ["systemChat", side player];
	};
	_this call FP_ace_placeLineMarker;
};

[{
	ACE_markers_fnc_placeMarker = FP_ace_placeMarker;
	FP_ace_placeMarker = nil;

	ACE_maptools_fnc_handleMouseButton = FP_ace_placeLineMarker;
	FP_ace_placeLineMarker = nil;
}, []] call ACE_common_fnc_execNextFrame;
