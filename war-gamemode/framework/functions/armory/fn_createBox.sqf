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

_boxObject = createVehicle [_type, _pos, [], 0, "CAN_COLLIDE"];
[_boxObject, _cargo] call war_armory_fnc_loadCargo;
