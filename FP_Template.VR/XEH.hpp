class Extended_PreInit_EventHandlers {
  class FPARMA_Template {
    init = "[] call compile preprocessFileLineNumbers 'fparma\XEH_preInit.sqf'";
  };
};

class Extended_PostInit_EventHandlers {
  class FPARMA_Template {
    init = "[] call compile preprocessFileLineNumbers 'fparma\XEH_postInit.sqf'";
  };
};