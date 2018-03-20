_allegiance = profileNamespace getVariable ["war_allegiance", sideUnknown];

if (_allegiance == west) then {
	player setPos getMarkerPos "respawn_west";
	_grp = createGroup west;
	[player] joinSilent _grp;
	player addUniform "rhs_uniform_cu_ocp";
};

if (_allegiance == east) then {
	player setPos getMarkerPos "respawn_east";
	_grp = createGroup east;
	[player] joinSilent _grp;
	player addUniform "rhs_uniform_msv_emr";
};