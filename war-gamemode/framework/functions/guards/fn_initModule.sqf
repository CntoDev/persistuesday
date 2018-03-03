/*
 * Author: Highway
 * Initializes guards module. Creates NPC guards on objectives.
 *
 * Arguments:
 * 1: array of Objective
 *
 * Return Value:
 * None
 *
 * Example:
 * [] spawn war_guards_fnc_initModule
 *
 * Public: Yes
 */
params [["_objectives", [], [[]]]]; 

_westInfantrySquad = configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_infantry" >> "rhs_group_nato_usarmy_d_infantry_squad";
_westInfantryFireteam = configfile >> "CfgGroups" >> "West" >> "rhs_faction_usarmy_d" >> "rhs_group_nato_usarmy_d_infantry" >> "rhs_group_nato_usarmy_d_infantry_team";

_eastInfantrySquad = configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_squad";
_eastInfantryFireteam = configfile >> "CfgGroups" >> "East" >> "rhs_faction_msv" >> "rhs_group_rus_msv_infantry_emr" >> "rhs_group_rus_msv_infantry_emr_fireteam";

_resistanceInfantrySquad = configfile >> "CfgGroups" >> "Indep" >> "rhssaf_faction_army" >> "rhssaf_group_army_m10_digital_infantry" >> "rhssaf_group_army_m10_digital_infantry_squad";
_resistanceInfantryFireteam = configfile >> "CfgGroups" >> "Indep" >> "rhssaf_faction_army" >> "rhssaf_group_army_m10_digital_infantry" >> "rhssaf_group_army_m10_digital_infantry_team";

{
	_x params ["_markerName", "_side", "_type"];
	
	switch (_side) do {
		case west: {
			_group = [getMarkerPos _markerName, west, _westInfantrySquad] call BIS_fnc_spawnGroup;
			[_group] call CBA_fnc_taskDefend;
			sleep 3;
			_group = [getMarkerPos _markerName, west, _westInfantryFireteam] call BIS_fnc_spawnGroup;
			[_group, _group, 200, 10, "MOVE", "AWARE", "YELLOW", "LIMITED", "COLUMN"] call CBA_fnc_taskPatrol;
		};
		case east: {
			_group = [getMarkerPos _markerName, east, _eastInfantrySquad] call BIS_fnc_spawnGroup;
			[_group] call CBA_fnc_taskDefend;
			sleep 3;
			_group = [getMarkerPos _markerName, east, _eastInfantryFireteam] call BIS_fnc_spawnGroup;
			[_group, _group, 200, 10, "MOVE", "AWARE", "YELLOW", "LIMITED", "COLUMN"] call CBA_fnc_taskPatrol;
		};
		case resistance: {		
			_group = [getMarkerPos _markerName, resistance, _resistanceInfantrySquad] call BIS_fnc_spawnGroup;
			[_group] call CBA_fnc_taskDefend;
			sleep 3;
			_group = [getMarkerPos _markerName, resistance, _resistanceInfantryFireteam] call BIS_fnc_spawnGroup;
			[_group, _group, 200, 10, "MOVE", "AWARE", "YELLOW", "LIMITED", "COLUMN"] call CBA_fnc_taskPatrol;
		};
	};
} forEach _objectives;