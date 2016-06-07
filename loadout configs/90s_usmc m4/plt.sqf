#include "sql.sqf"
_unit addItemToBackpack "ACRE_PRC117F";
if (_type == "B_RangeMaster_F") then {
  // zeus
  _unit addHeadgear "CUP_H_PMC_PRR_Headset";
}else {
  _unit addHeadgear "H_Beret_blk";
};
