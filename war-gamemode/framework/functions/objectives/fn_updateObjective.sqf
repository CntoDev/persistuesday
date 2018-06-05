/*
 * Author: Highway
 * Updates ownership information of objective.
 *
 * Arguments:
 * 0: objective to update <ARRAY>
 *
 * Return Value:
 * Objective <ARRAY>
 *
 * Example:
 * _objective = [_objective] call war_objectives_fnc_updateObjective;
 *
 * Public: Yes
 */
params [["_objective", [], [[]]]];
_objective params ["_markerName", "_side", "_type"];

_range = 
	switch (_type) do {
		case "TOWN": { 500 };
		case "VILLAGE": { 200 };
		case "FACTORY": { 200 };
	};
	
_units = (getMarkerPos _markerName) nearEntities ["CAManBase", _range/2];
_numberOfDefenders = { side _x == _side } count _units;
_numberWest = { side _x == west } count _units;
_numberEast = { side _x == east } count _units;
_dominantSide = _side;
_objectiveChangedSides = false;

if (_numberWest > _numberEast && _numberWest > 5*_numberOfDefenders) then {
	_dominantSide = west;
	_objectiveChangedSides = true;

	["West seized " + _markerName, "war_objectives", [true, true, true]] call CBA_fnc_debug;
};

if (_numberEast > _numberWest && _numberEast > 5*_numberOfDefenders) then {
	_dominantSide = east;
	_objectiveChangedSides = true;
	
	["East seized " + _markerName, "war_objectives", [true, true, true]] call CBA_fnc_debug;
};

if (_objectiveChangedSides) then {
	["ObjectiveSeized", [_markerName, _dominantSide, _type]] call CBA_fnc_globalEvent;
	[_objective] call war_guards_fnc_sendQRF;
	
	[_objective, _dominantSide] spawn {
		sleep 600; // wait 10 minutes before sending reinforcements
		_this call war_guards_fnc_transportReinforcements;
	};	
	
	[[_markerName, _dominantSide, _type]] call war_map_fnc_updateMarker;	
};

[_markerName, _dominantSide, _type]
