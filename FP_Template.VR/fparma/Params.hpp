//This file should not be edited, see config_mission.hpp instead

/*enforce basic. contact a moderator if you want adv medic*/
class ace_medical_level {
    title = "Medical Level";
    ACE_setting = 1;
    values[] = {1};
    texts[] =  {"Basic - forced"};
    default = 1;
};

class ace_zeus_autoAddObjects {
    title = "Auto add zeus objects";
    ACE_setting = 1;
    values[] = {1};
    texts[] =  {"Yes"};
    default = 1;
};

class ace_medical_preventInstaDeath {
    title = "Prevent INSTANT death (e.g headshots - can still die when down)";
    ACE_setting = 1;
    values[] = {0,1};
    texts[] =  {"No", "Yes"};
    default = CFG_PREVENT_INSTANT_DEATH;
};

class ace_medical_playerDamageThreshold {
    title = "Player damage treshold";
    ACE_setting = 1;
    values[] = {1,2,3,4,5,6,7,8};
    texts[] =  {"ACE Default (1)", "FP Default (2)", "3", "4", "5", "6", "7", "8"};
    default = CFG_PLAYER_DAMAGE_TRESHOLD;
};
