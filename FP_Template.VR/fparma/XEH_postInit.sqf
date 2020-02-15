#include "../config_mission.hpp"

if (is3DEN) exitWith {};

enableSaving [false, false];
setViewDistance CFG_VIEWDISTANCE;
setObjectViewDistance CFG_VIEWDISTANCE_OBJECT;

[CFG_JRM_RESPAWNS] call fpa_jrm_fnc_init;

if (!hasInterface) exitWith {};

disableRemoteSensors true;

// When piloting or gunning air vehicle, increase view distance
["vehicle", {
  private _veh = vehicle ACE_player;
  if (!(_veh isKindOf "Air")) exitWith {
    setViewDistance CFG_VIEWDISTANCE;
    setObjectViewDistance CFG_VIEWDISTANCE_OBJECT;
  };

  if (ACE_player in [driver _veh, gunner _veh]) then {
    setViewDistance CFG_AIR_VIEWDISTANCE;
    setObjectViewDistance CFG_AIR_VIEWDISTANCE_OBJECT;
  };
}] call CBA_fnc_addPlayerEventHandler;

// add diwakos limb trauma calculation for AI
["ace_medical_woundReceived", {
  [{
    params ["_unit", "_bodyPart", "_damage", "", "_typeOfDamage"];
    if (isPlayer _unit || {ace_medical_fatalDamageSource isEqualTo 0}) exitWith {};
    private _bodyPartN = ["head", "body", "leftarm", "rightarm", "leftleg", "rightleg"] find toLower _bodyPart;
    if (_bodyPartN < 2) exitWith {};

    if ((_typeOfDamage isEqualTo "") || {isNil {ace_medical_damage_allDamageTypesData getVariable _typeOfDamage}}) then {
      _typeOfDamage = "unknown";
    };
    private _damageTypeInfo = [ace_medical_damage_allDamageTypesData getVariable _typeOfDamage] param [0, [[], false, []]];
    _damageTypeInfo params ["_thresholds"];

    (_unit getVariable ["ace_medical_bodyPartDamage", [0,0,0,0,0,0]]) params ["", "", "_leftarmDamage", "_rightarmDamage", "_leftlegDamage", "_rightlegDamage"];
    {
      _x params ["_thresholdMinDam", "_thresholdWoundCount"];
      if (_damage > _thresholdMinDam) exitWith {
        private _woundDamage = _damage / (_thresholdWoundCount max 1);
        private _limbThreshhold = 12 * ace_medical_AIDamageThreshold;
        private _vitalDamage = ((_leftarmDamage + _rightarmDamage + _leftlegDamage + _rightlegDamage) - _limbThreshhold) max 0;
        private _chanceFatal = 1 - exp -((_vitalDamage/ace_medical_const_fatalSumDamageWeibull_L)^ace_medical_const_fatalSumDamageWeibull_K);

        if (_chanceFatal > random 1) then {
          ["ace_medical_FatalInjury", _unit] call CBA_fnc_localEvent;
        };
      };
    } forEach _thresholds;
  },_this] call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;