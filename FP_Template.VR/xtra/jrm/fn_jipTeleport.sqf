/*
	Function: FP_JRM_fnc_jipTeleport

	Description:
		Teleports a JIP player. If he is group leader, he wil be teleport to his group.

    If member of a group, will be teleport to group leader

    If no units in group, will be teleport to the average position of all players of his side.
    If no player within 150m, chooses a random player.

	Parameters:
		_unit - Player object to teleport

	Examples:
	(begin example)
		[player] call FP_JRM_fnc_jipTeleport;
	(end)

	Author:
	Cuel 2015-03-03
*/

_unit = [_this, 0, objNull, [objNull]] call BIS_fnc_param;
if (isNull _unit || !FP_jrm_JIPTeleport) exitWith {};

private ["_goodPos" , "_tppos" ,"_isValidPos"];
_tppos = [];

_goodPos = {
    private ["_pos", "_realPos"];
    _pos = if (typename _this == typename objnull) then {_this modelToWorld [0,-2,0]}else{_this};
    _pos = (_pos call CBA_fnc_getPos);
    _realPos = (_pos findEmptyPosition [0,50]);
    if (count _realPos > 0) then {_pos = _realPos};
    _pos set [2,0];
    _pos
};

_isValidPos = {
    private ["_pos", "_ret"];
    _ret = true;
    _pos = _this call CBA_fnc_getPos;
    _origZ  = _pos select 2;
    _pos set [2,0];
    if (_pos distance [0,0] < 10 || {surfaceIsWater _pos} || {_origZ > 10}) then {
        _ret = false;
    };
    _ret;
};

if (leader group _unit != _unit) then {
    // tp to leader
    _tppos = (leader group _unit) call _goodPos;

}else{
    // unit is leader
    _sideUnits = [];

    if (count units group _unit == 1) then {
        // no units in group
        {
            if (alive _x && {side _x == side _unit} && {_x != _unit} && {_x call _isValidPos}) then {
                _sideUnits pushBack _x;
            };

        }forEach ([]call CBA_fnc_players);

    }else{
        // units in group
        {
            if (alive _x && {_x != _unit} && {_x call _isValidPos}) then {
                _sideUnits pushback _x;
            };
        }forEach (units group _unit);
    };

    if (count _sideUnits == 0) exitWith{};

    _averagex=0;
    _averagey=0;
    // find the average position between the units selected
    _divide = count _sideUnits;
    {_averagex=_averagex+(getPosATL vehicle _x select 0);_averagey=_averagey+(getPosATL vehicle _x select 1)} forEach _sideUnits;
    _tppos= [_averagex/_divide,_averagey/_divide,0];
    _tppos = _tppos call _goodPos;

    // if no units are near this tppos, just pick someone at random
    if (!([_tppos, 150] call CBA_fnc_nearPlayer)) then {
        _tppos = (_sideUnits call BIS_fnc_selectRandom) call _goodPos;
    };
};

if (count _tppos > 0 && {_tppos distance [0,0,0] > 10}) then {
    _unit setPosATL _tppos;
};
