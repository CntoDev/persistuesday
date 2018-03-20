/*
 * Author: Highway
 * Returns victorious side. If there is no victorious side returns sideUnknown.
 *
 * Arguments:
 * 0: objectives - <ARRAY>
 *
 * Return Value:
 * Returns victorious side. If there is no victorious side returns sideUnknown. <SIDE>
 *
 * Example:
 * war_victoriousSide = [] call war_objectives_fnc_victorySide;
 *
 * Public: Yes
 */
params [["_objectives", [], [[]]]];
_hasWon = [_objectives] call war_objectives_fnc_hasWon;

_victoriousSide = 
	if (_hasWon) then {
		(_objectives select 0) select 1
	} else {
		sideUnknown
	};

_victoriousSide