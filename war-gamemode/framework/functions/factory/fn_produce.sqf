/*
 * Author: Highway
 * Factories produce ammo and vehicles.
 *
 * Arguments:
 * 0: all objectives <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * [war_objectives] call war_factory_fnc_produce;
 *
 * Public: Yes
 */

params ["_allObjectives"];

_find_objective = {
	params ["_allObjectives", "_markerToFind"];	
	private _objective = [];
	
	{
		_x params ["_markerName", "_controllingSide", "_objectiveType"];
		
		if (_markerName == _markerToFind) then {
			_objective = _x;
		};
	} forEach _allObjectives;
	
	_objective
};
 
private _ammoCacheCargo = [ammo_cache_template] call war_armory_fnc_getCargo;
private _ammoCacheCargoWest = [ammo_cache_template_west] call war_armory_fnc_getCargo;
private _ammoCacheCargoEast = [ammo_cache_template_east] call war_armory_fnc_getCargo;

{		
	if (_x find "_ammo" != -1) then {
		private _objectiveMarkerName = [_x, "_ammo", ""] call CBA_fnc_replace;		
		private _objective = [_allObjectives, _objectiveMarkerName] call _find_objective;
		private _controllingSide = _objective param [1];
		
		switch (_controllingSide) do {
			case resistance: {
				_box = (typeOf ammo_cache_template) createVehicle (getMarkerPos _x);
				[_box, _ammoCacheCargo] call war_armory_fnc_loadCargo;
			};
			case west: {
				_box = (typeOf ammo_cache_template_west) createVehicle (getMarkerPos _x);
				[_box, _ammoCacheCargoWest] call war_armory_fnc_loadCargo;
			};
			case east: {
				_box = (typeOf ammo_cache_template_east) createVehicle (getMarkerPos _x);
				[_box, _ammoCacheCargoEast] call war_armory_fnc_loadCargo;			
			};
		};		
	};
	
	if (_x find "_vehicle" != -1) then {
		selectRandom ["rhs_btr70_msv", "rhs_btr80_msv", "rhs_bmp1_msv", "rhs_bmp2_msv", "rhssaf_army_t72s", "RHS_BM21_MSV_01"] createVehicle getMarkerPos _x;
	};
} forEach allMapMarkers;
