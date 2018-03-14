/*
 * Author: Highway
 * Recruits unit for a side if not already recruited.
 *
 * Arguments:
 * 0: unit <Object>
 * 1: side <Side>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player, west] call war_recruitment_fnc_recruitUnit;
 *
 * Public: Yes
 */
params ["_soldier", "_side"];

_existingAllegiance = profileNamespace getVariable ["war_allegiance", sideUnknown]; // executed on client's machine

if (_existingAllegiance == sideUnknown) then {
	profileNamespace setVariable ["war_allegiance", _side];
	_grp = createGroup _side;
	[_soldier] joinSilent _grp;
	hint format ["You have joined side %1", _side];
} else {
	if (_side != _existingAllegiance) then {
		hint "You can't switch allegiance!";
	} else {
		hint "You have already joined side.";
	};
};