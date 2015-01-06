_object = _this select 0;
if (_object getVariable ["fp_isRepairing",false]) exitWith {hint "Vehicle is being repaired. STAY in the vehicle."};
_object removeAction (_this select 2);
_object setVariable ["fp_isRepairing",true,true];

_type = typeOf _object;
_object setFuel 0;
_object setVelocity [0,0,0];

x_reload_time_factor = 10;

_object setVehicleAmmo 1;

_object vehicleChat format ["Servicing %1... STAY IN THE VEHICLE! Please stand by...", _type];

_magazines = getArray(configFile >> "CfgVehicles" >> _type >> "magazines");

if (count _magazines > 0) then {
	_removed = [];
	{
		if (!(_x in _removed)) then {
			_object removeMagazines _x;
			_removed = _removed + [_x];
		};
	} forEach _magazines;
	{
		_object vehicleChat format ["Reloading %1", _x];
		sleep x_reload_time_factor;
		_object addMagazine _x;
	} forEach _magazines;
};

_count = count (configFile >> "CfgVehicles" >> _type >> "Turrets");

if (_count > 0) then {
	for "_i" from 0 to (_count - 1) do {
		scopeName "xx_reload2_xx";
		_config = (configFile >> "CfgVehicles" >> _type >> "Turrets") select _i;
		_magazines = getArray(_config >> "magazines");
		_removed = [];
		{
			if (!(_x in _removed)) then {
				_object removeMagazines _x;
				_removed = _removed + [_x];
			};
		} forEach _magazines;
		{
			_object vehicleChat format ["Reloading %1", _x];
			sleep x_reload_time_factor;
			_object addMagazine _x;
			sleep x_reload_time_factor;
		} forEach _magazines;
		_count_other = count (_config >> "Turrets");
		if (_count_other > 0) then {
			for "_i" from 0 to (_count_other - 1) do {
				_config2 = (_config >> "Turrets") select _i;
				_magazines = getArray(_config2 >> "magazines");
				_removed = [];
				{
					if (!(_x in _removed)) then {
						_object removeMagazines _x;
						_removed = _removed + [_x];
					};
				} forEach _magazines;
				{
					_object vehicleChat format ["Reloading %1", _x]; 
					sleep x_reload_time_factor;
					_object addMagazine _x;
					sleep x_reload_time_factor;
				} forEach _magazines;
			};
		};
	};
};
_object setVehicleAmmo 1;	// Reload turrets / drivers magazine

sleep x_reload_time_factor;
_object vehicleChat "Repairing...";
_object setDamage 0;
sleep x_reload_time_factor;
_object vehicleChat "Refueling...";
while {fuel _object < 0.99} do {
	//_object setFuel ((fuel _vehicle + 0.1) min 1);
	_object setFuel 1;
	sleep 0.01;
};
sleep x_reload_time_factor;
_object vehicleChat format ["%1 is ready...", _type];

if (!isNil "REPAIR_PAD") then {
	_object addAction ["<t color=""#1111ff"">[ Repair vehicle ]</t>","src\x_reload.sqf",0, 100, true, true,"","(vehicle player == _target && (driver vehicle player == player)) && _target distance REPAIR_PAD < 6 && isTouchingGround _target"];
};		
_object setVariable ["fp_isRepairing",false,true];

if (true) exitWith {};
