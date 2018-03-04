/*
 * Author: Highway
 * Initializes objectives module.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * objectives = [] spawn war_objectives_fnc_initModule
 *
 * Public: Yes
 */

// global of all objectives
_objectives = profileNamespace getVariable ["war_objectives", []]; // load objectives from profile if saved

if (_objectives isEqualTo []) then {
	// no objectives in profile, initialize from map
	{		
		if (_x find "town_" != -1) then {
			// marker represents town, create new Objective with neutral owner
			_objective = [_x, resistance, "TOWN"];
			_objectives pushBack _objective;
		};
		
		if (_x find "village_" != -1) then {
			// marker represents village, create new Objective with neutral owner
			_objective = [_x, resistance, "VILLAGE"];
			_objectives pushBack _objective;
		};

		if (_x find "factory_" != -1) then {
			// marker represents factory, create new Objective with neutral owner
			_objective = [_x, resistance, "FACTORY"];
			_objectives pushBack _objective;
		};		
	} forEach allMapMarkers;
};

_objectives