// CBA's  Extended Eventhandlers

class Extended_PreInit_EventHandlers {
    class FPARMA {
        init = "[] call compile preProcessFileLineNumbers 'base\preInit.sqf'";
    };
};

// Disable units speaking / giving orders vocally
class Extended_InitPost_EventHandlers {
    class CAManBase {
        init = "(_this select 0) setSpeaker 'ACE_NoVoice'";
    };
};

class Extended_DisplayLoad_EventHandlers {
    class RscDisplayArsenal {
        FPARMA_override = "_this call FP_fnc_overrideArsenalExport";
    }
}
