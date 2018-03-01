params ["_unit", "_chair"];

if (!local _unit) exitWith {};

private _possibleChairs = [
	["Land_CampingChair_V2_F",[0,-0.2,-0.4],-180],
	["Land_ChairPlastic_F",[0,-0.2,-0.4],-180],
	["Land_ChairWood_F",[0,-0.2,-0.4],-180]
];

private _snappingPoint = [];
private _azimuthFix = 0;
private _isChair = false;

{
	if (typeOf _chair == (_x select 0)) then {
		_snappingPoint = _x select 1;
		_azimuthFix = _x select 2;
		_isChair = true;
	};
} forEach _possibleChairs;

{ 
	_unit disableAI _x; 
} forEach ["ANIM","AUTOTARGET","FSM","MOVE","TARGET"];

if (_isChair) then {	
	_unit attachTo [_chair, _snappingPoint];
	_unit setDir _azimuthFix;
	[_unit, "acex_sitting_HubSittingChairA_idle3", 2] call ace_common_fnc_doAnimation;
};