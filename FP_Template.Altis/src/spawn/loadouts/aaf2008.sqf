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
	'H_Shemag_olive_hs',
	'H_Bandanna_khk_hs',
	'AAF_D_Cap_B',
	'AAF_D_Boonie_B',
	'AAF_D_Cap_Headphones_b',
	'AAF_D_Helmet_IA',
	'AAF_D_Helmet_IA',
	'AAF_D_Helmet_IA',
	'AAF_D_Helmet_IA',
	'AAF_D_Helmet_IA'
	
];

_vests = [
	'AAF_D_PlateCarrier_IA1',
	'AAF_D_PlateCarrier_IA2',
	'AAF_D_PlateCarrier_IAGL',
	'V_PlateCarrierIA1_dgtl',
	'V_PlateCarrierIA1_dgtl',
	'V_PlateCarrierIA2_dgtl',
	'V_PlateCarrierIA2_dgtl',
	'V_PlateCarrierIAGL_dgtl',
	'V_PlateCarrierIAGL_dgtl'
];

_rifles = [
	'hlc_rifle_g3sg1',
	'hlc_rifle_c1a1',
	'hlc_rifle_l1a1slr',
	'hlc_rifle_lar',
	'hlc_rifle_lar',
	'hlc_rifle_lar',
	'hlc_rifle_osw_gl',
	'hlc_rifle_stg58f',
	'hlc_rifle_g3a3',
	'hlc_rifle_g3a3'
];

_mgs = [
	'hlc_lmg_m60e4'
];

// sniper 'srifle_mas_svd',
// 'srifle_mas_m91',

// pistol
_pistols = [
	'rh_cz75'
];

_glasses = [
	'G_Balaclava_blk',
	'G_balaclava_combat',
	'G_balaclava_oli',
	'G_balaclava_lowprofile',
	'G_bandanna_blk',
	'G_bandanna_khk',
	'G_bandanna_oli',
	'G_bandanna_tan'
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
		removeHeadGear _unit;
		if (!isPlayer _unit) then {
			removeGoggles _unit;
		};
		{
			_unit unassignItem _x;
			_unit removeItem _x;
		} foreach (assignedItems _unit);

		if (random 100 > 10) then {
			_unit addHeadgear (_headgear call BIS_fnc_selectRandom);
		};
		if (random 100 > 20 && (_unit != _leader)) then {
			_unit addVest (_vests call BIS_fnc_selectRandom);
		};
		
		if (random 100 > 70 && !isPlayer _unit) then {
			_unit addGoggles (_glasses call BIS_fnc_selectRandom);
		};

		_weapon = _rifles call BIS_fnc_selectRandom;
		if (_unit == _mg) then {
			_weapon = _mgs call BIS_fnc_selectRandom;
		};

		if (_weapon in ['hlc_rifle_osw_gl']) then {
			_unit addMagazines ["1Rnd_HE_Grenade_shell",2];
		};
		if (_weapon in ['hlc_rifle_g3a3']) then {
			_unit addBackpack "B_assaultpack_dgtl";
			_unit addMagazine "R3F_AT4CS_mag";
			_unit addWeapon "R3F_AT4CS";
		};
		_magazines = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
		if (count _magazines > 1) then {
			{[_unit, (_magazines select 1)] call CBA_fnc_AddMagazine} count [0,1];
		};
		{[_unit,(_magazines select 1)] call CBA_fnc_AddMagazine;} count [0,1,2,3,4];
		[_unit, _weapon] call CBA_fnc_addWeapon;
			[_unit, "SmokeShell"] call CBA_fnc_AddMagazine;
		if (random 1 > 0.5) then {
			[_unit, "HandGrenade"] call CBA_fnc_AddMagazine;
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