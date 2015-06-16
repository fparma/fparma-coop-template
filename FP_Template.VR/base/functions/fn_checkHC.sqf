/*
	Function: FP_fnc_checkHC

	API:
		Any

	Description:
		A "continue if HC, if not HC available, continue if server" function

		Requires a virtual entity placed called "HC"

	Returns:
		False for clients
		True for server if "HC" variable is null
		True for HC if available

	Author:
		Cuel 2015-01-19
*/

if (isMultiplayer && {hasInterface}) exitWith {false};

private ["_ret", "_hc", "_hcPresent"];
_hc = missionNamespace getVariable ["HC", objNull];
_hcPresent = if (!isNull _hc) then {isPlayer _hc} else {false};

_ret = true;
if (_hcPresent && {isServer}) then {_ret = false};
_ret
