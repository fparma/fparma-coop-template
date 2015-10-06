
// Dialogs
#include "xtra\dialogs\dialogs.hpp"

// Functions
class CfgFunctions {
	version = 2.2.0;
	createShortcuts = 1;

	// Base functions.
	class FP {
		#include "base\funcs.hpp"
	};

	// Anything below can be deleted if you do not want to use it.
	// Rember to delete the dialogs (see top)

	// Gear funcs
	class FP_Gear {
		#include "gear\functions\funcs.hpp"
	};

	// JIP and respawn manager
	class FP_JRM {
		#include "xtra\jrm\funcs.hpp"
	};

};
