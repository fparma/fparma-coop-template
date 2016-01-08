params ["_unit", "_kit"];
_kit = toUpper _kit;

// ==================
// Defines below. First, commmon stuff
// ==================
_COMMON_UNIFORMS = ["usm_bdu_w"];
_COMMON_VESTS = ["usm_vest_pasgt_lbv_rmp", "usm_vest_pasgt_lbe_rm"];
_COMMON_HEADGEARS = ["usm_helmet_pasgt_g_w", "usm_helmet_pasgt_w"];
_COMMON_BP = "B_TacticalPack_oli";

_COMMON_NVG = ""; // can be: pvs14, pvs15, gen1, gen2, gen3, gen4, wide, blufor, opfor, indep. check fn_addNVG.sqf
_COMMON_ITEMS = ["ACRE_PRC343", ["SmokeShellGreen", 2], ["HandGrenade", 2], "ItemMap","ItemCompass","ItemWatch", ["ACE_fieldDressing", 2], "ACE_Morphine"];

_COMMON_RIFLE = "hlc_rifle_M16A4";
_COMMON_RIFLE_ATTACHMENTS = ["RH_LTdocter"];
_COMMON_MAG = "30Rnd_556x45_Stanag";
_COMMON_MAG_T = "30Rnd_556x45_Stanag_Tracer_Red";

_COMMON_RIFLE_C = "hlc_rifle_CQBR";
_COMMON_RIFLE_C_ATTACHMENTS = "RH_cmore";
_COMMON_MAG_C = _COMMON_MAG;
_COMMON_MAG_C_T = _COMMON_MAG_T;

_COMMON_RIFLE_GL = "RH_M4A1_ris_M203s";
_COMMON_RIFLE_GL_ATTACHMENTS = _COMMON_RIFLE_ATTACHMENTS;
_COMMON_GL_NADES = [["1Rnd_HE_Grenade_shell", 4], ["1Rnd_Smoke_Grenade_shell", 2]];
_COMMON_MAG_GL = _COMMON_MAG;
_COMMON_MAG_GL_T = _COMMON_MAG_T;

_COMMON_AR = "CUP_lmg_m249_SQuantoon";
_COMMON_AR_ATTACHMENTS = ["RH_compM2l", "RH_TD_ACB_g", "CUP_acc_Flashlight"];
_COMMON_AR_MAG = "CUP_100Rnd_TE4_Red_Tracer_556x45_M249";
_COMMON_AR_MAG_T = "CUP_100Rnd_TE4_Red_Tracer_556x45_M249";

_COMMON_AT = "CUP_launch_MAAWS";
_COMMON_AT_MAG_HE = "CUP_MAAWS_HEDP_M";
_COMMON_AT_MAG_AP = "CUP_MAAWS_HEAT_M";
_COMMON_AT_RAT = "CUP_launch_M136"; // assumed disposable

_COMMON_PISTOL = "RH_m1911";
_COMMON_PISTOL_MAG = "RH_7Rnd_45cal_m1911";

// ==================
// PLT AND SQL stuff
// ==================
_PLT_HEADGEAR = "usm_bdu_8point_erdl";
_SQL_HEADGEAR = "usm_helmet_pasgt_g_w";
_SQL_BINOC = "binoc"; // can be binoc, soflam, lerca_b (black), lerca_t (tan), laser, laser_blufor, laser_opfor, laser_indep. check fn_addOptic.sqf
_SQL_ATTACHMENTS = ["RH_eotech553mag", "RH_SFM952V"];
_SQL_VEST = "usm_vest_rba_lbe_rmp";
_SQL_UNIFORM = _COMMON_UNIFORMS;
_SQL_ITEMS = [
  "ACRE_PRC148",
  "ACE_HuntIR_monitor",
  "ACE_microDAGR",
  "ACE_MapTools",
  "1Rnd_SmokeRed_Grenade_shell",
  "1Rnd_SmokeGreen_Grenade_shell",
  ["Chemlight_green", 2],
  ["UGL_FlareRed_F", 2],
  ["ACE_HuntIR_M203", 2]
];
_SQL_BP = "usm_pack_st138_prc77";

// ==================
// Medic stuff
// ==================
_MED_HEADGEAR = _COMMON_HEADGEARS;
_MED_VEST = _COMMON_VESTS;
_MED_BP = "usm_pack_m5_medic";
_MED_BP_ITEMS = [
    ["ACE_fieldDressing",16],
    ["ACE_morphine",12],
    ["ACE_epinephrine",12],
    ["ACE_bloodIV",4]
];

// ==================
// Crew stuff
// ==================
_CREW_HEADGEAR = "usm_helmet_cvc";
_CREW_UNIFORM = _COMMON_UNIFORMS;
_CREW_VEST = "usm_vest_rba";
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
_ENGI_BP = "usm_pack_alice";
_ENGI_ITEMS = ["ACE_Clacker", "ACE_DefusalKit"];
_ENGI_BP_ITEMS = [["ToolKit", 1], ["SatchelCharge_Remote_Mag", 1], ["DemoCharge_Remote_Mag", 2]];

// ==================
// Assign the stuff
// ==================


switch _kit do {

    case "PLT"; // fall through to SQL
    case "SQL": {
        private _h = if (_kit == "PLT") then {_PLT_HEADGEAR} else {_SQL_HEADGEAR};

        [_unit, [_SQL_UNIFORM, _SQL_VEST, _h, _SQL_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG_GL, 7], [_COMMON_MAG_GL_T, 4], _COMMON_GL_NADES]] call FP_fnc_addToContainers;

        if (_kit == "PLT") then {
          [_unit, "usm_helmet_pasgt_g_w", "backpack"] call FP_fnc_addToContainers;
        };

        [_unit, [_COMMON_RIFLE_GL, _SQL_ATTACHMENTS]] call FP_fnc_addWeapon;

        [_unit, _SQL_ITEMS] call FP_fnc_addToContainers;
        [_unit, _SQL_BINOC] call FP_fnc_addOptic;

    };

    case "MEDIC": {
        [_unit, [_COMMON_UNIFORMS, _MED_VEST, _MED_HEADGEAR, _MED_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG_C, 6], [_COMMON_MAG_C_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE_C, _COMMON_RIFLE_C_ATTACHMENTS]] call FP_fnc_addWeapon;

        [_unit, _MED_BP_ITEMS, "backpack"] call FP_fnc_addToContainers;

    };

    case "RIFLEMAN": {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG, 6], [_COMMON_MAG_T, 4]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;
    };

    case "AR": {
        [_unit, [_COMMON_UNIFORMS, "usm_vest_pasgt_lbv_mg", _COMMON_HEADGEARS, "usm_pack_762x51_ammobelts"]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_AR_MAG, 2], [_COMMON_AR_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_AR, _COMMON_AR_ATTACHMENTS]] call FP_fnc_addWeapon;

    };

    case "ARASS": {
        [_unit, [_COMMON_UNIFORMS, "usm_vest_pasgt_lbv_mg", _COMMON_HEADGEARS, "usm_pack_762x51_bandoliers"]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG, 6], [_COMMON_MAG_T, 4]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;

        [_unit, [["CUP_100Rnd_TE4_Red_Tracer_556x45_M249", 3]], "backpack"] call FP_fnc_addToContainers;

    };

    case "AT": {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS, _COMMON_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_AT_MAG_HE, 1], [_COMMON_AT_MAG_AP, 1]], "backpack"]  call FP_fnc_addToContainers;

        [_unit, [[_COMMON_MAG, 6], [_COMMON_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;
        [_unit, _COMMON_AT] call FP_fnc_addWeapon;
        _unit addSecondaryWeaponItem "CUP_optic_MAAWS_Scope";

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

    case "MARKSMAN": {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS]] call FP_fnc_addContainers;
        [_unit, [["hlc_5rnd_300WM_FMJ_AWM", 6]]] call FP_fnc_addToContainers;
        [_unit, ["hlc_rifle_awmagnum", "CUP_optic_LeupoldM3LR"]] call FP_fnc_addWeapon;
    };

    case "GL": {
        [_unit, [_COMMON_UNIFORMS, "usm_vest_pasgt_lbv_gr", _COMMON_HEADGEARS]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG_GL, 8], [_COMMON_MAG_GL_T, 2], _COMMON_GL_NADES]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE_GL, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;

    };
    case "ENGINEER": {
        [_unit, [_COMMON_UNIFORMS, _COMMON_VESTS, _COMMON_HEADGEARS, _ENGI_BP]] call FP_fnc_addContainers;
        [_unit, [[_COMMON_MAG, 6], [_COMMON_MAG_T, 2]]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;

        [_unit, _ENGI_ITEMS] call FP_fnc_addToContainers;
        [_unit, _ENGI_BP_ITEMS]  call FP_fnc_addToContainers;
        if (str _unit == "engi1") then {
          _unit addItem "ACRE_PRC148";
        };
    };

    case "PILOT": {
        [_unit, [_PILOT_UNIFORM, _PILOT_VEST, _PILOT_HEADGEAR]] call FP_fnc_addContainers;
        [_unit, _PILOT_MAGS] call FP_fnc_addToContainers;
        [_unit, _PILOT_WEAPON] call FP_fnc_addWeapon;

    };
    case "CREW": {
        [_unit, [_CREW_UNIFORM, _CREW_VEST, _CREW_HEADGEAR]] call FP_fnc_addContainers;
        [_unit, _CREW_MAGS] call FP_fnc_addToContainers;
        [_unit, _CREW_WEAPON, _COMMON_RIFLE_C_ATTACHMENTS] call FP_fnc_addWeapon;
    };

    default {if (!isNil "FP_gear_errs") then {FP_gear_errs pushBack format ["%1 - NOT FOUND KIT: %2", str _unit, _kit]}};
};

// ==================
// Runs for everyone
// ==================
if (_kit != "CREW") then {
  [_unit, _COMMON_ITEMS] call FP_fnc_addToContainers;

  if (_kit != "AT") then {
      [_unit, [_COMMON_PISTOL_MAG, 2]] call FP_fnc_addToContainers;
      [_unit, _COMMON_PISTOL] call FP_fnc_addWeapon;
  };
} else {
  [_unit, ["ACRE_PRC343", "ACE_fieldDressing", "ACE_fieldDressing", "ACE_Morphine", "ACE_Flashlight_MX991", "ItemMap","ItemCompass","ItemWatch", "ItemGPS"]] call FP_fnc_addToContainers;
};
