/*
	Function: FP_JRM_fnc_decreaseLivesLeft

	Description:
		Called when a unit dies. Decreases his remaining respawns

	Parameters:
		_uid - Client UID

	Returns:
	Amount of remaining lives (-1 if infinite).

	Author:
	Cuel 2015-03-03
*/


_uid = [_this, 0, "", [""]] call BIS_fnc_param;
if (_uid == "") exitWith {
    ["Faulty UID received"] call BIS_fnc_error;
    -1
};

if (FP_JRM_amountLives < 0) exitWith {-1};

_amountLives = FP_jrm_amountLives;
_idx = -1;

{
    if (_x select 0 == _uid) exitWith {
        _idx = _foreachindex;
        _amountLives = _x select 1;
    };
}forEach FP_jrm_savedDeaths;

if (_idx > -1) then {
    FP_jrm_savedDeaths set [_idx, [_uid, 0 max (_amountLives -1)]];
}else{
    FP_jrm_savedDeaths pushback [_uid, 0 max (_amountLives -1)];
};

publicVariable "FP_jrm_savedDeaths";
// Do not decrease lives here as it would cause "1 respawn" to be 0 remaining

_amountLives
