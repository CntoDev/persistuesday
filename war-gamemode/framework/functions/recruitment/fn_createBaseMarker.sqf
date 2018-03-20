/*
 * Author: Highway
 * Draws base marker for soldier.
 *
 * Arguments:
 * 0: player side <Side>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call war_recruitment_fnc_createBaseMarker;
 *
 * Public: Yes
 */
params ["_side"];

if (_side == sideUnknown) exitWith {};

private _respawnMarker = 
	switch (_side) do {
		case east: { "respawn_east" };
		case west: { "respawn_west" };
	};
	
_markerBase = createMarkerLocal ["base_local", getMarkerPos _respawnMarker];
_markerBase setMarkerShapeLocal "ICON";
_markerBase setMarkerTypeLocal "hd_start";
_markerBase setMarkerTextLocal "Base";
