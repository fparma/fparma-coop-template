/*should be #include'd in all scripts. this will be "inserted" into those scripts*/

_UNIFORMS = ["Niko_USA_DesertMARPAT"];
_VESTS = ["Niko_USA_PlateCarrierL_CB"];
_HEADGEARS = ["Niko_MICH_DesertMarpat"];

_STANDARD_ITEMS = ["ItemMap","ItemCompass","ItemWatch","NVGoggles","ItemRadio"];

_STANDARD_RIFLE = "RH_M16A4";
_STANDARD_RIFLE_C = "RH_M4_ris";
_STANDARD_RIFLE_GL = "RH_M16A4gl";
_STANDARD_RIFLE_ASS = "RH_M16A4";

_STANDARD_MAG = "RH_30Rnd_556x45_M855A1";
_STANDARD_MAG_T = "30Rnd_556x45_Stanag_Tracer_Red";


// Given to SQLs and PLT; mostly headgear
_PLT_HEADGEAR = "H_Beret_red";
_SQL_HEADGEAR = "Niko_MICH_DesertMarpat";

// Given to AR and Asst AR BP
_STANDARD_AR = "RH_M27IAR";
_STANDARD_AR_MAG = "RH_60Rnd_556x45_M855A1";
_STANDARD_AR_MAG_T = "RH_60Rnd_556x45_M855A1";

// Given to MAT and Asst MAT BP
_STANDARD_ROCKET_LAUNCHER = "CUP_launch_Mk153Mod0";
_STANDARD_ROCKET1 = "CUP_SMAW_HEAA_M";
_STANDARD_ROCKET2 = "CUP_SMAW_HEDP_M";

// Must be arrays
_STANDARD_ATTACHMENTS = ["RH_m16covers_s","RH_compM2"];
_STANDARD_ATTACHMENTS_ALT = ["RH_peq15_top","RH_eotech553"];
_STANDARD_ATTACHMENTS_AR = ["RH_peq15_top","RH_t1"];
_LEADER_ATTACHMENTS =  ["RH_peq15_top"];
_LEADER_ITEMS = ["ItemGPS", "AGM_MapTools"];

_GL_SMOKES = ["1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell"];
_GL_HE = "1Rnd_HE_Grenade_shell";

_STANDARD_PISTOL = "RH_m1911";
_STANDARD_PISTOL_MAG = "RH_7Rnd_45cal_m1911";

_GRENADE = "HandGrenade";
_STANDARD_SMOKE = "SmokeShellGreen";
_CHEMLIGHT = "Chemlight_green";

_LR_RADIO = ["tf_rt1523g","tf_mr3000","tf_anprc155", "tf_rt1523g"] select ([BLUFOR, OPFOR, independent, civilian] find side _unit);
