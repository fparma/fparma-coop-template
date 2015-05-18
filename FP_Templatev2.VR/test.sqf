["Wave respawn"] call BIS_fnc_blackIn;
_dropPos = "";

[object or position, distance, direction]

_veh = "Box_NATO_AmmoVeh_F" createVehicleLocal [0,0,0];
player action ["DropBag", _veh, backpack player];
waitUntil {isNull unitBackpack player};
player addBackpack "B_Parachute";


waitUntil {!alive player || vehicle player == player};
