[] spawn {
	_missionEnded = false;

	war_objectives = [] call war_objectives_fnc_initModule;
	[war_objectives] call war_map_fnc_initModule;
	[war_objectives] spawn war_guards_fnc_initModule;		
	war_armories = [] call war_armory_fnc_initModule;
	
	while { !_missionEnded } do {
		sleep 120;
		["System control loop update", "war_control", [true, true, true]] call CBA_fnc_debug;		
		war_objectives = [war_objectives] call war_objectives_fnc_updateAllObjectives;
		[war_objectives] call war_objectives_fnc_saveState;
		war_armories = [war_armories] call war_armory_fnc_saveState;
		_missionEnded = [war_objectives] call war_objectives_fnc_hasWon;		
	};
	
	war_victoriousSide = [war_objectives] call war_objectives_fnc_victoriousSide;
	["GameEnding", [war_victoriousSide]] call CBA_fnc_globalEvent;
	sleep 30;	
	"EveryoneWon" call BIS_fnc_endMissionServer; //TODO - replace with proper ending	
};