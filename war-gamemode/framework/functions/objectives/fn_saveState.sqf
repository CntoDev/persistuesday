/*
 * Author: Highway
 * Saves objectives module data to profileNamespace on the server.
 *
 * Arguments:
 * 0: objectives - <ARRAY>
 *
 * Return Value:
 * None.
 *
 * Example:
 * [] call war_objectives_fnc_saveState;
 *
 * Public: Yes
 */

params [["_objectives", [], [[]]]];
_objectives = profileNamespace setVariable ["war_objectives", _objectives]; 