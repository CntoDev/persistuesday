/*
 * Author: Highway
 * Returns types of guard data in array.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Array of guard data in format [west infantry defend, west infantry patrol, east infantry defend, east infantry patrol, resistance infantry defend, resistance infantry patrol] <ARRAY>
 *
 * Example:
 * data = [] call war_guards_fnc_getGuardData
 *
 * Public: No
 */
 
_westInfantrySquad = configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_infantry" >> "rhs_group_nato_usarmy_d_infantry_squad";
_westInfantryFireteam = configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_infantry" >> "rhs_group_nato_usarmy_d_infantry_team";

_eastInfantrySquad = configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_squad";
_eastInfantryFireteam = configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_fireteam";

_resistanceInfantrySquad = configfile >> "CfgGroups" >> "Indep" >> "rhssaf_faction_army" >> "rhssaf_group_army_m10_digital_infantry" >> "rhssaf_group_army_m10_digital_infantry_squad";
_resistanceInfantryFireteam = configfile >> "CfgGroups" >> "Indep" >> "rhssaf_faction_army" >> "rhssaf_group_army_m10_digital_infantry" >> "rhssaf_group_army_m10_digital_infantry_team";

[_westInfantrySquad, _westInfantryFireteam, _eastInfantrySquad, _eastInfantryFireteam, _resistanceInfantrySquad, _resistanceInfantryFireteam]