_allegiance = profileNamespace getVariable ["war_allegiance", sideUnknown];

if (_allegiance == west) then {
	player setPos getMarkerPos "respawn_west";
	_grp = createGroup west;
	[player] joinSilent _grp;
	player addUniform "rhsgref_uniform_ERDL";
	player addVest "AAFVest01_l_green";
	player addHeadgear "rhsgref_helmet_pasgt_erdl";
	player addItemToUniform "ACRE_PRC343";
};

if (_allegiance == east) then {
	player setPos getMarkerPos "respawn_east";
	_grp = createGroup east;
	[player] joinSilent _grp;
	player addUniform "LOP_U_UVF_Fatigue_COY_OSW";
	player addVest "AAFVest01_l_khaki";
	player addHeadgear "rhs_6b7_1m";
	player addItemToUniform "ACRE_PRC343";
};