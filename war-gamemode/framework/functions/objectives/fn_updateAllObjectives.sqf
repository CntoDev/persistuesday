/*
 * Author: Highway
 * Updates ownership information of all objectives.
 *
 * Arguments:
 * 0: objectives to update <ARRAY>
 *
 * Return Value:
 * Array of Objective <ARRAY>
 *
 * Example:
 * war_objectives = [war_objectives] call war_objectives_fnc_updateAllObjectives;
 *
 * Public: Yes
 */
params [["_objectives", [], [[]]]];

_objectives = _objectives apply { [_x] call war_objectives_fnc_updateObjective };
_objectives
