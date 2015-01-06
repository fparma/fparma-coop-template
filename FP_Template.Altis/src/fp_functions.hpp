#define addFunction(funcName) class funcName {headerType =-1;}

version = 1.0;
createShortcuts = 1;
class FP {
	tag = "FP";
	class loadout {
		file = "src\gear";
		addFunction(getKit);
	};
	class api {
		file = "src\API";
		addFunction(intelHQ);
		addFunction(switchMove);
		addFunction(addAction);
		addFunction(removeAction);
		addFunction(hint);
		addFunction(getCurrentScript);
	};
	class local {
		file = "src\API\local";
		addFunction(local_intelHQ);
		addFunction(local_switchMove);
		addFunction(local_addAction);
		addFunction(local_hint);
		addFunction(local_removeAction);
	};
	class spawn {
		file = "src\spawn";
		addFunction(getUnits);
		addFunction(spawnGroup);
		addFunction(UPS);
		addFunction(spawnVehicle);
		addFunction(spawnGroupWP);
		addFunction(spawnHousePatrol);
		addFunction(spawnDefense);
		addFunction(spawnPatrol);
		addFunction(spawnPara);
		addFunction(spawnGarrison);
		addFunction(dropPara);
	};
	class GC {
		file ="src\spawn\cleanup";
		addFunction(addTrash);
	};
};

class F {
	tag="F";
	class fspectator
	{
		file = "src\spect";
		addFunction(CamInit);
		addFunction(OnUnload);
		addFunction(DrawTags);
		addFunction(EventHandler);
		addFunction(GetIcon);
		addFunction(FreeCam);
		addFunction(GetPlayers);
		addFunction(ReloadModes);
		addFunction(UpdateValues);
		addFunction(HandleCamera);
		addFunction(ToggleGUI);
	};
};