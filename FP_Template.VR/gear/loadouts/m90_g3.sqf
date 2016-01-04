private ["_unit", "_kit"];
_unit = _this select 0;
_kit = _this select 1;

// ==================
// Defines below. First, commmon stuff
// ==================
_COMMON_UNIFORMS = ["FP_Uniform_M90"];
_COMMON_VESTS = ["V_Chestrig_oli", "V_I_G_resistanceLeader_F", "CUP_V_B_RRV_Scout2", "CUP_V_B_RRV_Scout"];
_COMMON_HEADGEARS = ["FP_Helmet_M90"];
_COMMON_BP = "CUP_B_ACRPara_m95"; // CUP_B_ACRScout_m95

_COMMON_NVG = ""; // can be: pvs14, pvs15, gen1, gen2, gen3, gen4, wide, blufor, opfor, indep. check fn_addNVG.sqf
_COMMON_ITEMS = ["ACRE_PRC343", ["HandGrenade", 2], ["SmokeShellGreen", 2], "ItemMap","ItemCompass","ItemWatch", ["ACE_fieldDressing", 2], "ACE_Morphine"];

_COMMON_RIFLE = "hlc_rifle_g3ka4";
_COMMON_RIFLE_ATTACHMENTS = ["RH_compm4s"];
_COMMON_MAG = "hlc_20rnd_762x51_b_G3";
_COMMON_MAG_T = "hlc_20rnd_762x51_T_G3";

_COMMON_RIFLE_C = _COMMON_RIFLE;
_COMMON_RIFLE_C_ATTACHMENTS = _COMMON_RIFLE_ATTACHMENTS;
_COMMON_MAG_C = _COMMON_MAG;
_COMMON_MAG_C_T = _COMMON_MAG_T;

_COMMON_RIFLE_GL = "HLC_Rifle_g3ka4_GL";
_COMMON_RIFLE_GL_ATTACHMENTS = _COMMON_RIFLE_ATTACHMENTS;
_COMMON_GL_NADES = [["1Rnd_HE_Grenade_shell",4], ["1Rnd_SmokeRed_Grenade_shell", 2], ["1Rnd_SmokeGreen_Grenade_shell", 2]];
_COMMON_MAG_GL = _COMMON_MAG;
_COMMON_MAG_GL_T = _COMMON_MAG_T;

_COMMON_AR = "hlc_lmg_minimipara";
_COMMON_AR_ATTACHMENTS = _COMMON_RIFLE_ATTACHMENTS;
_COMMON_AR_MAG = "hlc_200rnd_556x45_B_SAW";
_COMMON_AR_MAG_T = "hlc_200rnd_556x45_T_SAW";

_COMMON_AT = "CUP_launch_MAAWS";
_COMMON_AT_MAG_HE = "CUP_MAAWS_HEDP_M";
_COMMON_AT_MAG_AP = "CUP_MAAWS_HEAT_M";
_COMMON_AT_RAT = "CUP_launch_M136"; // assumed disposable

_COMMON_PISTOL = "RH_mak";
_COMMON_PISTOL_MAG = "RH_8Rnd_9x18_Mak";

// ==================
// PLT AND SQL stuff
// ==================
_SQL_BINOC = "laser"; // can be binoc, soflam, lerca_b (black), lerca_t (tan), laser, laser_blufor, laser_opfor, laser_indep. check fn_addOptic.sqf
_SQL_ATTACHMENTS = _COMMON_RIFLE_GL_ATTACHMENTS;
_SQL_HEADGEAR = "H_Beret_blk";
_PLT_HEADGEAR = "H_Beret_Colonel";
_SQL_VEST = "CUP_V_B_RRV_Officer";
_SQL_UNIFORM = _COMMON_UNIFORMS;
_SQL_ITEMS = ["ACRE_PRC148","ACE_microDAGR", "ACE_MapTools"];

// ==================
// Medic stuff
// ==================
_MED_HEADGEAR = _COMMON_HEADGEARS;
_MED_VEST = _COMMON_VESTS;
_MED_BP = "B_TacticalPack_rgr";
_MED_BP_ITEMS = [
    ["ACE_fieldDressing",20],
    ["ACE_morphine",16],
    ["ACE_epinephrine",16],
    ["ACE_bloodIV",4]
];

// ==================
// Crew stuff
// ==================
_CREW_HEADGEAR = _COMMON_HEADGEARS;
_CREW_UNIFORM = _COMMON_UNIFORMS;
_CREW_VEST = _COMMON_VESTS;
_CREW_WEAPON = _COMMON_RIFLE_C;
_CREW_MAGS = [_COMMON_MAG_C, 3];

// ==================
// Pilot stuff
// ==================
_PILOT_HEADGEAR = _COMMON_HEADGEARS;
_PILOT_UNIFORM = _COMMON_UNIFORMS;
_PILOT_VEST = _COMMON_VESTS;
_PILOT_WEAPON = _COMMON_RIFLE_C;
_PILOT_MAGS = [_COMMON_MAG_C, 2];

// ==================
// Engineer stuff
// ==================
_ENGI_BP = _COMMON_BP;
_ENGI_ITEMS = ["ACE_Clacker", "ACE_DefusalKit"];
_ENGI_BP_ITEMS = [["SatchelCharge_Remote_Mag", 2], ["DemoCharge_Remote_Mag", 2]];

// ==================
// Assign the stuff
// ==================
switch (toUpper _kit) do {

    case "PLT"; // fall through to SQL
    case "SQL": {
        private _h = _SQL_HEADGEAR;
        if (_kit == "PLT") then {_h = _PLT_HEADGEAR};

        [_unit, [_SQL_UNIFORM, _SQL_VEST, _h, _COMMON_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG_GL, 7], [_COMMON_MAG_GL_T, 4], _COMMON_GL_NADES]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE_GL, _SQL_ATTACHMENTS]] call FP_fnc_addWeapon;

        [_unit, _SQL_BINOC] call FP_fnc_addOptic;
        [_unit, _SQL_ITEMS] call FP_fnc_addToContainers;

    };

    case "MEDIC": {
        [_unit, [_COMMON_UNIFORMS, _MED_VEST, _MED_HEADGEAR, _MED_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG_C, 6], [_COMMON_MAG_C_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE_C, _COMMON_RIFLE_C_ATTACHMENTS]] call FP_fnc_addWeapon;

        [_unit, _MED_BP_ITEMS, "backpack"] call FP_fnc_addToContainers;

    };
    case "MM": {
        [_unit, [_COMMON_UNIFORMS, _MED_VEST, _MED_HEADGEAR, _COMMON_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG, 6], [_COMMON_MAG_T, 4]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, "ACE_optic_SOS_2D"]] call FP_fnc_addWeapon;

        [_unit, [_COMMON_MAG, 6], "backpack"] call FP_fnc_addToContainers;
    };

    case "AR": {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS]] call FP_fnc_addContainers;
        [_unit, [_COMMON_AR_MAG, 1]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_AR, _COMMON_AR_ATTACHMENTS]] call FP_fnc_addWeapon;
        [_unit, [_COMMON_AR_MAG, 1]] call FP_fnc_addToContainers;
    };

    case "ARASS": {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS, _COMMON_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG, 2], [_COMMON_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;

        [_unit, [[_COMMON_AR_MAG, 2], [_COMMON_AR_MAG_T, 2]], "backpack"] call FP_fnc_addToContainers;

    };

    case "AT": {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS, _COMMON_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_AT_MAG_HE, 1], [_COMMON_AT_MAG_AP, 2]], "backpack"]  call FP_fnc_addToContainers;

        [_unit, [[_COMMON_MAG, 6], [_COMMON_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;
        [_unit, _COMMON_AT] call FP_fnc_addWeapon;

    };

    case "ATASS": {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS, _COMMON_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_AT_MAG_HE, 1], [_COMMON_AT_MAG_AP, 2]], "backpack"]  call FP_fnc_addToContainers;

        [_unit, [[_COMMON_MAG, 8], [_COMMON_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;
    };

    case "RAT": {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG, 6], [_COMMON_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;

        [_unit, _COMMON_AT_RAT] call FP_fnc_addWeapon;

    };

    case "FTL": {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG, 6], [_COMMON_MAG_T, 5], "ACRE_PRC148"]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;
    };

    case "GL": {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG_GL, 7], [_COMMON_MAG_GL_T, 2], _COMMON_GL_NADES]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE_GL, _COMMON_RIFLE_GL_ATTACHMENTS]] call FP_fnc_addWeapon;

    };

    case "ENGINEER": {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS, _ENGI_BP]] call FP_fnc_addContainers;
        [_unit, _ENGI_BP_ITEMS, "backpack"]  call FP_fnc_addToContainers;

        [_unit, [[_COMMON_MAG, 6], [_COMMON_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;
    };

    case "PILOT": {
        [_unit, [_PILOT_UNIFORM, _PILOT_VEST, _PILOT_HEADGEAR]] call FP_fnc_addContainers;
        [_unit, _PILOT_MAGS] call FP_fnc_addToContainers;
        [_unit, _PILOT_WEAPON] call FP_fnc_addWeapon;

    };
    case "CREWMAN": {
        [_unit, [_CREW_UNIFORM, _CREW_VEST, _CREW_HEADGEAR]] call FP_fnc_addContainers;
        [_unit, _CREW_MAGS] call FP_fnc_addToContainers;
        [_unit, _CREW_WEAPON] call FP_fnc_addWeapon;
    };

    default {if (!isNil "FP_gear_errs") then {FP_gear_errs pushBack format ["%1 - NOT FOUND KIT: %2", str _unit, _kit]}};
};

// ==================
// Runs for everyone
// ==================
[_unit, _COMMON_ITEMS] call FP_fnc_addToContainers;

_i = if (_kit in ["AR"]) then {1} else {2};
[_unit, [_COMMON_PISTOL_MAG, _i]] call FP_fnc_addToContainers;
[_unit, _COMMON_PISTOL] call FP_fnc_addWeapon;
