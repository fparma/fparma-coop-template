private ["_unit", "_kit"];
_unit = _this select 0;
_kit = _this select 1;

// ==================
// Defines below. First, commmon stuff
// ==================

_COMMON_UNIFORMS = ["U_BG_Guerrilla_6_1","U_BG_Guerilla2_3"];
_COMMON_VESTS = ["rhs_6b23_ML_6sh92", "rhs_6b23_ML_rifleman"];
_COMMON_HEADGEARS = ["rhs_6b27m_green","rhs_6b27m_green_bala","rhs_6b27m_green_ess"];
_COMMON_BP = "rhs_sidor";

_COMMON_ITEMS = [["HandGrenade", 2], ["SmokeShellGreen", 2], "ItemMap","ItemCompass","ItemWatch", "ItemRadio", ["ACE_fieldDressing", 2], "ACE_Morphine"];

_COMMON_RIFLE = ["hlc_rifle_ak74", "hlc_rifle_ak74_dirty"];
_COMMON_RIFLE_ATTACHMENTS = [];
_COMMON_MAG = "hlc_30Rnd_545x39_B_AK";
_COMMON_MAG_T = "hlc_30Rnd_545x39_t_ak";

_COMMON_RIFLE_C = _COMMON_RIFLE;
_COMMON_RIFLE_C_ATTACHMENTS = _COMMON_RIFLE_ATTACHMENTS;
_COMMON_MAG_C = _COMMON_MAG;
_COMMON_MAG_C_T = _COMMON_MAG_T;

_COMMON_RIFLE_GL = "hlc_rifle_ak12GL";
_COMMON_RIFLE_GL_ATTACHMENTS = _COMMON_RIFLE_ATTACHMENTS;
_COMMON_GL_NADES = [["hlc_VOG25_AK", 4], "hlc_GRD_White","hlc_GRD_White", "hlc_GRD_Red"];
_COMMON_MAG_GL = _COMMON_MAG;
_COMMON_MAG_GL_T = _COMMON_MAG_T;

_COMMON_AR = "rhs_weap_pkm";
_COMMON_AR_ATTACHMENTS = _COMMON_RIFLE_ATTACHMENTS;
_COMMON_AR_MAG = "rhs_100Rnd_762x54mmR";
_COMMON_AR_MAG_T = "rhs_100Rnd_762x54mmR_green";

_COMMON_AT = "rhs_weap_rpg7";
_COMMON_AT_MAG_HE = "rhs_rpg7_PG7VL_mag";
_COMMON_AT_MAG_AP = "rhs_rpg7_PG7VR_mag";
_COMMON_AT_RAT = "rhs_weap_rshg2"; // assumed disposable

_COMMON_PISTOL = "RH_mak";
_COMMON_PISTOL_MAG = "RH_8Rnd_9x18_Mak";


// ==================
// PLT AND SQL stuff
// ==================
_SQL_BINOC = "binoc"; // can be binoc, soflam, lerca_b (black), lerca_t (tan), laser, laser_blufor, laser_opfor, laser_indep. check fn_addOptic.sqf
_SQL_ATTACHMENTS = [];
_SQL_HEADGEAR = "rhs_6b27m_green_ess_bala";
_PLT_HEADGEAR = "rhs_6b27m_green_ess_bala";
_SQL_VEST = "rhs_6b23_ML_6sh92_vog_headset";
_SQL_UNIFORM = "U_BG_leader";
_SQL_ITEMS = ["ACE_microDAGR", "ACE_MapTools"];
_SQL_BP = "tf_anarc164";

// ==================
// Medic stuff
// ==================
_MED_HEADGEAR = _COMMON_HEADGEARS;
_MED_VEST = "rhs_6b23_medic";
_MED_BP = _COMMON_BP;
_MED_BP_ITEMS = [
    ["ACE_fieldDressing",16],
    ["ACE_morphine",12],
    ["ACE_epinephrine",12],
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
_ENGI_BP_ITEMS = [["SatchelCharge_Remote_Mag", 1], ["DemoCharge_Remote_Mag", 2]];



// ==================
// Assign the stuff
// ==================
switch _kit do {

    case "PLT"; // fall through to SQL
    case "SQL":
    {
        private "_h";
        _h = [_SQL_HEADGEAR, _PLT_HEADGEAR] select ((["SQL", "PLT"] find _kit) min 0);

        [_unit, [_SQL_UNIFORM, _SQL_VEST, _h, _SQL_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG_GL, 6], [_COMMON_MAG_GL_T, 4], _COMMON_GL_NADES]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE_GL, _SQL_ATTACHMENTS]] call FP_fnc_addWeapon;

        [_unit, _SQL_BINOC] call FP_fnc_addOptic;
        [_unit, _SQL_ITEMS] call FP_fnc_addToContainers;

    };

    case "MEDIC":
    {
        [_unit, [_COMMON_UNIFORMS, _MED_VEST, _MED_HEADGEAR, _MED_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG_C, 6], [_COMMON_MAG_C_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE_C, _COMMON_RIFLE_C_ATTACHMENTS]] call FP_fnc_addWeapon;

        [_unit, _MED_BP_ITEMS, "backpack"] call FP_fnc_addToContainers;

    };
    case "RIFLEMAN":
    {
        [_unit, [_COMMON_UNIFORMS, _MED_VEST, _MED_HEADGEAR, _MED_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG, 6], [_COMMON_MAG_T, 4]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;
    };

    case "AR":
    {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS, _COMMON_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_AR_MAG, 2], [_COMMON_AR_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_AR, _COMMON_AR_ATTACHMENTS]] call FP_fnc_addWeapon;

    };

    case "ARASS":
    {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS, _COMMON_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG, 2], [_COMMON_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;

        [_unit, [[_COMMON_AR_MAG, 1], [_COMMON_AR_MAG_T, 2]], "backpack"] call FP_fnc_addToContainers;

    };

    case "AT":
    {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS, "CUP_B_RPGPack_Khaki"]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_AT_MAG_HE, 1], [_COMMON_AT_MAG_AP, 2]], "backpack"]  call FP_fnc_addToContainers;

        [_unit, [[_COMMON_MAG, 6], [_COMMON_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;
        [_unit, _COMMON_AT] call FP_fnc_addWeapon;

    };

    case "ATASS":
    {

        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS, "CUP_B_RPGPack_Khaki"]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_AT_MAG_HE, 1], [_COMMON_AT_MAG_AP, 2]], "backpack"]  call FP_fnc_addToContainers;

        [_unit, [[_COMMON_MAG, 8], [_COMMON_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;
    };

    case "RAT":
    {

        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS, _COMMON_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG, 6], [_COMMON_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;

        [_unit, _COMMON_AT_RAT] call FP_fnc_addWeapon;

    };

    case "GL":
    {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG_GL, 9], [_COMMON_MAG_GL_T, 2], _COMMON_GL_NADES]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE_GL, _COMMON_RIFLE_GL_ATTACHMENTS]] call FP_fnc_addWeapon;

    };
    case "ENGINEER":
    {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS, _ENGI_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG, 6], [_COMMON_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;

        [_unit, _ENGI_BP_ITEMS]  call FP_fnc_addToContainers;
    };

    case "PILOT":
    {
        [_unit, [_PILOT_UNIFORM, _PILOT_VEST, _PILOT_HEADGEAR]] call FP_fnc_addContainers;
        [_unit, _PILOT_MAGS] call FP_fnc_addToContainers;
        [_unit, _PILOT_WEAPON] call FP_fnc_addWeapon;

    };
    case "CREWMAN":
    {
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

[_unit, [_COMMON_PISTOL_MAG, 2]] call FP_fnc_addToContainers;
[_unit, _COMMON_PISTOL] call FP_fnc_addWeapon;
