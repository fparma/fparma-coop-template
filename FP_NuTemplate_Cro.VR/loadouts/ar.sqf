params ["_unit", "_type"];

_unit addBackpack "ACE_FakeBackpack";
_unit addMagazine "100Rnd_65x39_caseless_mag";
_unit addWeapon "arifle_MX_SW_pointer_F";
_unit addPrimaryWeaponItem "acc_pointer_IR";
_unit addPrimaryWeaponItem "bipod_01_F_snd";

_unit addMagazine "16Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
removeBackpack _unit;

_unit addHeadgear "H_HelmetB_grass";
_unit forceAddUniform "U_B_CombatUniform_mcam_tshirt";
_unit addVest "V_PlateCarrier2_rgr";
_unit addBackpack "B_AssaultPack_rgr";
clearAllItemsFromBackpack _unit;
{_unit linkItem _x} forEach ["ItemMap","ItemCompass","ItemWatch","NVGoggles"];

{_unit addItemToUniform "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
{_unit addItemToUniform "ACE_morphine"} count [1,2,3];
_unit addItemToUniform "ACE_epinephrine";
_unit addItemToUniform "ACE_Flashlight_MX991";
_unit addItemToUniform "HandGrenade";

{_unit addItemToVest "100Rnd_65x39_caseless_mag"} count [1,2,3,4];
{_unit addItemToVest "16Rnd_9x21_Mag"} count [1,2];
_unit addItemToVest "Chemlight_green";
_unit addItemToVest "HandGrenade";
_unit addItemToVest "SmokeShell";

/*LONG HAUL KIT*/
{_unit addItemToBackpack "ACE_morphine"} count [1,2,3];
_unit addItemToBackpack "ACE_epinephrine";
{_unit addItemToBackpack "ACE_fieldDressing"} count [1,2,3,4,5,6,7,8];
{_unit addItemToBackpack "100Rnd_65x39_caseless_mag_Tracer"} count [1,2,3,4];
{_unit addItemToBackpack "HandGrenade"} count [1,2];
_unit addItemToBackpack "16Rnd_9x21_Mag";
/*LONG HAUL KIT*/

_unit addItemToUniform "ItemRadio";
