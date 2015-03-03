
if (!isServer) exitWith {
    [[FP_clientUID] ,"FP_jrm_playerDied",false, false] call BIS_fnc_MP;
};

_uid = [_this, 0, "", [""]] call BIS_fnc_param;
if (_uid == "") exitWith {["Faulty UID received"] call BIS_fnc_error};

if  (time > 1 && {!(_uid in FP_jrm_deadPlayers)}) then  {
    FP_jrm_deadPlayers pushback _uid;
};
