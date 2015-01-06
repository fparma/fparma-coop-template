/*should be #include'd in all scripts. this will be "inserted" into those scripts*/

/*
---------------- NATO ----------------
	HK416, FAMAS (SQL), HLC SAW, STI AT
*/

_UNIFORMS = ["U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest","U_B_CombatUniform_mcam"];
_VESTS = ["V_PlateCarrierGL_rgr","V_Chestrig_khk","V_PlateCarrier2_rgr","V_Chestrig_khk","V_TacVest_khk","V_PlateCarrier3_rgr"];
_HEADGEARS = ["H_HelmetB_paint", "H_HelmetB_light","H_HelmetB_light_desert", "H_HelmetB_light_sand","H_HelmetB_camo", "H_HelmetB_desert" ,"H_HelmetB_grass"];

_STANDARD_ITEMS = ["ItemMap","ItemCompass","ItemWatch","NVGoggles","ItemRadio"];

_STANDARD_RIFLE = "R3F_HK416M";
_STANDARD_RIFLE_C = "R3F_HK416M_HG";
_STANDARD_RIFLE_GL = "R3F_Famas_surb_M203";
_STANDARD_RIFLE_ASS = _STANDARD_RIFLE;

_STANDARD_MAG = "R3F_30Rnd_556x45_HK416";
_STANDARD_MAG_T = "R3F_30Rnd_556x45_TRACER_HK416";

// Given to AR and Asst AR BP
_STANDARD_AR = "hlc_lmg_m249pip";
_STANDARD_AR_MAG = "hlc_200rnd_556x45_M_SAW";
_STANDARD_AR_MAG_T = "hlc_200rnd_556x45_T_SAW";

// Given to MAT and Asst MAT BP
_STANDARD_ROCKET_LAUNCHER = "STI_MAAWS";
_STANDARD_ROCKET1 = "STI_84MM_HEAT";
_STANDARD_ROCKET2 = "STI_84MM_HE";

// Must be arrays
_STANDARD_ATTACHMENTS = ["R3F_EOTECH"];
_LEADER_ATTACHMENTS = ["acc_pointer_IR","R3F_J4"];
_GL_SMOKES = ["1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell"];

_GL_HE = "1Rnd_HE_Grenade_shell";

_STANDARD_PISTOL = "hgun_P07_F";
_STANDARD_PISTOL_MAG = "16Rnd_9x21_Mag";

_GRENADE = "HandGrenade";
_STANDARD_SMOKE = "SmokeShellGreen";
_GPS = "ItemGPS";
_CHEMLIGHT = "Chemlight_green";

_LR_RADIO = ["tf_rt1523g","tf_mr3000","tf_anprc155", "tf_rt1523g"] select ([BLUFOR, OPFOR, independent, civilian] find side _unit);