# War game mode technical design document

## Game mechanics

Special types are listed in chapter about Game Object Data. Here we list modules, module responsibility and API that defines them.

### Recruitment module

Responsible for handling faction selection by non-aligned new players.

Prefix: ``war_recruitment``

API

	[unit, side] call war_recruitment_fnc_recruitUnit 
		- recruits unit to side for duration of entire campaign.
		
	[side] call war_recruitment_fnc_createBaseMarker
		- draws the Blufor or Opfor base marker for a soldier.
	
### Guards module

Responsible for creation of guards, control of guards via waypoints or CBA functions.

Prefix: `war_guards`

API

	[objectives] spawn war_guards_fnc_initModule
		- initializes module
		
	[Objective, side] spawn war_guards_fnc_transportReinforcements
		- spawns reinforcements of the side and transports them towards objective. Reinforcements deploy and start with guard duty.
	
	[] call war_guards_fnc_getGuardData
		- returns types of guard data in array

	[units] call war_guards_fnc_deleteVehicle
		- deletes soldiers and vehicle in which they are for a specified unit.

### Armory module

Initialized armory on event start, saves contents of it periodically, locks vehicles and doors, enables armory commander to unlock vehicles and doors.

Prefix: `war_armory`

API
	
	[Armory] = [] spawn war_armory_fnc_initModule
		- initializes module from profile or map
		
	[Armory] = [[Armory]] call war_armory_fnc_saveState
		- updates array of armories and saves state to server profile namespace	

	[Box] call war_armory_fnc_createBox
		- creates an ammo box with associated Cargo
		
	Cargo = [box] call war_armory_fnc_getCargo		
		- gets cargo of the box
		
	[box, Cargo] call war_armory_fnc_loadCargo
		- loads cargo into the box
	
### Factories module

Periodically reproduce new weapons, ammo, equipment and vehicles.

Prefix: `war_factories`

API
	
	[Factory] spawn war_factories_fnc_produce
		- produces gear across the map on start of the day according to equipment production table

### Objectives module

Manages ownership of the objectives (towns, villages and factories).

Prefix: `war_objectives`

API

	[Objective] = [] spawn war_objectives_fnc_initModule
		- initializes module
		
	[] call war_objectives_fnc_resetGame
		- resets game and deletes saved state
		
	boolean = [] call war_objectives_fnc_hasWon	
		- returns true if any side has achieved final victory
		
	side = [] call war_objectives_fnc_victorySide	
		- returns side that won. If game didn't end returns sideUnknown
		
	[Objective] call war_objectives_fnc_updateObjective
		- updates Objective state. In case Objective has changed ownership NPC from opposite faction will be called out to guard the objective.
		
	[] call war_objectives_fnc_updateAllObjectives
		- updates the ownership information on all objectives
		
	[] call war_objectives_fnc_saveState
		- saves the state of all objectives to server profile

### Map module

Updates the strategic map.

Prefix: `war_map`

API

	[[Objective]] call war_map_fnc_initModule
		- initializes module
		
	[Objective] call war_map_fnc_updateMarker
		- updates the map ownership of the Objective
		
### Environment Module

Fixes the time offset from last event

Prefix: `war_environment`

API

	[] call war_environment_fnc_setDate
		- Moves date 8 hours forward
		
## External Code

This framework uses CBA and ACE frameworks. Map implementations may use objects from different mods.

## Control Loop

Control loop is initialized in initServer.sqf. It has update frequency of 120 seconds. Initally control loop calls initializing functions of modules. Then it updates the state of objectives on every click. World state data will be autosaved every 15 minutes.

## Game Object Data

Common API objects are used as array of attributes. They are listed below.

	Objective:
		markerName - string - name of the objective marker
		faction - side - side controlling the objective
		type - string - type of the objective. Can be "TOWN", "VILLAGE", "FACTORY"
		
	Factory:
		markerName - string - name of the factory marker
		side - side - factory ownership		

	Armory:
		markerName - string - name of the armory marker
		side - side - side of armory
		boxes - array of Box - supply boxes and their contents
		vehicle - array of Vehicle - vehicles
		
	Box:
		type - string - class name of the box
		position - position - position of the box
		cargo - Cargo - cargo of the box
		
	Cargo:
		weapons - array of Weapon
		magazines - array of Magazine
		items - array of Item
		backpacks - array of Backpack
		
	Vehicle:
		type - string - class name
		position - position - position of vehicle
			
## Data Flow

Mission important data will be stored in the server profile. 

1. All objectives (war_objectives) - array of all Objective types.
2. All armories - array of all Armory types (here is the "loot")

Player profile will contain only faction he enlisted for.

### Important global vars

war_objectives - array of all objectives.
war_armories - array of all armories.

## Mission parameters

TODO

## Artificial Intelligence

TODO

## User Interface

NA

## Art and Video

NA

## Sound and Music

NA

## Map port considerations

Town markers should be named with `town_` prefix:

```
town_larche
town_latrinite
town_chapoi
```

Village markers with `village_` prefix:

```
village_arudy
village_lapessagne
village_lariviere
village_lolisse
village_leport
```

Factory markers with `factory_<name>` and `factory_<name>_ammo`. Ammo objective serves for spawning gear and ammo produced by factory. 

```
factory_lavalle_ammo
factory_lavalle
factory_corton_ammo
factory_corton
factory_saint_vehicle
factory_saint
```

Recruitment centers should be named like below:

```
recruitment_east
recruitment_west
```

Reinforcements spawn at `transport_east` and `transport_west` markers.
