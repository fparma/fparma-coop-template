Some functions are in this template.
Below is a description on how to use and call them.

Note that they should only be called from the SERVER or a SINGLE client (not a global trigger etc). If you don't know how to do this, ask Cuel.

FP_fnc_switchMove
Takes an object and animation name. Plays the switchMove globally. Example:
[player,"acts_CrouchingFiringLeftRifle01"] call FP_fnc_switchMove;

FP_fnc_addAction 
Takes an object and ARRAY. Adds action globally. Example:
[theVIP,["<t color='#ffff00'>[ Free VIP ]</t>","free.sqf",0, 100, true, true,"","_this distance _target < 4 && vehicle player == player"]] call FP_fnc_addAction;
OR : 
[player,["Free Me","free.sqf"]] call FP_fnc_addAction;
actions are added for join in progress players.

FP_fnc_removeAction
Takes an object and an integer (number), removes action (globally). Also removes it for jips.
Remember that addAction returns an integer, alternatively it is the second (_this select 2) argument in whatever script that runs from an addAction. Example:
[theVIP,0] call FP_fnc_removeAction;

FP_fnc_hint
Takes a String (or array) and sends it globally. Example:
"Hello World" call FP_hint;
["Hello World"] call FP_fnc_hint;

FP_fnc_intelHQ
Send broadcast message with some sounds
Second array are objects where sound should be played
[[WEST,"HQ"],[]],"Message"] call FP_fnc_intelHQ


The below commands are great to use with triggers and will only run on the server
Available teams: (look in src\spawn\config_units.sqf you can add your own)
"CSAT", "NATO", "FIA", "AAF"
All functions returns the group (except FP_fnc_spawnVehicle returns the vehicle)

FP_fnc_spawnGroup
Purpose: Spawns a group at designated location with the specific amount. Takes an array format ["TEAM",position,amount (optional, default 4)]
Example: ["CSAT","myMarker",4] call FP_fnc_spawnGroup;

FP_spawnDefense
Purpose: Spawns a group at designated location with the specific amount. 
Takes an array format ["TEAM",position,amount,radius,patrol (boolean)] call FP_fnc_spawnDefense;
Boolean is patrol or not
Example: ["CSAT","myDefenseMarker",6,200,true] call FP_fnc_spawnDefense;

FP_fnc_spawnGroupWP
Purpose: Spawns a group at designated location with the specific amount. Group follows WP's 
Takes an array format ["TEAM",position,amount,position or array of positions,behaviour (optional)] call FP_fnc_spawnGroupWP;
Example: ["CSAT","myDefenseMarker",6,["move1","move2],"SAD"] call FP_fnc_spawnGroupWP;

FP_fnc_spawnHousePatrol
Purpose: Spawns a group at designated location with the specific amount. Group patrols and search houses if some are nearby
Takes an array format ["TEAM",position,amount,radius] call FP_fnc_spawnHousePatrol;
Example: ["CSAT","myDefenseMarker",6,100] call FP_fnc_spawnHousePatrol;

FP_fnc_spawnPatrol
Purpose: Spawns a group at designated location with the specific amount. Group patrols using UPS. patrolArea2must be an AREA to PATROL within
Example: ["CSAT","spawnPos","patrolArea2",4] call FP_fnc_spawnPatrol;

FP_fnc_spawnVehicle
Purpose: Spawns a vehicle at designated position. vehicle can patrol an area marker or follow waypoints, depending on format.
Vehicle patrol area marker: 
["CLASS",spawnpos,"area"] call FP_fnc_spawnVehicle;
Vehicle follows waypoint and does whatever behaviour on last waypoint:
["class",spawnpos,[array of markers or objects],behaviour] call FP_fnc_spawnVehicle;
Optional behaviour refers to last waypoint.

FP_fnc_spawnPara
Purpose: Spawns a at specified location, fills it with units, heli goes to the drop point. The group ejects and the heli returns to the spawn pos.
Example: ["CSAT",position player,markerPos "dropLocation","patrolArea"] call FP_fnc_spawnPara;
patrolArea is optional.
Returns: Created paratroop group

FP_fnc_spawnGarrison
	Purpose: Takes units and puts them inside buildings. If not enough positions, units not in houses will be put into own group and patrol
	@param {String} - TEAM to spawn
	@param {Location | String | Object} - Location to spawn the group at
	@param {Integer} - Amount of units to spawn
	@param {Integer} - Radius to search for buildings
	-- OPTIONAL parameters -- 
	@param {Boolean} Put units on roof (default false)
	@param {Boolean} - Fill evenly (true to fill all buildings in radius evenly, false for one by one. default true)
	@param {Boolean} - Lock units in place  (cant rotate) until enemies are within 50m (default true)

	@return: {Group} - Every created unit
	Example: 0 = ["AAFD", getPos player, 8, 150] call FP_fnc_spawnGarrison;
