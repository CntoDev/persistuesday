waitUntil { time > 0 };

if (!didJIP && isMultiplayer) then {
	cutText ["", "BLACK FADED", 10e10];  
	["STHud_Settings_HUDMode",0] call CBA_settings_fnc_set; // disable sthud temporarily 
	enableSentences false;

	sleep 5;

	_titleText = composeText [
		parseText "<t size='2' align='center' font='PuristaMedium'>War</t>",
		lineBreak,
		parseText "<t size='0.8' align='center' font='PuristaMedium'>on Malden</t>"
	];

	playMusic "LeadTrack01c_F";
	sleep 3;

	[_titleText,0,0.4,5,3,0,789] spawn BIS_fnc_dynamicText;

	sleep 8;		

	cutText ["", "BLACK IN",10];
	sleep 30;

	["STHud_Settings_HUDMode",3] call CBA_settings_fnc_set; // re-enable sthud
	enableSentences true;
};

enableEngineArtillery false;  // disable artillery computer

if (hasInterface) then {
	_createBaseMarker = {
		params ["_side"];
		
		if (_side == sideUnknown) exitWith {};
		
		private _respawnMarker = 
			switch (_side) do {
				case east: { "respawn_east" };
				case west: { "respawn_west" };
			};
			
		_markerBase = createMarkerLocal ["base_local", getMarkerPos _respawnMarker];
		_markerBase setMarkerShapeLocal "ICON";
		_markerBase setMarkerTypeLocal "hd_start";
		_markerBase setMarkerTextLocal "Base";
	};
	
	recruiter_east addAction ["Join prorussian rebels", {
		private _soldier = param [1];
		[_soldier, east] call war_recruitment_fnc_recruitUnit;
	}];

	recruiter_west addAction ["Join proamerican rebels", {
		private _soldier = param [1];
		[_soldier, west] call war_recruitment_fnc_recruitUnit;
	}];
	
	private _existingAllegiance = profileNamespace getVariable ["war_allegiance", sideUnknown]; // executed on client's machine	
	[_existingAllegiance] call war_recruitment_fnc_createBaseMarker;
	
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups; // Initializes the player/client side Dynamic Groups framework	
};

