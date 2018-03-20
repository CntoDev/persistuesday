/*
 * Author: Highway
 * Gets cargo contents from ammo box.
 *
 * Arguments:
 * 0: ammo box <OBJECT>
 *
 * Return Value:
 * Cargo <ARRAY>
 *
 * Example:
 * [box] call war_armory_fnc_getCargo
 *
 * Public: No
 */

params [["_box", objNull, [objNull]]];
private "_subcontainerContents";

private _result = [
	[ weaponsItemsCargo _box, magazinesAmmoCargo _box, itemCargo _box, backpackCargo _box ]
];

{
	private _subcontainer = _x;
	_subcontainer params ["_className", "_entity"];	
	_subcontainerContents = [ weaponsItemsCargo _entity, magazinesAmmoCargo _entity, itemCargo _entity, backpackCargo _entity ];
	_result pushBack _subcontainerContents;
} forEach everyContainer _box;

_result