/* 
* Write your briefing here
* <br /> is line break.
* Note that briefings are added bottom-to-top (appears in reverse order)
*/
#include "config_mission.hpp"

// Add credits first
player createDiaryRecord ["Diary", ["Credits", format ["
<font size=16>%1</font><br/>
<font size=13>by %2</font><br/>
<font size=13>on %3</font><br/>
<br/>
FPARMA Mission Template v5.0.0
", CFG_ON_LOAD_TITLE, CFG_AUTHOR, getText (configFile >> "CfgWorlds" >> worldName >> "description")]]];

// Intel
player createDiaryRecord ["Diary",["Intel","
Intel regarding enemy forces, movement<br/>
"]];

// Execution
player createDiaryRecord ["Diary",["Execution","
1) Do objective 1<br/>
2) Hold objective 2<br/>
"]];

// Situation, background
player createDiaryRecord ["Diary",["Situation","
Background/briefing text here, what's going on
"]];
