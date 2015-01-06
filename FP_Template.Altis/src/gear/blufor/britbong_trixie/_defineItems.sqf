/*should be #include'd in all scripts. this will be "inserted" into those scripts*/

/*
---------------- NATO ----------------
Brit uniforms, Trixie l85/l86 + attachments, trixie HMG, STI CG.
*/

_UNIFORMS = ["U_B_CTRG_1", "U_B_CTRG_3", "U_B_CTRG_2"];
_VESTS = ["V_PlateCarrierH_CTRG", "V_PlateCarrierL_CTRG"];
_HEADGEARS = ["H_HelmetSpecB_blk", "H_HelmetSpecB_blk", "H_HelmetB", "H_HelmetB_black"];

_STANDARD_ITEMS = ["ItemMap","ItemCompass","ItemWatch","NVGoggles","ItemRadio"];

_STANDARD_RIFLE = "Trixie_l85a2";
_STANDARD_RIFLE_C = "Trixie_l85a2_nr";
_STANDARD_RIFLE_GL = "Trixie_l85a2_ugl";
_STANDARD_RIFLE_ASS = "Trixie_L86A2";

_STANDARD_MAG = "30Rnd_556x45_Stanag_Tracer_Green";
_STANDARD_MAG_T = "30Rnd_556x45_Stanag";

// Given to AR and Asst AR BP
_STANDARD_AR = "Trixie_L110A1";
_STANDARD_AR_MAG = "200Rnd_65x39_cased_Box";
_STANDARD_AR_MAG_T = "200Rnd_65x39_cased_Box_Tracer";

// Given to MAT and Asst MAT BP
_STANDARD_ROCKET_LAUNCHER = "STI_MAAWS";
_STANDARD_ROCKET1 = "STI_84MM_HEAT";
_STANDARD_ROCKET2 = "STI_84MM_HE";


// Must be arrays
_STANDARD_ATTACHMENTS = ["R3F_AIMPOINT"];
_LEADER_ATTACHMENTS =  ["acc_pointer_IR","Trixie_TA31F"];
_GL_SMOKES = ["1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell"];

_GL_HE = "1Rnd_HE_Grenade_shell";

_STANDARD_PISTOL = "hgun_P07_F";
_STANDARD_PISTOL_MAG = "16Rnd_9x21_Mag";

_GRENADE = "HandGrenade";
_STANDARD_SMOKE = "SmokeShellGreen";
_GPS = "ItemGPS";
_CHEMLIGHT = "Chemlight_green";

_LR_RADIO = ["tf_rt1523g","tf_mr3000","tf_anprc155", "tf_rt1523g"] select ([BLUFOR, OPFOR, independent, civilian] find side _unit);
