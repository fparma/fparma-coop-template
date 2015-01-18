/*should be #include'd in all scripts. this will be "inserted" into those scripts*/

/*
---------------- NATO ----------------
RH M4/M16, HLC mg, trixie SMAW
*/

_UNIFORMS = ["U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest","U_B_CombatUniform_mcam"];
_VESTS = ["V_PlateCarrierGL_rgr","V_Chestrig_khk","V_PlateCarrier2_rgr","V_Chestrig_khk","V_TacVest_khk","V_PlateCarrier3_rgr"];
_HEADGEARS = ["H_HelmetB_paint", "H_HelmetB_light","H_HelmetB_light_desert", "H_HelmetB_light_sand","H_HelmetB_camo", "H_HelmetB_desert" ,"H_HelmetB_grass"];

_STANDARD_ITEMS = ["ItemMap","ItemCompass","ItemWatch","NVGoggles","ItemRadio"];

_STANDARD_RIFLE = "RH_M16A4";
_STANDARD_RIFLE_C = "RH_M4_ris";
_STANDARD_RIFLE_GL = "RH_M4_ris_M203";
_STANDARD_RIFLE_ASS = "RH_M16A4_m";

_STANDARD_MAG = "30Rnd_556x45_Stanag";
_STANDARD_MAG_T = "30Rnd_556x45_STANAG_Tracer_red";

// Given to AR and Asst AR BP
_STANDARD_AR = "hlc_lmg_m249pip";
_STANDARD_AR_MAG = "hlc_200rnd_556x45_M_SAW";
_STANDARD_AR_MAG_T = "hlc_200rnd_556x45_T_SAW";

// Given to MAT and Asst MAT BP
_STANDARD_ROCKET_LAUNCHER = "CUP_launch_MAAWS";
_STANDARD_ROCKET1 = "CUP_MAAWS_HEAT_M";
_STANDARD_ROCKET2 = "CUP_MAAWS_HEDP_M";

// Must be arrays
_STANDARD_ATTACHMENTS = ["RH_compm4s","RH_m16covers_f"];

_LEADER_ATTACHMENTS = ["RH_m4covers_s","RH_ta31rco_2D"];
_LEADER_ITEMS = ["ItemGPS", "AGM_MapTools"];

_GL_SMOKES = ["1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell"];
_GL_HE = "1Rnd_HE_Grenade_shell";

_STANDARD_PISTOL = "RH_m9";
_STANDARD_PISTOL_MAG = "RH_15Rnd_9x19_M9";

_GRENADE = "HandGrenade";
_STANDARD_SMOKE = "SmokeShellGreen";
_CHEMLIGHT = "Chemlight_green";

_LR_RADIO = ["tf_rt1523g","tf_mr3000","tf_anprc155", "tf_rt1523g"] select ([BLUFOR, OPFOR, independent, civilian] find side _unit);
