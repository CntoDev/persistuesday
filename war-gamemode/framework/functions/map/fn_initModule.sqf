/*
 * Author: Highway
 * Initializes map module drawing markers on the map.
 *
 * Arguments:
 * 0: list of objectives <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] spawn war_map_fnc_initModule
 *
 * Public: Yes
 */
params [["_objectives",[],[[]]]];

{
	[_x] call war_map_fnc_updateMarker;
} forEach _objectives;