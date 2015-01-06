private ["_veh","_name"];
_veh = _this select 0;
_veh lock 0;
_veh disableTIEquipment true;

if (count _this > 1) then {
	_name = _this select 1;
	if (typeName (_this select 1) == "OBJECT") then {
		if (!isNull (_this select 1)) then {
			_oldveh = _this select 1;
			_name =  _oldveh getVariable ["fp_name","Vehicle"];
			_varName= format ["VEH%1",round random 1000];
			_oldveh setVehicleVarName _VarName;
			_oldveh call compile format ["%1=_this ; publicVariable ""%1""",_varName];
			deleteVehicle _oldveh;
		};
	};
		_veh addAction (call compile format ['["<t color=""#ffa500"">[ %1 ]</t>","",0, 100, true, true,"","_this distance _target < 6 && vehicle player == player"]', _name]);
		_veh setVariable ["fp_name",_name];
		if (!isNil "REPAIR_PAD") then {
			_veh addAction ["<t color=""#1111ff"">[ Repair vehicle ]</t>","src\x_reload.sqf",0, 100, true, true,"","(vehicle player == _target && (driver vehicle player == player)) && _target distance REPAIR_PAD <  6 && isTouchingGround _target"];
		};		
};

if (!isServer) exitWith {};
clearMagazineCargoGlobal _veh;
clearWeaponCargoGlobal _veh;
clearItemCargoGlobal _veh;
clearBackpackCargoGlobal _veh;
if (typeOf _veh == "C_Offroad_01_F") exitWith {};

/*
_veh addMagazineCargoGlobal ["30Rnd_65x39_caseless_mag_Tracer",10];
_veh addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag_Tracer",3];
_veh addMagazineCargoGlobal ["100Rnd_65x39_caseless_mag",2];
_veh addMagazineCargoGlobal ["SmokeShellGreen",6];
_veh addMagazineCargoGlobal ["HandGrenade",4];
_veh addItemCargoGlobal ["FirstAidKit",4];
_veh addMagazineCargoGlobal ["16Rnd_9x21_Mag",10];
*/