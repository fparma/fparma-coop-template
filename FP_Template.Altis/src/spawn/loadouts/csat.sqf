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


_headgear = [
	'H_ShemagOpen_tan',
	'H_Cap_brn_SPECOPS',
	'H_MilCap_ocamo',
	'H_HelmetSpecO_ocamo',
	'H_Cap_brn_SPECOPS',
	'H_HelmetSpecO_ocamo',
	'H_Watchcap_blk',
	'H_HelmetLeaderO_ocamo'
	
];

_rifles = [
	'trixie_xm8_carbine',
	'hlc_rifle_ak12',
	'hlc_rifle_ak12',
	'hlc_rifle_ak12',
	'hlc_rifle_aek971',
	'hlc_rifle_aek971',
	'SMG_02_F',
	'srifle_DMR_01_F',
	'hlc_rifle_osw_GL',
	'R3F_Famas_surb_DES',
	'arifle_Katiba_C_F',
	'hlc_rifle_osw_GL'
];

_mgs = [
	'LMG_Zafir_F'
];

// sniper 'srifle_mas_svd',
// 'srifle_mas_m91',

// pistol
_pistols = [
	'RH_mp412'
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
				if (!isPlayer _unit) then {
			removeheadgear _unit;
			_unit addheadgear (_headgear call BIS_fnc_selectRandom);
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
		
		if (_weapon in ['SMG_02_F']) then {
			_unit addPrimaryWeaponItem "optic_aco_grn";
			_unit addbackpack "B_Carryall_ocamo";
			[_unit,"launch_O_Titan_F",2] call BIS_fnc_addWeapon;
		};
		
		if (_weapon in ['trixie_xm8_carbine']) then {
			_unit addPrimaryWeaponItem "Trixie_xm8dot";
		};
		
		if (_weapon in ['hlc_rifle_osw_GL']) then {
			_unit addPrimaryWeaponItem "Trixie_PEQ2";
			_unit addPrimaryWeaponItem "Trixie_xm8dot";
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