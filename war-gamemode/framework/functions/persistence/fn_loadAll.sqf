PSE_repository = profileNamespace getVariable ["PSE_repository", []];

private ["_entityData", "_entity"];

_loadEntity = {
	params ["_object", "_damage", "_pos", "_dir"];
	_object setPos _pos;
	
	if (_damage == 1) then {
		_object setVariable ["ace_cookoff_enableAmmoCookoff", false];
	};
	
	_object setDamage [_damage, false];
	["ace_common_setDir", [_object, _dir]] call CBA_fnc_localEvent;
};

{
	private _id = _x getVariable ["id", -1];
	
	if (_id != -1) then {
		_entity = [_x];
		_entityData = [PSE_repository, _id] call CBA_fnc_hashGet;
		_entity append _entityData;
		_entity call _loadEntity;
	};
} forEach entities "AllVehicles";

{
	private _id = _x getVariable ["id", -1];
	
	if (_id != -1) then {
		_entity = [_x];
		_entityData = [PSE_repository, _id] call CBA_fnc_hashGet;
		_entity append _entityData;
		_entity call _loadEntity;
		[_x, _entityData select 3] call PSE_fnc_loadCargo;
	};
} forEach entities "ReammoBox_F";