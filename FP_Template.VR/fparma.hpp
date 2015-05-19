
// Dialogs. Remove if not using \xtra
#include "xtra\dialogs\dialogs.hpp"

// Functions
class CfgFunctions {
	version = 2.0.0;
	createShortcuts = 1;

	// BASE API. Do not remove
	class FP_Base {
		#include "base\funcs.hpp"
	};

	// Anything below can be deleted if you do not want to use it.
	// Rember to delete the dialogs (see top)

	// Gear funcs
	class FP_Gear {
		#include "gear\functions\funcs.hpp"
	};

	// Spawning functions
	class FP_Spawn {
		#include "xtra\spawn\funcs.hpp"
	};

	// JIP and respawn manager
	class FP_JRM {
		#include "xtra\jrm\funcs.hpp"
	};

	// Spectate funcs
	class F {
		#include "xtra\spect\funcs.hpp"
	};


}; // << do not delete me
