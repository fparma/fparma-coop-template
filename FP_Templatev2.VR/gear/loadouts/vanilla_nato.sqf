private ["_unit", "_kit"];
_unit = _this select 0;
_kit = _this select 1;

// ==================
// Defines below. First, commmon stuff
// ==================
_COMMON_UNIFORMS = ["U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest","U_B_CombatUniform_mcam"];
_COMMON_VESTS = ["V_Chestrig_khk","V_PlateCarrier2_rgr","V_Chestrig_khk","V_TacVest_khk","V_PlateCarrier3_rgr"];
_COMMON_HEADGEARS = ["H_HelmetB_paint", "H_HelmetB_light","H_HelmetB_light_desert", "H_HelmetB_light_sand","H_HelmetB_camo", "H_HelmetB_desert" ,"H_HelmetB_grass"];
_COMMON_BP = "B_Bergen_mcamo";

_COMMON_NVG = "blufor"; // check fn_addNVG.sqf
_COMMON_ITEMS = [["HandGrenade", 2], ["SmokeShellGreen", 2], "ItemMap","ItemCompass","ItemWatch", "ItemRadio", "ACE_fieldDressing","ACE_fieldDressing", "ACE_Morphine"];

_COMMON_RIFLE = "arifle_MX_F";
_COMMON_RIFLE_ATTACHMENTS = ["optic_Aco"];
_COMMON_MAG = "30Rnd_65x39_caseless_mag";
_COMMON_MAG_T = "30Rnd_65x39_caseless_mag_Tracer";

_COMMON_RIFLE_C = "arifle_MXC_F";
_COMMON_RIFLE_C_ATTACHMENTS = _COMMON_RIFLE_ATTACHMENTS;
_COMMON_MAG_C = _COMMON_MAG;
_COMMON_MAG_C_T = _COMMON_MAG_T;

_COMMON_RIFLE_GL = "arifle_MX_GL_ACO_F";
_COMMON_RIFLE_GL_ATTACHMENTS = _COMMON_RIFLE_ATTACHMENTS;
_COMMON_GL_NADES = [["1Rnd_HE_Grenade_shell", 4], ["1Rnd_SmokeOrange_Grenade_shell", 2], ["1Rnd_SmokeGreen_Grenade_shell", 2]];
_COMMON_MAG_GL = _COMMON_MAG;
_COMMON_MAG_GL_T = _COMMON_MAG_T;

_COMMON_AR = "arifle_MX_SW_pointer_F";
_COMMON_AR_ATTACHMENTS = _COMMON_RIFLE_ATTACHMENTS;
_COMMON_AR_MAG = "100Rnd_65x39_caseless_mag";
_COMMON_AR_MAG_T = "100Rnd_65x39_caseless_mag_Tracer";

_COMMON_AT = "launch_B_Titan_short_F";
_COMMON_AT_MAG_HE = "Titan_AT";
_COMMON_AT_MAG_AP = "Titan_AP";
_COMMON_AT_RAT = "launch_NLAW_F"; // assumed disposable. otherwise also add a rocket

_COMMON_PISTOL = "hgun_P07_F";
_COMMON_PISTOL_MAG = "16Rnd_9x21_Mag";

// ==================
// PLT AND SQL stuff
// ==================
_SQL_BINOC = "laser_blufor"; // check fn_addOptic.sqf
_SQL_ATTACHMENTS = ["acc_pointer_IR","optic_Arco"];
_SQL_HEADGEAR = "H_Beret_red";
_PLT_HEADGEAR = "H_MilCap_mcamo";
_SQL_VEST = "V_PlateCarrierGL_rgr";
_SQL_UNIFORM = _COMMON_UNIFORMS;
_SQL_ITEMS = ["ACE_microDAGR", "ACE_MapTools"];
_SQL_BP = ["tf_rt1523g","tf_mr3000","tf_anprc155", "tf_rt1523g"] select ([BLUFOR, OPFOR, independent, civilian] find side _unit);

// ==================
// Medic stuff
// ==================
_MED_HEADGEAR = _COMMON_HEADGEARS;
_MED_VEST = "V_TacVestIR_blk";
_MED_BP = "B_Kitbag_mcamo";
_MED_BP_ITEMS = [
    ["ACE_fieldDressing",16],
    ["ACE_morphine",12],
    ["ACE_epinephrine",12],
    ["ACE_bloodIV",4]
];

// ==================
// Crew stuff
// ==================
_CREW_HEADGEAR = "H_HelmetCrew_B";
_CREW_UNIFORM = _COMMON_UNIFORMS;
_CREW_VEST = "V_BandollierB_rgr";
_CREW_WEAPON = _COMMON_RIFLE_C;
_CREW_MAGS = [_COMMON_MAG_C, 3];

// ==================
// Pilot stuff
// ==================
_PILOT_HEADGEAR = "H_PilotHelmetFighter_B";
_PILOT_UNIFORM = "U_B_PilotCoveralls";
_PILOT_VEST = "V_TacVest_blk";
_PILOT_WEAPON = _COMMON_RIFLE_C;
_PILOT_MAGS = [_COMMON_MAG_C, 2];

// ==================
// Engineer stuff
// ==================
_ENGI_BP = "B_Carryall_mcamo";
_ENGI_ITEMS = ["ACE_Clacker", "ACE_DefusalKit"];
_ENGI_BP_ITEMS = [["ToolKit", 1], ["SatchelCharge_Remote_Mag", 1], ["DemoCharge_Remote_Mag", 2]];


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
        [_unit, [[_COMMON_MAG_GL, 7], [_COMMON_MAG_GL_T, 4], _COMMON_GL_NADES]] call FP_fnc_addToContainers;
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
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_AR_MAG, 2], [_COMMON_AR_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_AR, _COMMON_AR_ATTACHMENTS]] call FP_fnc_addWeapon;

    };

    case "ARASS":
    {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS, _COMMON_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG, 2], [_COMMON_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;

        [_unit, [[_COMMON_AR_MAG, 2], [_COMMON_AR_MAG_T, 2]], "backpack"] call FP_fnc_addToContainers;

    };

    case "AT":
    {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS, _COMMON_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_AT_MAG_HE, 1], [_COMMON_AT_MAG_AP, 1]], "backpack"]  call FP_fnc_addToContainers;

        [_unit, [[_COMMON_MAG, 6], [_COMMON_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;
        [_unit, _COMMON_AT] call FP_fnc_addWeapon;

    };

    case "ATASS":
    {

        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS, _COMMON_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_AT_MAG_HE, 1], [_COMMON_AT_MAG_AP, 2]], "backpack"]  call FP_fnc_addToContainers;

        [_unit, [[_COMMON_MAG, 8], [_COMMON_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;
    };

    case "RAT":
    {

        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG, 6], [_COMMON_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;

        [_unit, _COMMON_AT_RAT] call _addWeapon;

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

[_unit, _COMMON_NVG] call FP_fnc_addNVG;
