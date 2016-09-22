/*
    Author: Cuel

    Description:
    Uses CBA DisplayLoad XEH to override the arsenal export button

*/

#define ID 909053
#include "\A3\Ui_f\hpp\defineResinclDesign.inc"

[{
  params ["_display"];
  disableSerialization;
  private _oldBtn = (_display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_BUTTONEXPORT);
  private _btn = _display ctrlCreate ["RscButton", ID, (_display displayCtrl IDC_RSCDISPLAYARSENAL_CONTROLSBAR_CONTROLBAR)];

  _btn ctrlSetPosition (ctrlPosition _oldBtn);
  _btn ctrlSetScale (ctrlScale _oldBtn);
  _btn ctrlSetEventHandler ["buttonclick", "[] call FP_fnc_copyAllGear"];
  _btn ctrlSetText ("(FP) " + ctrlText _oldBtn);
  _oldBtn ctrlShow false;
  _btn ctrlCommit 0;
}, _this] call CBA_fnc_execNextFrame;
