/*
 * Author: Highway
 * Creates ammo box
 *
 * Arguments:
 * 0: ammo box <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [box] call war_armory_fnc_createBox
 *
 * Public: No
 */

params [["_box", [], [[]], 3]];
_box params ["_type", "_pos", "_cargo"];

_boxObject = _type createVehicle _pos;
[_boxObject, _cargo] call war_armory_fnc_loadCargo;
