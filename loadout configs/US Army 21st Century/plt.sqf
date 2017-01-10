#include "sql.sqf"

_unit addItemToVest "ACRE_PRC152";
if (_type == "B_RangeMaster_F") then {
  // zeus
  _unit addHeadgear "H_MilCap_mcamo";
}else {
  _unit addHeadgear "H_Beret_blk";
};
