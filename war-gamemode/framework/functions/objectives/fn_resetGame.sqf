/*
 * Author: Highway
 * Resets game and deletes saved state.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call war_objectives_fnc_resetGame
 *
 * Public: Yes
 */
profileNamespace setVariable ["war_objectives", nil];
profileNamespace setVariable ["war_armories", nil];
profileNamespace setVariable ["war_allegiance",nil];
profileNamespace setVariable ["war_time", nil];