/*
///////////////////////////
	ARMA 3 Group equipment script
	Version: 0.1
	Author: Cuel
	Created: 2014-01-18
	Purpose: Equips a group with specific loadout.
	@param {Group} - Group to equip with loadout
	Example:
	0 = [group player] execVM "src\spawn\loadouts\guer.sqf"
///////////////////////////
*/

_group = [_this,0,grpNull,[grpNull]] call BIS_fnc_param;

if (isNull _group) exitWith {
	["Incorrect group for guer loadout"] call BIS_fnc_error;
};

_rifles = [
	'RH_M4_ris_M203',
	'RH_M16A4',
	'RH_M16A4_m'
];

_mgs = [
	'STI_M249'
];

// sniper 'srifle_mas_svd',
// 'srifle_mas_m91',

// pistol
_pistols = [
	'RH_fnp45'
];


_leader = leader _group;
_mg = ((units _group) call BIS_fnc_selectRandom);

if (!isDedicated) then {
	waitUntil {!isNull player};
};

for "_i" from 0 to (count units _group)-1 do {
	_unit = (units _group) select _i;
	if (local _unit) then {
		removeAllWeapons _unit;
		{_unit removeMagazine _x} foreach (magazines _unit);
		if (!isPlayer _unit) then {
			removeGoggles _unit;
		};

		if (_unit == _mg) then {
			_weapon = _mgs call BIS_fnc_selectRandom;
		};
		{
			_unit unassignItem _x;
			_unit removeItem _x;
		} foreach (assignedItems _unit);
		_weapon = _rifles call BIS_fnc_selectRandom;
		[_unit, _weapon,10] call BIS_fnc_addWeapon;
		if (random 1 > 0.5) then {
			_unit addMagazine "HandGrenade";
		};
		
		if (_weapon in ['RH_M16A4']) then {
			_unit addPrimaryWeaponItem "optic_aco";
			_unit addPrimaryWeaponItem "RH_qdss_nt4b";
			_unit addbackpack "B_Carryall_ocamo";
			[_unit,"launch_B_Titan_F",2] call BIS_fnc_addWeapon;
		};
		
		if (_weapon in ['RH_M16A4']) then {
			_unit addPrimaryWeaponItem "optic_hamr";
			_unit addPrimaryWeaponItem "RH_qdss_nt4b";
		};
		
		if (_weapon in ['RH_M4_ris_M203']) then {
			_unit addPrimaryWeaponItem "acc_pointer_ir";
			_unit addPrimaryWeaponItem "RH_qdss_nt4b";
			_unit addPrimaryWeaponItem "optic_holosight";
			_unit addMagazines ["1Rnd_HE_Grenade_shell",8];
		};
	
		if (_weapon in ['RH_M16A4_m']) then {
			_unit addPrimaryWeaponItem "acc_pointer_ir";
			_unit addPrimaryWeaponItem "RH_qdss_nt4b";
			_unit addPrimaryWeaponItem "optic_holosight";
			_unit addMagazines ["1Rnd_HE_Grenade_shell",8];
		};
	
		if (_weapon in ['R3F_Famas_surb_DES']) then {
			_unit addPrimaryWeaponItem "R3F_FELIN_DES";
		};
		
		if (_weapon in ['hlc_rifle_aek971']) then {
			_unit addPrimaryWeaponItem "hlc_optic_kobra";
		};
		
		if (_weapon in ['srifle_DMR_01_F']) then {
			_unit addPrimaryWeaponItem "optic_DMS";
		};
		
		
		if (_weapon in ['arifle_Katiba_C_F']) then {
			_unit addPrimaryWeaponItem "optic_aco_grn";
			_unit addBackpack "B_FieldPack_ocamo";
			[_unit,"launch_RPG32_F",3] call BIS_fnc_addWeapon;
		};
		
		 [_unit, (_pistols call BIS_fnc_selectRandom)] call CBA_fnc_addWeapon;
		_pistolammo = getArray (configFile / "CfgWeapons" / (handgunWeapon _unit) / "magazines");
		{[_unit, (_pistolammo call BIS_fnc_selectRandom)] call CBA_fnc_AddMagazine}count [0,1];
		{
				_unit linkItem _x;
		}forEach ["ItemMap","ItemCompass","ItemWatch"];
	};
};

true