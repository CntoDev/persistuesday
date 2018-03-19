/*
 * Author: Highway
 * Initializes armory module. Locks the warehouse and vehicles. Adds unlock ability to commander.
 *
 * Arguments:
 *
 *
 * Return Value:
 * List of armories <ARRAY>
 *
 * Example:
 * war_armories = [] call war_armory_fnc_initModule
 *
 * Public: Yes
 */
 
_armories = profileNamespace getVariable ["war_armories", []];  // load saved state from server profile
_range = 100;

if (_armories isEqualTo []) then {
	{
		_x params ["_markerName","_side"];
		_ammoBoxes = (getMarkerPos _markerName) nearEntities ["ReammoBox_F", _range];
		_vehicles =  (getMarkerPos _markerName) nearEntities [["Car_F", "Tank_F", "Helicopter_Base_F"], _range];
		
		_armories pushBack [
			_markerName, 
			_side, 
			_ammoBoxes apply {
				[typeOf _x, getPos _x, [_x] call war_armory_fnc_getCargo]
			},
			_vehicles apply {
				[typeOf _x, getPos _x, getDir _x]
			} // create array of vehicles
		]; // adds armory	
	} forEach [
		["respawn_west", west],
		["respawn_east", east]
	];
} else {
	{
		private _armory = _x;
		
		_armory params ["_markerName","_side", "_ammoBoxes", "_vehicles"];
		_3denAmmoBoxes = (getMarkerPos _markerName) nearEntities ["ReammoBox_F", _range];
		_3denVehicles =  (getMarkerPos _markerName) nearEntities [["Car_F", "Tank_F", "Helicopter_Base_F"], _range];

		// delete 3DEN placed ammo boxes and objects
		{
			deleteVehicle _x;
			sleep 0.5;
		} forEach (_3denAmmoBoxes + _3denVehicles);
		
		// create ammo boxes
		{
			[_x] call war_armory_fnc_createBox;
		} forEach _ammoBoxes;
		
		// create empty vehicles
		{
			_x params ["_vehicleType", "_vehiclePosition", "_vehicleDir"];
			
			private _vehicle = createVehicle [_vehicleType, _vehiclePosition, [], 0, "CAN_COLLIDE"];
			_vehicle setDir _vehicleDir;
			
			sleep 2;
			// TODO lock vehicles
		} forEach _vehicles;
	} forEach _armories;
};

// TODO assign commander role
// TODO lock buildings

_armories