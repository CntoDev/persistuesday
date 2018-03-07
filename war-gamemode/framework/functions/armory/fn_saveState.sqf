/*
 * Author: Highway
 * Updates array of armories and saves state to server profile namespace.
 *
 * Arguments:
 * 0: armories <ARRAY>
 *
 * Return Value:
 * Array of armories with fresh state <ARRAY>
 *
 * Example:
 * [[Armory]] call war_armory_fnc_saveState
 *
 * Public: Yes
 */
 
params [["_armories", [], [[]]]];
_updatedArmories = [];

private _updateArmoryContents = {	
	params ["_markerName", "_side"]; // not interested in other two params, we'll refresh it anyway	
	private _range = 100; // TODO move constants somewhere
	
	// take all ammo boxes in range and vehicles that are not completely wrecked (>=0.95 damage)
	private _ammoBoxes = (getMarkerPos _markerName) nearEntities ["ReammoBox_F", _range];
	private _vehicles = ((getMarkerPos _markerName) nearEntities [["Car_F", "Tank_F", "Helicopter_Base_F"], _range]) select { damage _x < 0.95 };
	
	[
		_markerName, 
		_side, 
		_ammoBoxes apply {
			[typeOf _x, getPos _x, [_x] call war_armory_fnc_getCargo]
		}, // array of Box
		_vehicles apply {
			[typeOf _x, getPos _x]
		} // array of Vehicle
	] // returns Armory
};

{
	_updatedArmories pushBack (_x call _updateArmoryContents);
} forEach _armories;

profileNamespace setVariable ["war_armories", _updatedArmories];

_updatedArmories