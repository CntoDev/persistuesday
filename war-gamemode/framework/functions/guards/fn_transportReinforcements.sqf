/*
 * Author: Highway
 * Creates guards for newly seized objective somewhere over sea and transports it via heli to new objective. Orders deploying troops to guard the area.
 *
 * Arguments:
 * 1: objective <ARRAY>
 * 2: side <SIDE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [Objective, side] spawn war_guards_fnc_transportReinforcements
 *
 * Public: Yes
 */
params [
	["_objective",[],[[]],3],
	["_side",resistance]
];

([] call war_guards_fnc_getGuardData) params ["_westInfantrySquad", "_westInfantryFireteam", "_eastInfantrySquad", "_eastInfantryFireteam", "_resistanceInfantrySquad", "_resistanceInfantryFireteam"];

(switch (_side) do {
	case east: { ["RHS_Mi8mt_Cargo_vdv", getMarkerPos "transport_east", _eastInfantrySquad] };
	case west: { ["RHS_UH60M2_d", getMarkerPos "transport_west", _westInfantrySquad] };
}) params ["_vehicleClass", "_spawnPosition", "_squad"];

_groupData = [_spawnPosition,0,_vehicleClass,_side] call BIS_fnc_spawnVehicle;
_squadGroup = [_spawnPosition, _side, _squad] call BIS_fnc_spawnGroup; 
_heli = _groupData select 0;

_heliGroup = _groupData select 2;
_heliGroup setVariable ["groupTransported", _squadGroup];

{ _x moveInCargo _heli } forEach units _squadGroup;

_objective params ["_objectiveMarker", "_objectiveSide", "_objectiveType"];

_heliWp0 = _heliGroup addWaypoint [getMarkerPos _objectiveMarker, 100];
_heliWp0 setWaypointType "TR UNLOAD";
_heliWp0 setWaypointStatements ["true", '[(group this) getVariable "groupTransported"] call CBA_fnc_taskDefend;'];

_heliWp1 = _heliGroup addWaypoint [_spawnPosition, 100];
_heliWp1 setWaypointType "MOVE";
_heliWp1 setWaypointStatements ["true", "[thisList] call war_guards_fnc_deleteVehicle;"];