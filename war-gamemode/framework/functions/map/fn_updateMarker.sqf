/*
 * Author: Highway
 * Updates the map marker
 *
 * Arguments:
 * 0: objective <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [objective] call war_map_fnc_updateMarker
 *
 * Public: No
 */
params ["_objective"];

_objective params ["_marker", "_side", "_type"];

_markerType = switch (_type) do {
	case "TOWN": { "_hq" };
	case "VILLAGE": { "_inf" };
	case "FACTORY": { "_service" };
};

_markerSide = switch (_side) do {
	case west: { "b" };
	case east: { "o" };
	case resistance: { "n" };
};

_marker setMarkerShape "ICON";
_marker setMarkerType format ["%1%2", _markerSide, _markerType];