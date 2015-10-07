
// Respawn with gear, is set by fn_getKit
FP_kit_type = player getVariable ["FP_kit_type", []];

player addEventHandler ["Respawn", {

	// Add new unit to zeus
	[_this select 0] remoteExecCall ["FP_fnc_addCuratorObject", 2];

	// Respawn with gear if using template gear
	if (count FP_kit_type > 0) then {
		[_this select 0, FP_kit_type select 0, FP_kit_type select 1] call FP_fnc_getKit;
	};
}];

// Fix so player can't join "ENEMY" side
player addEventHandler ["HandleRating", {
	_rating = _this select 1;
	(abs _rating)
}];

// Delete grenades thrown in spawn
player addEventHandler ["Fired", {
	if (_this select 2 == "HandGrenadeMuzzle") then {
		local _side = [blufor, opfor, independent, civilian] find side player;
		local _mrk = markerPos (["respawn_west","respawn_east","respawn_guerrila","respawn_civilian"] select _side);
		if ((_this select 0) distance _mrk < 80) then {
			[_this select 6] call ace_frag_fnc_addBlackList;
			deleteVehicle (_this select 6);
			titleText ["G IS FOR GRENADES", "PLAIN", 2];
		};
	};
}];

// Lower weapon after mission start
[{
	if (primaryWeapon player != "") then {
		player switchMove "amovpercmstpslowwrfldnon";
	};
}, []] call ACE_common_fnc_execNextFrame;


// Replace ace markers temporarly to log them during briefing
if (time > 0) exitWith {};

// Normal markers
FP_ace_placeMarker = ACE_markers_fnc_placeMarker;
ACE_markers_fnc_placeMarker = {
	if (_this select 1 == 1) then {
		[[
			[
				player,
				missionNamespace getVariable ["ACE_markers_currentMarkerConfigName", ""],
				mapGridPosition (missionNamespace getVariable ["ACE_markers_currentMarkerPosition", []])
			],
			{
				systemChat format ["SERVER: %1 placed a '%2' marker at %3",
				name (_this select 0),
				if ((_this select 1) != "") then {getText (configFile >> "cfgMarkers" >> (_this select 1) >> "name")} else {""},
				if (playerSide == side (_this select 0)) then {_this select 2} else {"<redacted>"}]
			}
		], "BIS_fnc_spawn", true] call BIS_fnc_MP;
	};
	_this call FP_ace_placeMarker;
};

// Line markers
FP_ace_placeLineMarker = ACE_maptools_fnc_handleMouseButton;
ACE_maptools_fnc_handleMouseButton = {
	if (ACE_maptools_drawing_isDrawing) then {
		local _clr = ["black", "red", "green", "blue", "yellow", "white"]
			select (["ColorBlack", "ColorRed","ColorGreen","ColorBlue","ColorYellow","ColorWhite"]
			find (ACE_maptools_drawing_tempLineMarker) select 3));
		local _grid = mapGridPosition (ACE_maptools_drawing_tempLineMarker select 1);

		local _msg = format ["SERVER: %1 placed a %2 line at %3", name player, _clr, _grid];
		_msg remoteExecCall ["systemChat", side player];
	};
	_this call FP_ace_placeLineMarker;
};

[{
	ACE_markers_fnc_placeMarker = FP_ace_placeMarker;
	FP_ace_placeMarker = nil;

	ACE_maptools_fnc_handleMouseButton = FP_ace_placeLineMarker;
	FP_ace_placeLineMarker = nil;
}] call ACE_common_fnc_execNextFrame;
