/*should be #include'd in all scripts. this will be "inserted" into those scripts*/

/*
---------------- AAF ---------------
	VANILLA weapons
*/


_UNIFORMS = ["U_I_CombatUniform_shortsleeve","U_I_CombatUniform","U_I_CombatUniform_tshirt"];
// first in vests = sql / plt
_VESTS = ["V_PlateCarrierSpec_rgr","V_PlateCarrierIA1_dgtl","V_PlateCarrierIA2_dgtl","V_PlateCarrierIAGL_dgtl"];
_HEADGEARS = ["H_HelmetIA", "H_HelmetIA_net"];

_STANDARD_ITEMS = ["ItemMap","ItemCompass","ItemWatch","NVGoggles","ItemRadio"];

_STANDARD_RIFLE = "arifle_Mk20_F";
_STANDARD_RIFLE_C = "arifle_Mk20C_F";
_STANDARD_RIFLE_GL = "arifle_Mk20_GL_F";
_STANDARD_RIFLE_ASS = _STANDARD_RIFLE;

_STANDARD_MAG = "30Rnd_65x39_caseless_mag";
_STANDARD_MAG_T = "30Rnd_65x39_caseless_mag_Tracer";

// Given to AR and Asst AR BP
_STANDARD_AR = "LMG_Zafir_F";
_STANDARD_AR_MAG = "150Rnd_762x51_Box";
_STANDARD_AR_MAG_T = "150Rnd_762x51_Box_Tracer";


// Given to MAT and Asst MAT BP
_STANDARD_ROCKET_LAUNCHER = "launch_B_Titan_short_F";
_STANDARD_ROCKET1 = "Titan_AT";
_STANDARD_ROCKET2 = "Titan_AP";

// Must be arrays
_STANDARD_ATTACHMENTS = ["optic_Aco"];
_LEADER_ATTACHMENTS =  ["acc_pointer_IR","optic_MRCO"];
_GL_SMOKES = ["1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell"];

_GL_HE = "1Rnd_HE_Grenade_shell";

_STANDARD_PISTOL = "hgun_ACPC2_F";
_STANDARD_PISTOL_MAG = "9Rnd_45ACP_Mag";

_GRENADE = "HandGrenade";
_STANDARD_SMOKE = "SmokeShellGreen";
_GPS = "ItemGPS";
_CHEMLIGHT = "Chemlight_green";

_LR_RADIO = ["tf_rt1523g","tf_mr3000","tf_anprc155", "tf_rt1523g"] select ([BLUFOR, OPFOR, independent, civilian] find side _unit);