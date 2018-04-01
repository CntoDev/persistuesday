/*
 * Author: Highway
 * Factories produce ammo and vehicles.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call war_factory_fnc_produce;
 *
 * Public: Yes
 */
 
private _ammoCacheCargo = [ammo_cache_template] call war_armory_fnc_getCargo;

{		
	if (_x find "_ammo" != -1) then {
		// marker represents ammo factory, create new ammo box
		_box = (typeOf ammo_cache_template) createVehicle (getMarkerPos _x);
		[_box, _ammoCacheCargo] call war_armory_fnc_loadCargo;
	};
	
	if (_x find "_vehicle" != -1) then {
		selectRandom ["rhs_btr70_msv", "rhs_btr80_msv", "rhs_bmp1_msv", "rhs_bmp2_msv", "rhssaf_army_t72s", "RHS_BM21_MSV_01"] createVehicle getMarkerPos _x;
	};
} forEach allMapMarkers;
