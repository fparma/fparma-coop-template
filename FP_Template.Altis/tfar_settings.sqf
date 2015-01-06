#include "\task_force_radio\functions\common.sqf";

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
    _settings = false call TFAR_fnc_generateSwSettings;
    _settings set [2, ["101","102","103","104","105","106","107","108","109"]];
    tf_freq_west = _settings;
    publicVariable "tf_freq_west";
     _settingsLR = false call TFAR_fnc_generateLrSettings;
     _settingsLR set [2, ["41.1","42","43","44","45","46","47","48","49"]];
     tf_freq_west_lr = _settingsLR;
     publicVariable "tf_freq_west_lr";

    _settings = false call TFAR_fnc_generateSwSettings;
    _settings set [2, ["101","102","103","104","105","106","107","108","109"]];
    tf_freq_east = _settings;
    publicVariable "tf_freq_east";
     _settingsLR = false call TFAR_fnc_generateLrSettings;
     _settingsLR set [2, ["41.1","42","43","44","45","46","47","48","49"]];
     tf_freq_east_lr = _settingsLR;
     publicVariable "tf_freq_east_lr";

    _settings = false call TFAR_fnc_generateSwSettings;
    _settings set [2, ["101","102","103","104","105","106","107","108","109"]];
    tf_freq_guer = _settings;
    publicVariable "tf_freq_guer";
     _settingsLR = false call TFAR_fnc_generateLrSettings;
     _settingsLR set [2, ["41.1","42","43","44","45","46","47","48","49"]];
     tf_freq_guer_lr = _settingsLR;
     publicVariable "tf_freq_guer_lr";
};