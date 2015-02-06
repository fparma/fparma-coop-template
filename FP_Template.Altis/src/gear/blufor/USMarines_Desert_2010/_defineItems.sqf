/*should be #include'd in all scripts. this will be "inserted" into those scripts*/

_UNIFORMS = ["Niko_USA_DesertMARPAT"];
_VESTS = ["Niko_USA_PlateCarrierL_CB"];
_HEADGEARS = ["Niko_MICH_DesertMarpat"];

_STANDARD_ITEMS = ["ItemMap","ItemCompass","ItemWatch","NVGoggles","ItemRadio"];

_STANDARD_RIFLE = "rhs_weap_m16a4_carryhandle";
_STANDARD_RIFLE_C = "rhs_weap_m4_grip";
_STANDARD_RIFLE_GL = "rhs_m4_m320";
_STANDARD_RIFLE_ASS = "rhs_weap_m16a4_grip";

_STANDARD_MAG = "30rnd_556x45_STANAG";
_STANDARD_MAG_T = "30Rnd_556x45_Stanag_Tracer_Red";

// Given to AR and Asst AR BP
_STANDARD_AR = "rhs_weap_m249_pip";
_STANDARD_AR_MAG = "rhsusf_100Rnd_556x45_soft_pouch";
_STANDARD_AR_MAG_T = "rhsusf_100Rnd_556x45_soft_pouch";

// Given to MAT and Asst MAT BP
_STANDARD_ROCKET_LAUNCHER = "CUP_launch_Mk153Mod0";
_STANDARD_ROCKET1 = "CUP_SMAW_HEAA_M";
_STANDARD_ROCKET2 = "CUP_SMAW_HEDP_M";

// Must be arrays
_STANDARD_ATTACHMENTS = ["CUP_optic_CompM2_Black"];
_LEADER_ATTACHMENTS =  ["rhsusf_acc_anpeq15","CUP_optic_CompM2_Black"];
_LEADER_ITEMS = ["ItemGPS", "AGM_MapTools"];

_GL_SMOKES = ["1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell"];
_GL_HE = "1Rnd_HE_Grenade_shell";

_STANDARD_PISTOL = "RH_m1911";
_STANDARD_PISTOL_MAG = "RH_7Rnd_45cal_m1911";

_GRENADE = "HandGrenade";
_STANDARD_SMOKE = "SmokeShellGreen";
_CHEMLIGHT = "Chemlight_green";

_LR_RADIO = ["tf_rt1523g","tf_mr3000","tf_anprc155", "tf_rt1523g"] select ([BLUFOR, OPFOR, independent, civilian] find side _unit);
