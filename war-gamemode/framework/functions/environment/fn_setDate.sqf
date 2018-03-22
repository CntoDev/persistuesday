/*
 * Author: Highway
 * Moves date by 8 hours from last event.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call war_environment_fnc_setDate
 *
 * Public: Yes
 */

_time = profileNamespace getVariable ["war_time", []];

if (_time isEqualTo []) then {
	_time = date;
} else {
	setDate _time;
	skipTime 8;
	_time = date;
};