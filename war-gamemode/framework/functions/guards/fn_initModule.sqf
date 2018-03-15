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
	_group
};

// load default guard group types
([] call war_guards_fnc_getGuardData) params ["_westInfantrySquad", "_westInfantryFireteam", "_eastInfantrySquad", "_eastInfantryFireteam", "_resistanceInfantrySquad", "_resistanceInfantryFireteam"];

{
	_x params ["_markerName", "_side", "_type"];
	
	switch (_side) do {
		case west: {
			_group = [getMarkerPos _markerName, west, _westInfantrySquad] call _spawnGroup;
			[_group] call CBA_fnc_taskDefend;			
			sleep 3;
			_group = [getMarkerPos _markerName, west, _westInfantryFireteam] call _spawnGroup;
			[_group, _group, 200, 10, "MOVE", "AWARE", "YELLOW", "LIMITED", "COLUMN"] call CBA_fnc_taskPatrol;
		};
		case east: {
			_group = [getMarkerPos _markerName, east, _eastInfantrySquad] call _spawnGroup;
			[_group] call CBA_fnc_taskDefend;
			sleep 3;
			_group = [getMarkerPos _markerName, east, _eastInfantryFireteam] call _spawnGroup;
			[_group, _group, 200, 10, "MOVE", "AWARE", "YELLOW", "LIMITED", "COLUMN"] call CBA_fnc_taskPatrol;
		};
		case resistance: {		
			_group = [getMarkerPos _markerName, resistance, _resistanceInfantrySquad] call _spawnGroup;
			[_group] call CBA_fnc_taskDefend;
			sleep 3;
			_group = [getMarkerPos _markerName, resistance, _resistanceInfantryFireteam] call _spawnGroup;
			[_group, _group, 200, 10, "MOVE", "AWARE", "YELLOW", "LIMITED", "COLUMN"] call CBA_fnc_taskPatrol;
		};
	};
} forEach _objectives;