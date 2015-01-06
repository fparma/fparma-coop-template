//Burn script for static objects. Based on burning vehicles script by Maddmatt, for ArmA 2
//Revamped for A3 by Pelle SSG
//params: [unit,intensity 0.5 - 10,time]
//everything above 3 intensity will create smoke
//example: nul = [car1,3,600] execVM "fp_scripts\smoke.sqf"


if (isDedicated) exitWith {};
private ["_v", "_int", "_timer", "_snd", "_fl", "_sm", "_li", "_cl"];
_v = _this select 0;
if (isNil "_v") exitWith {};
if (isNull _v) exitWith {};
_int = _this select 1;
_timer = time + (_this select 2);
_pos = [getPos _v select 0, getPos _v select 1, 0];

	_fl = "#particlesource" createVehicleLocal _pos;
	_fl setPos _pos;
	_fl setdropinterval 0.02;

	_sm = "#particlesource" createVehicleLocal _pos;
	_sm setPos _pos;

	_li = "#lightpoint" createVehicleLocal _pos;
	_li setLightBrightness 0;
	_li setLightAmbient[0.8, 0.6, 0.2];
	_li setLightColor[1, 0.5, 0.4];

_attacher = _this select 3;
if (isNil "_attacher") then {_attacher = true};

_dummy = "HeliHEmpty" createVehicleLocal _pos;
_dummy setPos _pos;

if (_attacher) then 
{
	if (_v isKindOf "car") then {_dummy attachto [_v, [0,1,-0.5]];};
	if (_v isKindOf "ship") then {_dummy attachto [_v, [0,2,-2]];}
	else {_dummy attachto [_v, [0,2,-0.1]];};
	
};

//==== instructions =========
/*
_sm setParticleParams 
[["\a3\Data_f\ParticleEffects\Universal\Universal", 16, 7, 48], "", //File, Ntieth, Index, Count, Loop(Bool)
"Billboard", //Type
1, 10, //Timer per, Life time
[0, 0, 0.5], //POS
[0, 0, 2.9], //Move velocity
1, 1.275, 1, 0.066, //rotationVel, weight, volume, rubbing
[4, 5, 10, 10], //Scale - ??, ??, efter en stund, i slutet
[[0.3, 0.3, 0.3, 0.33], [0.4, 0.4, 0.4, 0.33], [0.2, 0.2, 0, 0]], //Color
[0, 1], //Anim speed
1, 0, //RandDir period, RandDir intensity
"", "", _v];
*/		
//============================	
while {(_int>3) && (_timer > time)} do {	
	//SMOKE!
	_cl = 0.8/_int;
	_sm setDropInterval (0.01 + 0.02*_int);
	_sm setParticleParams 
	[["\a3\data_f\ParticleEffects\Universal\Universal_02",8, 0, 16], 
	"","Billboard",
	0.5, 3*_int, 
	"destructionEffect1",
	[0, 0, 0.5*_int],  
	6, 0.05, 0.05, 0.45, 
	[0.5*_int,2*_int,2.0*_int,2.1*_int], 
	[[_cl, _cl, _cl, 0.2],[_cl, _cl, _cl, 1],[_cl, _cl, _cl, 1],
	[0.05+_cl, 0.05+_cl, 0.05+_cl, 0.9],[0.1+_cl, 0.1+_cl, 0.1+_cl, 0.6],[0.2+_cl, 0.2+_cl, 0.2+_cl, 0.3], [1,1,1, 0.1]], 
	[0.8,0.3,0.25], 
	1, 0, 
	"", "", _v];

	_sm setParticleRandom [0.7*_int, [1 - _int/10,1 - _int/10,1 - _int/10], [0.2*_int, 0.2*_int, 0.05*_int], 0, 0.3, [0.05, 0.05, 0.05, 0], 0, 0];

	_li setLightBrightness (_int/30);

	//FIRE!
	//_fl setDropInterval (0.01 + 0.02*_int);
	_fl setParticleParams 
	[["\a3\data_f\ParticleEffects\Universal\Universal", 16, 10, 32],
	"", "Billboard", 3, 4, 
	"",[0, 0.1, 0.1],
	0, 0.0565, 0.045, 0.025,
	[1, 0], 
	[[1,1,1,-0], [1,1,1,-1], [1,1,1,-1], [1,1,1,-1], [1,1,1,-1], [1,1,1,0]], 
	[1], 0.01, 0.02, "", "", _v];

	//_fl setParticleRandom [0.5*_int, [0.1*_int, 0.1*_int, 0.1*_int], [0.05*_int, 0.05*_int, 0.05*_int], 0, 0.06*_int, [0, 0, 0, 0], 0, 0];
	_fl setParticleRandom [0, [0.05*_int, 0.05*_int, 0.05*_int], [0.0, 0.0, 0.1], 0, 0.15*_int, [0, 0, 0, 0], 0, 0];
	sleep 3;
};

while {(_int>0.4) && (_timer > time)} do {
	_cl = 0.8/_int;
	//SMOKE!
	_sm setDropInterval (0.01 + 0.02*_int);
	_sm setParticleParams 
	[["\a3\data_f\ParticleEffects\Universal\Universal", 16, 7, 48], 
	"","Billboard",1, 3*_int, 
	"destructionEffect1",[0, 0, 0.5*_int],  
	0, 0.05, 0.04, 0.05, [0.5*_int, 3*_int],
	[[_cl, _cl, _cl, 0.2],[_cl, _cl, _cl, 1],[_cl, _cl, _cl, 1],
	[0.05+_cl, 0.05+_cl, 0.05+_cl, 0.9],[0.1+_cl, 0.1+_cl, 0.1+_cl, 0.6],[0.2+_cl, 0.2+_cl, 0.2+_cl, 0.3], [1,1,1, 0]], 
	[0.8,0.3,0.25], 1, 0, "", "", _v];
	_sm setParticleRandom [0.7*_int, [1 - _int/10,1 - _int/10,1 - _int/10], [0.2*_int, 0.2*_int, 0.05*_int], 0, 0.3, [0.05, 0.05, 0.05, 0], 0, 0];

	_li setLightBrightness (_int/30);
	sleep 3;
};

deletevehicle _sm; 
deletevehicle _li;
deleteVehicle _dummy;
