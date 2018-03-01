params ["_unit"];

_unit addAction ["Recruit", {
	params ["_unit", "_recruiter", "_actionId"];	
	[_unit] join (group _recruiter);
}];