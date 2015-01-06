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
	'H_Hat_tan',
	'H_Hat_camo',
	'H_Hat_blue',
	'H_StrawHat',
	'H_Watchcap_blk',
	'H_ShemagOpen_khk',
	'H_Shemag_tan',
	'H_Bandanna_cbr',
	'H_Bandanna_surfer',
	'H_Cap_blk'
];

_vests = [
	'V_I_G_resistanceLeader_F',
	'V_TacVest_khk',
	'V_TacVest_darkblck',
	'V_Rangemaster_belt',
	'V_BandollierB_khk',
	'V_TacVest_darkblck',
	'V_BandollierB_blk',
	'V_TacVest_blk',
	'V_TacVest_camo',
	 'V_TacVest_darkblck'
];

_uniforms = [
	 'U_C_Poloshirt_blue',
	 'U_C_Poloshirt_burgundy',
	 'U_C_Poloshirt_tricolour',
	 'U_C_Poloshirt_salmon',
	 'U_Rangemaster',
	 'U_NikosBody',
	 'U_OrestesBody',
	 'U_IG_Guerilla1_1',
	 'U_IG_Guerilla2_1',
	 'U_IG_Guerilla2_2',
	 'U_IG_Guerilla2_3',
	 'U_IG_leader',
	 'U_BG_Guerilla1_1',
	 'U_BG_Guerilla2_2',
	 'U_BG_Guerilla2_3',
	 'U_BG_leader',
	 'U_I_G_Story_Protagonist_F',
	 'U_I_G_resistanceLeader_F'
 ];

_ldrUniforms = [
	'U_BG_Guerilla3_2',
	'U_OG_Guerilla3_1',
	'U_OG_Guerilla3_2',
	'U_C_HunterBody_grn'
];

_rifles = [
	'hlc_rifle_ak74',
	'hlc_rifle_ak74',
	'hlc_rifle_l1a1slr',
	'RH_M16A3',
	'RH_M16A3',
	'hlc_rifle_lar',
	'hlc_rifle_rpk',
	'hlc_rifle_stg58f',
	'hlc_rifle_aks74u',
	'hlc_rifle_g3a3'
];

_mgs = [
	'hlc_lmg_m60e4',
	'hlc_rifle_rpk'
];

// pistol
_pistols = [
	'rh_cz75'
];

_glasses = [
	'G_Sport_Red',
	'G_Sport_Checkered',
	'G_Sport_Blackyellow',
	'G_Squares',
	'G_Spectacles_Tinted'
];

_backpacks = [
	'B_Carryall_khk'
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
		removeUniform _unit;
		removeVest _unit;
		removeBackpack _unit;
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
		if (_unit == _leader) then {
			_unit addUniform (_ldrUniforms call BIS_fnc_selectRandom);
			_unit addBackpack (_backpacks call BIS_fnc_selectRandom);
		}else{
			_unit addUniform (_uniforms call BIS_fnc_selectRandom);
		};
		
		if (random 100 > 70 && !isPlayer _unit) then {
			_unit addGoggles (_glasses call BIS_fnc_selectRandom);
		};

		_weapon = _rifles call BIS_fnc_selectRandom;
		if (_unit == _mg) then {
			_weapon = _mgs call BIS_fnc_selectRandom;
		};

		if (_weapon in ['arifle_mas_akm_gl', 'arifle_mas_ak_74m_gl_c']) then {
			_unit addMagazines ["1Rnd_HE_Grenade_shell",2];
		};

		_magazines = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
		if (count _magazines > 1) then {
			{[_unit, (_magazines select 1)] call CBA_fnc_AddMagazine} count [0,1];
		};
		{[_unit,(_magazines select 0)] call CBA_fnc_AddMagazine;} count [0,1,2,3,4];
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