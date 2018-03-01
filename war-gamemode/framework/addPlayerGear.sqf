params ["_unit"];

if (dayTime > 17 || dayTime < 7) then {
	_unit linkItem "ACE_NVG_Gen4";
};