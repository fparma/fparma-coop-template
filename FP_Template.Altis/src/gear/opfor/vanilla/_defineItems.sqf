/*should be #include'd in all scripts. this will be "inserted" into those scripts*/

/*
---------------- CSAT ---------------
	vanilla stuff
*/

_UNIFORMS = ["U_O_CombatUniform_ocamo","U_O_SpecopsUniform_ocamo"];
_VESTS = ["V_HarnessOGL_brn","V_HarnessO_brn","V_TacVest_khk","V_HarnessOSpec_brn","V_Chestrig_khk"];
_HEADGEARS = ["H_HelmetLeaderO_ocamo", "H_HelmetSpecO_ocamo","H_HelmetO_ocamo"];

_STANDARD_ITEMS = ["ItemMap","ItemCompass","ItemWatch","NVGoggles","ItemRadio"];

_STANDARD_RIFLE = "arifle_Katiba_F";
_STANDARD_RIFLE_C = "arifle_Katiba_C_F";
_STANDARD_RIFLE_GL = "arifle_Katiba_GL_F";
_STANDARD_RIFLE_ASS = _STANDARD_RIFLE;

_STANDARD_MAG = "30Rnd_65x39_caseless_green";
_STANDARD_MAG_T = "30Rnd_65x39_caseless_green_mag_Tracer";

// Given to AR and Asst AR BP
_STANDARD_AR = "LMG_Mk200_F";
_STANDARD_AR_MAG = "200Rnd_65x39_cased_Box";
_STANDARD_AR_MAG_T = "200Rnd_65x39_cased_Box_Tracer";

// Given to MAT and Asst MAT BP
_STANDARD_ROCKET_LAUNCHER = "launch_RPG32_F";
_STANDARD_ROCKET1 = "RPG32_F";
_STANDARD_ROCKET2 = "RPG32_HE_F";

// Must be arrays
_STANDARD_ATTACHMENTS = ["optic_Aco"];

_LEADER_ATTACHMENTS =  ["acc_pointer_IR","optic_MRCO"];
_LEADER_ITEMS = ["ItemGPS", "AGM_MapTools"];

_GL_SMOKES = ["1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell"];
_GL_HE = "1Rnd_HE_Grenade_shell";

_STANDARD_PISTOL = "hgun_Rook40_F";
_STANDARD_PISTOL_MAG = "16Rnd_9x21_Mag";

_GRENADE = "HandGrenade";
_STANDARD_SMOKE = "SmokeShellGreen";
_CHEMLIGHT = "Chemlight_green";

_LR_RADIO = ["tf_rt1523g","tf_mr3000","tf_anprc155", "tf_rt1523g"] select ([BLUFOR, OPFOR, independent, civilian] find side _unit);