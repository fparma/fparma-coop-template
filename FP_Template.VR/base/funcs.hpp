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
        class coldStart {
            postInit = 1;
        };
    };
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
