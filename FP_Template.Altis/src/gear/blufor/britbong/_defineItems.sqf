/*should be #include'd in all scripts. this will be "inserted" into those scripts*/

/*
---------------- NATO ----------------
Brit uniforms, l85
*/

_UNIFORMS = ["U_B_CTRG_1", "U_B_CTRG_3", "U_B_CTRG_2"];
_VESTS = ["V_PlateCarrierH_CTRG", "V_PlateCarrierL_CTRG"];
_HEADGEARS = ["H_HelmetSpecB_blk", "H_HelmetSpecB_blk", "H_HelmetB", "H_HelmetB_black"];

_STANDARD_ITEMS = ["ItemMap","ItemCompass","ItemWatch","NVGoggles","ItemRadio"];

_STANDARD_RIFLE = "CUP_arifle_L85A2";
_STANDARD_RIFLE_C = _STANDARD_RIFLE;
_STANDARD_RIFLE_GL = "CUP_arifle_L85A2_GL";
_STANDARD_RIFLE_ASS = _STANDARD_RIFLE;

_STANDARD_MAG = "CUP_30Rnd_556x45_Stanag";
_STANDARD_MAG_T = _STANDARD_MAG; // no tracers? damn cup

// Given to AR and Asst AR BP
_STANDARD_AR = "CUP_lmg_L110A1";
_STANDARD_AR_MAG = "CUP_200Rnd_TE4_Red_Tracer_556x45_L110A1";
_STANDARD_AR_MAG_T = "CUP_200Rnd_TE4_Red_Tracer_556x45_L110A1";

// Given to MAT and Asst MAT BP
_STANDARD_ROCKET_LAUNCHER = "CUP_launch_MAAWS";
_STANDARD_ROCKET1 = "CUP_MAAWS_HEAT_M";
_STANDARD_ROCKET2 = "CUP_MAAWS_HEDP_M";
// CUP_optic_MAAWS_Scope

// Must be arrays
_STANDARD_ATTACHMENTS = ["CUP_optic_TrijiconRx01_black"];

_LEADER_ATTACHMENTS =  ["acc_pointer_IR","CUP_optic_ACOG"];
_LEADER_ITEMS = ["ItemGPS", "AGM_MapTools"];

_GL_SMOKES = ["1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell"];
_GL_HE = "CUP_1Rnd_HEDP_M203";

_STANDARD_PISTOL = "hgun_P07_F";
_STANDARD_PISTOL_MAG = "16Rnd_9x21_Mag";

_GRENADE = "HandGrenade";
_STANDARD_SMOKE = "SmokeShellGreen";
_CHEMLIGHT = "Chemlight_green";

_LR_RADIO = ["tf_rt1523g","tf_mr3000","tf_anprc155", "tf_rt1523g"] select ([BLUFOR, OPFOR, independent, civilian] find side _unit);
