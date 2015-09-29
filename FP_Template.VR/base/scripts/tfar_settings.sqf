// #include "\task_force_radio\functions\common.sqf";

tf_no_auto_long_range_radio = true;
tf_same_sw_frequencies_for_side = true;
tf_same_lr_frequencies_for_side = true;

TF_defaultWestRiflemanRadio = "tf_anprc152";
TF_defaultWestPersonalRadio = "tf_anprc152";

TF_defaultEastRiflemanRadio = "tf_fadak";
TF_defaultEastPersonalRadio = "tf_fadak";

TF_defaultGuerRiflemanRadio = "tf_anprc148jem";
TF_defaultGuerPersonalRadio = "tf_anprc148jem";

if (isServer) then {
    _SR = ["101","102","103","104","105","106","107","108","109"];
    _LR  = ["41.1","42.2","43.3","44.4","45.5","46.6","47.7","48.8","49.9"];

    {
        _settingsSR = false call TFAR_fnc_generateSwSettings;
        _settingsSR set [2, _SR];
        missionNamespace setVariable [_x, _settingsSR];
        publicVariable _x;
    } foreach ["tf_freq_west", "tf_freq_east", "tf_freq_guer"];

    {
        _settingsLR = false call TFAR_fnc_generateLrSettings;
        _settingsLR set [2, _LR];
        missionNamespace setVariable [_x, _settingsLR];
        publicVariable _x;
    } forEach ["tf_freq_west_lr", "tf_freq_east_lr", "tf_freq_guer_lr"];
};
