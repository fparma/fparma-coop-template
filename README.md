# FPARMA Coop Template

This is a base to create any new missions for fparma.

#### Check `config_mission.hpp` for changing a few settings for your missions.

#### HOW TO USE LOADOUT SCRIPTS:
The loadout scripts are exported from arsenal, we have a custom arsenal EXPORT function that will create proper loadout scripts, mainly to handle ACRE.

Note that this only works in the GAME, **not** in EDEN arsenal editor. BI and ACE Arsenal are supported.

Edit `_loadout.config.sqf` in the folder `loadouts` after your needs.
It works after the unit's classname, which you can see when hovering the unit in the EDEN Editor.

Add or edit the entries in `_loadout_config.sqf` after the classname and a corresponding script file in `loadouts` folder.
This is a example entry:
```
["B_officer_F", "plt.sqf"],
```

It means for units of type "B_officer_F", run the script "plt.sqf"
Make sure that the last entry does not have a trailing comma, everyone before that must have it.

For example on how to reuse files, see rifleman_at.sqf, plt.sqf, and pilot.sqf. `#include` means: take the file and paste it on this line
