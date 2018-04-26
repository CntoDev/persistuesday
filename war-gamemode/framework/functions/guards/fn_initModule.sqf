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

private _spawnGroup = {
	params ["_position", "_side", "_unitType"];
	private _group = [_position, _side, _unitType] call BIS_fnc_spawnGroup;
	_group enableDynamicSimulation true;
	
	{
		_x triggerDynamicSimulation false;
	} forEach units _group;
	
	_group
};

private _spawnGuards = {
	params ["_team", "_squad", "_mechTeam"];
	
	switch (_type) do {
		case "TOWN": {
			private _group = [getMarkerPos _markerName, _side, _squad] call _spawnGroup;
			[_group] call CBA_fnc_taskDefend;			
			sleep 3;
			_group = [getMarkerPos _markerName, _side, _squad] call _spawnGroup;
			[_group, _group, 200, 10, "MOVE", "AWARE", "YELLOW", "LIMITED", "COLUMN"] call CBA_fnc_taskPatrol;
		};
		case "VILLAGE": {
			private _group = [getMarkerPos _markerName, _side, _squad] call _spawnGroup;
			[_group] call CBA_fnc_taskDefend;			
		};
		case "FACTORY": {
			private _group = [getMarkerPos _markerName, _side, _squad] call _spawnGroup;
			[_group] call CBA_fnc_taskDefend;			
			sleep 3;
			_group = [getMarkerPos _markerName, _side, _squad] call _spawnGroup;
			[_group, _group, 200, 10, "MOVE", "AWARE", "YELLOW", "LIMITED", "COLUMN"] call CBA_fnc_taskPatrol;
		};
	};
};

// load default guard group types
([] call war_guards_fnc_getGuardData) params ["_westInfantrySquad", "_westInfantryFireteam", "_eastInfantrySquad", "_eastInfantryFireteam", "_resistanceInfantrySquad", "_resistanceInfantryFireteam", "_westMechanizedSquad", "_eastMechanizedSquad", "_resistanceMechanizedSquad"];

{
	_x params ["_markerName", "_side", "_type"];
	
	switch (_side) do {
		case west: {
			[_westInfantryFireteam, _westInfantrySquad, _westMechanizedSquad] call _spawnGuards;
		};
		case east: {
			[_eastInfantryFireteam, _eastInfantrySquad, _eastMechanizedSquad] call _spawnGuards;
		};
		case resistance: {		
			[_resistanceInfantryFireteam, _resistanceInfantrySquad, _resistanceMechanizedSquad] call _spawnGuards;
		};
	};
} forEach _objectives;