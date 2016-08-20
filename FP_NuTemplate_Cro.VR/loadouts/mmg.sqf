params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "130Rnd_338_Mag";
_unit addWeapon "MMG_02_sand_F";
_unit addPrimaryWeaponItem "bipod_01_F_snd";
_unit addPrimaryWeaponItem "acc_pointer_IR";
removeBackpack _unit;

_unit addHeadgear "H_HelmetB_grass";
_unit forceAddUniform "U_B_CombatUniform_mcam_tshirt";
_unit addVest "V_PlateCarrier2_rgr";
_unit addBackpack "B_AssaultPack_rgr";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemCompass","ItemWatch","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
{_unit addItemToUniform "ACE_morphine"} count [1,2,3];
_unit addItemToUniform "ACE_epinephrine";
_unit addItemToUniform "ACE_Flashlight_MX991";

{_unit addItemToVest "130Rnd_338_Mag"} count [1,2];
/*LONG HAUL KIT*/
{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
_unit addItemToBackpack "ACE_epinephrine";
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3];
/*LONG HAUL KIT*/
_unit addItemToBackpack "130Rnd_338_Mag";

_unit addItemToUniform "ItemRadio";
