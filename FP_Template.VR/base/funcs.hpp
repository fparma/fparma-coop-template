class FP {
    tag="FP";
    class functions {
        file = "base\functions";
        class addToCurators;
        class clearVehicle;
        class getPlayer;
        class setVehicleName;
        class disableWeapons;
        class isValidPos;
        class spectate;
        class cache;
        class unCache;
        class coldStart {
            postInit = 1;
        };
    };
};

class FP_AI {
    tag="FP";
    file = "xtra\ai";
    class defend;
    class garrison;
    class patrol;
    class heliExtraction;
};

class FP_JRM {
    tag="FP_JRM";
    class functions {
        file = "base\functions\jrm";
        class init {
            postInit = 1;
        };
        class forceRespawn;
        class getSpectators;
    };
};
