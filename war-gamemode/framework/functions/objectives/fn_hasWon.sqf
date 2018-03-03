/*
 * Author: Highway
 * Checks if one side has won.
 *
 * Arguments:
 * 0: objectives - <ARRAY>
 *
 * Return Value:
 * True if one side controls all objectives
 *
 * Example:
 * isOver = [war_objectives] call war_objectives_fnc_hasWon;
 *
 * Public: Yes
 */
params [["_objectives", [], [[]]]];
_hasWon = true;

if (count _objectives > 0) then {
	_victoriousSide = (_objectives select 0) select 1; // Objective is [marker, side, type]
	_i = 0;
	
	while { _i < count _objectives && _hasWon} do {
		_currentObjective = _objectives select _i;
		_side = _currentObjective select 1;
		
		if (_side == resistance || _side != _victoriousSide) then {
			_hasWon = false;
		};
		
		_i = _i + 1;
	};
};

_hasWon