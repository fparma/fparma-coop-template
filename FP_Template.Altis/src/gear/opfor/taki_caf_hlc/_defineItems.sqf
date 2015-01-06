/*should be #include'd in all scripts. this will be "inserted" into those scripts*/

/*
---------------- OPFOR ---------------
	CAF uniforms, mixed vest, caf headgears.  HLC weapons
*/

_UNIFORMS = ["U_CAF_AG_ME_FATIGUES_01","U_CAF_AG_ME_FATIGUES_01a",
 	"U_CAF_AG_ME_FATIGUES_01b", "U_CAF_AG_ME_FATIGUES_01c","U_CAF_AG_ME_FATIGUES_01d",
 	"U_CAF_AG_ME_ROBES_01"];

_VESTS = ["V_HarnessOGL_brn","V_HarnessO_brn","V_TacVest_khk","V_HarnessOSpec_brn","V_Chestrig_khk"];
_HEADGEARS = ["H_Shemag_olive", "H_Shemag_olive_hs", "H_ShemagOpen_tan", "H_ShemagOpen_khk", "H_caf_ag_turban","H_caf_ag_turban", "H_caf_ag_wrap", "H_caf_ag_wrap"];

_STANDARD_ITEMS = ["ItemMap","ItemCompass","ItemWatch", "ItemRadio"];

_STANDARD_RIFLE = "hlc_rifle_ak47";
_STANDARD_RIFLE_C = _STANDARD_RIFLE;
_STANDARD_RIFLE_GL = "hlc_rifle_akmgl";
_STANDARD_RIFLE_ASS = _STANDARD_RIFLE;

_STANDARD_MAG = "hlc_30Rnd_762x39_b_ak";
_STANDARD_MAG_T = "hlc_30Rnd_762x39_t_ak";

// Given to AR and Asst AR BP
_STANDARD_AR = "caf_pkm";
_STANDARD_AR_MAG = "CAF_100Rnd_762x54_PKM";
_STANDARD_AR_MAG_T = "200Rnd_65x39_cased_Box_Tracer";

// Given to MAT and Asst MAT BP
_STANDARD_ROCKET_LAUNCHER = "rhs_weap_rpg7";
_STANDARD_ROCKET1 = "rhs_rpg7_PG7VL_mag";
_STANDARD_ROCKET2 = "rhs_rpg7_OG7V_mag";

// Must be arrays
_STANDARD_ATTACHMENTS = ["optic_Aco"];
_LEADER_ATTACHMENTS =  ["acc_pointer_IR","optic_ARCO"];
_GL_SMOKES = ["hlc_GRD_yellow","hlc_GRD_yellow","hlc_GRD_green"];

_GL_HE = "hlc_VOG25_AK";

_STANDARD_PISTOL = "RH_vz61";
_STANDARD_PISTOL_MAG = "RH_20Rnd_32cal_vz61";

_GRENADE = "HandGrenade";
_STANDARD_SMOKE = "SmokeShellGreen";
_GPS = "ItemGPS";
_CHEMLIGHT = "Chemlight_green";

_LR_RADIO = ["tf_rt1523g","tf_mr3000","tf_anprc155", "tf_rt1523g"] select ([BLUFOR, OPFOR, independent, civilian] find side _unit);