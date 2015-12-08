params ["_unit", "_kit"];

_unit forceAddUniform "U_B_Wetsuit";
_unit addVest "V_RebreatherB";
_unit addGoggles "G_Diving";
_unit addBackpack "CUP_B_USPack_Black";

private _bp = unitBackpack _unit;
_bp addItemCargoGlobal ["FP_Uniform_Black", 1];
if (_kit == "MEDIC") then {
    _bp addItemCargoGlobal ["V_Chestrig_blk", 1];
} else {
    _bp addItemCargoGlobal ["FP_Carrier_BlackPatchless", 1];
};

_bp addItemCargoGlobal [["H_HelmetSpecB_blk", "H_HelmetSpecB"] call BIS_fnc_selectRandom, 1];
_bp addItemCargoGlobal [(goggles _unit), 1];
removeGoggles _unit;

_COMMON_RIFLE = "hlc_smg_mp510";
_COMMON_RIFLE_GL = "hlc_smg_9mmar";
_COMMON_RIFLE_ATTACHMENTS = ["RH_peq2", "RH_LTdocterl", "hlc_muzzle_Agendasix10mm"];

_9mm = "hlc_30Rnd_9x19_B_MP5";
_9mmSUB = "hlc_30Rnd_9x19_SD_MP5";
_10mm = "hlc_30Rnd_10mm_B_MP5";
_10mmJHP = "hlc_30Rnd_10mm_JHP_MP5";

_COMMON_GL_NADES = ["1Rnd_HE_Grenade_shell", 4];
_COMMON_ITEMS = ["ACRE_PRC343", "ItemMap","ItemCompass","ItemWatch", "HandGrenade", ["ACE_fieldDressing", 2], "ACE_Morphine"];
_MED_BP_ITEMS = [
    ["ACE_fieldDressing",16],
    ["ACE_morphine",12],
    ["ACE_epinephrine",12],
    ["ACE_bloodIV", 2]
];

_SQL_BINOC = "laser"; // can be binoc, soflam, lerca_b (black), lerca_t (tan), laser, laser_blufor, laser_opfor, laser_indep. check fn_addOptic.sqf
_SQL_ITEMS = ["ACRE_PRC148", "ACE_microDAGR", "ACE_MapTools"];
_SQL_ATTACHMENTS = ["hlc_muzzle_Tundra", "RH_peq2_top", "RH_LTdocterl"];

// ==================
// Assign the stuff
// ==================
switch _kit do {

    case "PLT"; // fall through to SQL
    case "SQL": {
        [_unit, [[_9mm, 8], _COMMON_GL_NADES], "backpack"] call FP_fnc_addToContainers;
        [_unit, [_9mmSUB, 4], "uniform"] call FP_fnc_addToContainers;

        [_unit, [_COMMON_RIFLE_GL, _SQL_ATTACHMENTS]] call FP_fnc_addWeapon;

        [_unit, _SQL_BINOC] call FP_fnc_addOptic;
        [_unit, _SQL_ITEMS] call FP_fnc_addToContainers;

    };

    case "MEDIC": {
        [_unit, [[_9mm, 5]], "backpack"] call FP_fnc_addToContainers;
        [_unit, [_9mmSUB, 4], "uniform"] call FP_fnc_addToContainers;
        [_unit, ["hlc_smg_mp5k_PDW", "hlc_muzzle_Tundra", "RH_zpoint"]] call FP_fnc_addWeapon;

        [_unit, _MED_BP_ITEMS, "backpack"] call FP_fnc_addToContainers;

    };

    case "RAT"; // fall through
    case "RIFLEMAN": {
        [_unit, [_10mm, 8], "backpack"] call FP_fnc_addToContainers;
        [_unit, [[_10mmJHP, 4], "SmokeShellGreen", "SmokeShellGreen"], "uniform"] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;

        if (_kit == "RAT") then {
            [_unit, "CUP_launch_M136"] call FP_fnc_addWeapon;
        };
    };

    case "ENGINEER": {
        [_unit, [_10mm, 8], "backpack"] call FP_fnc_addToContainers;
        [_unit, [_10mmJHP, 4], "uniform"] call FP_fnc_addToContainers;
        [_unit, ["ACE_Clacker", "ACE_DefusalKit", "DemoCharge_Remote_Mag", "DemoCharge_Remote_Mag"]] call FP_fnc_addToContainers;
        [_unit, [_COMMON_RIFLE, _COMMON_RIFLE_ATTACHMENTS]] call FP_fnc_addWeapon;
    };
};

[_unit, _COMMON_ITEMS] call FP_fnc_addToContainers;
[_unit, "ace_flashlight_mx991"] call FP_fnc_addToContainers;
_COMMON_NVG = "gen1"; // can be: pvs14, pvs15, gen1, gen2, gen3, gen4, wide, blufor, opfor, indep. check fn_addNVG.sqf
[_unit, _COMMON_NVG] call FP_fnc_addNVG;
