/*
 * Author: Commy2, Highway
 * Loads ammo box from cargo.
 *
 * Arguments:
 * 0: ammo box <OBJECT>
 * 1: cargo <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [box, cargo] call war_armory_fnc_loadCargo
 *
 * Public: No
 */
 
params [["_box", objNull, [objNull]], ["_cargoArray", [], [[]]]];

clearWeaponCargoGlobal _box;
clearMagazineCargoGlobal _box;
clearItemCargoGlobal _box;
clearBackpackCargoGlobal _box;

private _fnc_drop = {
	params ["_dummy", "_box", "_fnc_drop"];
	private _attachments = ((_dummy getVariable "CBA_drop") deleteAt 0);

	if (isNil "_attachments") exitWith {
		deleteVehicle _dummy;
	};

	private _weapon = _attachments deleteAt 0;

	_dummy addWeapon _weapon;

	removeAllPrimaryWeaponItems _dummy;
	removeAllHandgunItems _dummy;
	{
		_dummy removeSecondaryWeaponItem _x;
	} forEach secondaryWeaponItems _dummy;

	{
		_dummy addWeaponItem [_weapon, _x];
	} forEach _attachments;

	_dummy action ["DropWeapon", _box, _weapon];

	[{
		!((_this select 0) hasWeapon (_this select 3)) 
	}, {
		_this call (_this select 2);
	}, [_dummy, _box, _fnc_drop, _weapon]] call CBA_fnc_waitUntilAndExecute;
};

{
	private _cargo = _x;	
	_cargo params ["_weapons", "_magazines", "_items", "_backpacks"];

	// weapons
	private _dummy = createAgent ["VirtualMan_F", [0,0,0], [], 0, "NONE"];
	_dummy setVariable ["CBA_drop", _weapons];

	[_dummy, _box, _fnc_drop] call _fnc_drop;

	// magazines
	{
		_box addMagazineAmmoCargo [_x select 0, 1, _x select 1];
	} forEach _magazines;

	// items
	{
		_box addItemCargoGlobal [_x, 1];
	} forEach _items;
	
	// backpacks
	{
		_box addBackpackCargoGlobal [_x, 1];
	} forEach _backpacks;
} forEach _cargoArray;

