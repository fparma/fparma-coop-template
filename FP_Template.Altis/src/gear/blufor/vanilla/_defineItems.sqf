/*should be #include'd in all scripts. this will be "inserted" into those scripts*/

_UNIFORMS = ["U_B_CombatUniform_mcam_tshirt","U_B_CombatUniform_mcam_vest","U_B_CombatUniform_mcam"];
_VESTS = ["V_PlateCarrierGL_rgr","V_Chestrig_khk","V_PlateCarrier2_rgr","V_Chestrig_khk","V_TacVest_khk","V_PlateCarrier3_rgr"];
_HEADGEARS = ["H_HelmetB_paint", "H_HelmetB_light","H_HelmetB_light_desert", "H_HelmetB_light_sand","H_HelmetB_camo", "H_HelmetB_desert" ,"H_HelmetB_grass"];

_STANDARD_ITEMS = ["ItemMap","ItemCompass","ItemWatch","NVGoggles","ItemRadio"];

_STANDARD_RIFLE = "arifle_MX_F";
_STANDARD_RIFLE_C = "arifle_MXC_F";
_STANDARD_RIFLE_GL = "arifle_MX_GL_ACO_F";
_STANDARD_RIFLE_ASS = "arifle_MXM_F";

_STANDARD_MAG = "30Rnd_65x39_caseless_mag";
_STANDARD_MAG_T = "30Rnd_65x39_caseless_mag_Tracer";

// Given to AR and Asst AR BP
_STANDARD_AR = "arifle_MX_SW_pointer_F";
_STANDARD_AR_MAG = "100Rnd_65x39_caseless_mag";
_STANDARD_AR_MAG_T = "100Rnd_65x39_caseless_mag_Tracer";

// Given to MAT and Asst MAT BP
_STANDARD_ROCKET_LAUNCHER = "launch_B_Titan_short_F";
_STANDARD_ROCKET1 = "Titan_AT";
_STANDARD_ROCKET2 = "Titan_AP";

// Must be arrays
_STANDARD_ATTACHMENTS = ["optic_Aco"];
_LEADER_ATTACHMENTS =  ["acc_pointer_IR","optic_Arco"];
_GL_SMOKES = ["1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell"];

_GL_HE = "1Rnd_HE_Grenade_shell";

_STANDARD_PISTOL = "hgun_P07_F";
_STANDARD_PISTOL_MAG = "16Rnd_9x21_Mag";

_GRENADE = "HandGrenade";
_STANDARD_SMOKE = "SmokeShellGreen";
_GPS = "ItemGPS";
_CHEMLIGHT = "Chemlight_green";

_LR_RADIO = ["tf_rt1523g","tf_mr3000","tf_anprc155", "tf_rt1523g"] select ([BLUFOR, OPFOR, independent, civilian] find side _unit);
