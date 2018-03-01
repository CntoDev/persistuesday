PSE_repository = [] call CBA_fnc_hashCreate;

{
	private _id = _x getVariable ["id", -1];
	
	if (_id != -1) then {
		[PSE_repository, _id, [ damage _x, getPos _x, getDir _x]] call CBA_fnc_hashSet;
	};
} forEach entities "AllVehicles";

{
	private _id = _x getVariable ["id", -1];
	
	if (_id != -1) then {
		[PSE_repository, _id, [ damage _x, getPos _x, getDir _x, [_x] call PSE_fnc_getCargo]] call CBA_fnc_hashSet;
	};	
} forEach entities "ReammoBox_F";

profileNamespace setVariable ["PSE_repository", PSE_repository];