/*
 * Author: Highway
 * Deletes soldiers and vehicle in which they are.
 *
 * Arguments:
 * 0: list of soldiers <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [thisList] call war_guards_fnc_deleteVehicle;
 *
 * Public: No
 */

params ["_units"];

{
	if (vehicle _x != _x) then {
		deleteVehicle vehicle _x;
	};
	
	deleteVehicle _x;
} forEach _units;