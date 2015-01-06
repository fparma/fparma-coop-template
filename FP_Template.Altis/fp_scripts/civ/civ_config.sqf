/* Parameters */
_debug = false;

// Load settings (amount civilians)
_maximumCiviliansOverall = 30;
_maximumCiviliansPerPlayer = 5; // amount civs ONE player controls

// Maxiumum amount of meters away from player that we search for houses. Lower = better script performance
_searchHousesDistance = 500;

// If ANY player is closer than this distance, civilian cannot spawn
_playersTooCloseDistance = 150;

// If ANY "Man" object is closer than this distance, civilian cannot spawn
_otherCiviliansTooCloseDistance = 30;

// Seconds before TRYING to spawn a new civilian
_civSpawnDelay = 5;

// Clean up settings (meters)
_aliveCivDeleteDistance = 600;
_deadCivDeleteDistance = 200;

/* END Parameters */

/*Runs locally for every civ spawned*/
_civInitCode = {
	private "_unit";
	_unit = _this select 0;
	_unit setDamage 0;
	_unit setSkill 0;
	_unit setUnitPos "UP";
	{_unit disableAI _x} foreach ["TARGET","AUTOTARGET"];
	(group _unit) setSpeedMode "LIMITED";
	if (rain > 0.2) then {(group _unit setSpeedMode "NORMAL")};
	(group _unit) setBehaviour "SAFE";
	{_unit unlinkItem _x} foreach ["ItemMap","ItemCompass"];
	_unit addEventHandler ["Hit",{
		_whom = [_this,1,objNull,[objNull]] call BIS_fnc_param;
		if (isNull _whom) exitWith{}; 
		(group (_this select 0)) setSpeedMode "FULL";
	}];
	_unit addEventHandler ["Killed",{
		_killer = [_this,1,objNull] call BIS_fnc_param;
		if (!isNull _killer && {isPlayer _killer} && {faction _killer != faction (_this select 0)}) then {
			[[[_killer],{systemChat format ["%1 has killed an unarmed civilian",name (_this select 0)]}],"BIS_fnc_spawn",true,false] call BIS_fnc_MP;
		};
		(_this select 0) spawn {
			sleep 45;
			hideBody _this;
			sleep 15;
			_grp = group _this;
			deleteVehicle _this;
			if (count units _grp == 0) then {
				deleteGroup _grp;
			};
		};
	}];
};

/*NOT IMPLEMENTED AI CANT DRIVE Runs locally for every vehicle spawned*/
_vehicleInitCode = {
	private "_vehicle";
	_vehicle = _this select 0;
	_vehicle setSkill 0;
	clearItemCargoGlobal _vehicle;
	clearMagazineCargoGlobal _vehicle;
	clearWeaponCargoGlobal _vehicle;
	if (random 1 > 0.3) then {
		_vehicle lock 3;
	};
};

/* Name of TRIGGERS, where civilians cannot spawn nor move. Separated by commas.*/
_excludedTriggerAreas = 
[

];

/* House types that civilians cannot spawn inside */
_houseBlacklist = 
[
	"Land_d_Addon_02_V1_F",
	"Land_MilOffices_V1_F",
	"Land_Cargo_House_V1_F",
	"Land_Cargo_HQ_V1_F",
	"Land_Cargo_Patrol_V1_F",
	"Land_i_Barracks_V2_F",
	"Land_Research_HQ_F",
	"Land_Unfinished_Building_01_F",
	"Land_Radar_F",
	"Land_i_Shed_Ind_F",
	"Land_Factory_Main_F",
	"Land_dp_bigTank_F",
	"Land_d_Stone_Shed_V1_F",
	"Land_CarService_F",
	"Land_Hangar_F",
	"Land_i_Addon_04_V1_F",
	"Land_Cargo_Tower_V1_F",
	/* TAKI */
	"Land_vez",
	"Land_Mil_Barracks_i_EP1",
	"Land_Mil_ControlTower_EP1",
	"Land_Ind_Oil_Tower_EP1"
];

/* Civilians that can spawn*/
_allCivilians = 
[
	// AFR
	"C_man_p_beggar_F_afro","C_man_polo_1_F_afro","C_man_polo_2_F_afro","C_man_polo_3_F_afro","C_man_polo_4_F_afro","C_man_polo_5_F_afro","C_man_polo_6_F_afro","C_man_shorts_1_F_afro","C_man_p_fugitive_F_afro","C_man_p_shorts_1_F_afro","C_man_shorts_2_F_afro","C_man_shorts_3_F_afro","C_man_shorts_4_F_afro",
	// ASIAN
	"C_man_p_beggar_F_asia","C_man_polo_1_F_asia","C_man_polo_2_F_asia","C_man_polo_3_F_asia","C_man_polo_4_F_asia","C_man_polo_5_F_asia","C_man_polo_6_F_asia","C_man_shorts_1_F_asia","C_man_p_fugitive_F_asia","C_man_p_shorts_1_F_asia","C_man_shorts_2_F_asia","C_man_shorts_3_F_asia","C_man_shorts_4_F_asia",
	// EU
	"C_man_p_beggar_F_euro","C_man_polo_1_F_euro","C_man_polo_2_F_euro","C_man_polo_3_F_euro","C_man_polo_4_F_euro","C_man_polo_5_F_euro","C_man_polo_6_F_euro","C_man_shorts_1_F_euro","C_man_p_fugitive_F_euro","C_man_p_shorts_1_F_euro","C_man_shorts_2_F_euro","C_man_shorts_3_F_euro","C_man_shorts_4_F_euro",
	// Normal
	"C_man_p_beggar_F","C_man_1","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F","C_man_shorts_1_F","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_p_fugitive_F"
	// CAF TAKI
	//"CAF_AG_ME_CIV_03","CAF_AG_ME_CIV_04","CAF_AG_ME_CIV","CAF_AG_ME_CIV_02"
];


/*Not a setting , leave*/
private ["_createDebugMarker","_debugCounter"];
if (_debug) then {
	_debugCounter = 0;
	_createDebugMarker = {
		_obj = _this select 0;
		_marker = createMarkerLocal [format["c_%1_%2",_obj,random 100], _obj];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "mil_dot";
		_marker setMarkerSizeLocal [0.7,0.7];
		if (typeName _obj == typeName []) exitWith{};
		_marker setMarkerTextLocal " " + str _debugCounter;
		_clr = switch (true) do {
			case (_obj isKindOf "House"): {"ColorRed"};
			case (_obj isKindOf "Car"): {"ColorBlue"};
			case (_obj isKindOf "Man"): {"ColorGreen"};
			default{"ColorWhite"};
		};
		_marker setMarkerColorLocal _clr;
		if (_obj isKindOf "Man") then {
			[_obj,_marker,_debugCounter] spawn {
				private ["_unit","_arr"];
				_unit = _this select 0;
				_arr = [];
				while {alive _unit} do {
					(_this select 1) setMarkerPosLocal (getPosATL _unit);
					sleep 1;
					if (count waypoints group _unit > 0 && count _arr == 0) then 
					{
						{
							_m = createMarkerLocal [format["c_%1_%2",_unit,random 100], waypointPosition _x];
							_m setMarkerShapeLocal "ICON";
							_m setMarkerTypeLocal "mil_dot";
							_m setMarkerSizeLocal [0.5,0.5];
							_m setMarkerColorLocal "ColorYellow";
							_m setMarkerTextLocal  str (_this select 2)+":  " + str _forEachIndex;
							_arr = _arr + [_m];
						}foreach waypoints group _unit;
					} else {
						if (count waypoints group _unit == 0) then {
							{deleteMarkerLocal _x} foreach _arr;
							_arr = [];
						};
					};	
				};
				{deleteMarkerLocal _x} foreach _arr;
				(_this select 1) setMarkerColorLocal "ColorBlack";
			};
		};
	};
};