/*should be #include'd in all scripts at the end. this will be "inserted" into those scripts and add common items near the end of the script since we need containers*/
{
	if (_x == "NVGoggles") then {
		if !(daytime > 7 && daytime < 20) then {
			_unit linkItem _x;
		};
	}else{
		_unit linkItem _x;
	};
}forEach _STANDARD_ITEMS;

// Medical
if (isClass (configFile >> "CfgPatches" >> "AGM_Medical")) then {
	{_unit addItem _x} forEach ["AGM_bandage","AGM_bandage", "AGM_Morphine"];
}else{
	_unit addItem "FirstAidKit";
};