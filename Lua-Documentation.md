# Lua documentation for KCNet ReVC

This will be a list of functions that I currently have setup in my lua scripts

Anytime I say namespaces I normally mean tables in lua.

The values below that are in tables like this, are using CVectors, so they require the x, y, and z parameters or it won't work.

```lua
start_fire({x = 25, y = 25, z = 25})
```

Anything that I have with `DISABLED` in the description below, is a function that is not working yet or unused.

**List of clothes**

This is a list of clothes for the `player.set_clothes` function and a usage for it.

```lua
-- For now, this has to match with exact case and spacing to work.
	-- "Sonny Forelli", 	"Alex Shrub"
	-- "Lance Normal", 		"Lance Cop", 		"Lance Beaten Up"
	-- "Candy Suxxx", 		"Colonel Cortez",    "Ricardo Diaz"
	-- "Dick (Lovefist)", 	"Gonzalez",      "Hilary"
	-- "Hilary (Bank Mission)",		"Jezz Torrent",  	"Ken Rosenberg"
	-- "Mercedes",				"Mercedes (purple dress)",    "Cam Jones"
	-- "Cam Jones (Bank Mission)"		"Percy (Lovefist)
	-- "Phil (Injured)",	 "Phil (Bank Mission)", 		"Phil Cassidy"

	-- Misc
	-- "Chef" 	"Fsfa",		 "Courier"
	-- "Sgc", 	"Psycho", 	"Striper"
    -- Usage
-- player.change_clothes("Sonny Forelli")

```

**Blip namespace**

**Game namespace**

| Function | Description | Usage |
| ----- | ---- | ----- |
| game.cheat | This is a basic cheat code test. | game.cheat("KILLME") -- Kills the player |
| game.set_hospital_respawn | Sets a wasted respawn point. | game.set_hospital_respawn({x = 25, y = 25, z = 25}) |
| game.set_police_respawn | Sets a busted respawn point. | game.set_police_respawn({x = 25, y = 25, z = 25}) |
| game.start_fire | Start a fire at the specified location. | game.start_fire({x = 25, y = 25, z = 25}) |
| game.pass_time | Pass the specified time, mostly for wasted and busted scripts. | game.pass_time(720) |
| game.set_time | Set the game time to the specified hour and minute. | game.set_time(10, 55) |
| game.set_time_scale | Set the time scale to the specified value, this is untested. | game.set_time_scale(1) |
| game.add_explosion | Add an explosion at the specified coords, if parameter 2 is true it enables the explosion sound. | game.add_explosion({x = 25, y = 25, z = 25}, true) |

**Player namespace**

Any functions without a usage below are just getter or setter functions and don't take any parameters.

<!-- TODO Implement this -->
<!-- | player.get_position | | | -->


| Function | Description | Usage |
| ----- | ---- | ----- |
| player.create | Create the player, mostly for the game init since my scripts take over and don't run the CREATE_PLAYER functions. | player.create(0, {x = 25, y = 25, z = 25}, ) |
| player.set_position | Set the players position. | player.set_position({x = 25, y = 25, z = 25}) |
| player.get_health | Get the players current health  | |
| player.get_position | Get the players current position, access with either `x`, `y` or `z` values.  | player.get_position().x |
| player.heal | Set the players health to max |  |
| player.set_never_wanted | Toggle never wanted. | player.set_never_wanted(true)  |
| player.set_infinite_health | Toggle infinite health. |  player.set_infinite_health(true) |
| player.set_respawn_point | Set the players respawn point. | |
| player.cancel_override_restart | Cancel an override restart point. | |
| player.lose_weapons_on_death | Toggle losing weapons on death. | player.lose_weapons_on_death(true)  |
| player.disable_lose_weapons_on_death | Disable losing weapons on death. | |
| player.log_coords | Log the players coordinates | |
| player.log_heading | Log the players heading. | |
| player.kill_wanted | Kill player if they have a wanted level of 1 star or more. | |
| player.kill | Kills the player | |
| player.is_alive | Check if the player is alive. | |
| player.change_clothes | Change the players clothes | player.change_clothes() |
| player.get_wanted_level | Get the players current wanted level | |
| player.tp_to_marker | Teleport the player to the marker if there is one set on the map. | |


**Vehicle namespace**

| Function | Description | Usage |
| ----- | ---- | ----- |
| vehicle.create | Spawn a vehicle for the player | vehicle.create(vehicle_id, {x = 25, y = 25, z = 25}, deleteLastVehicle, warpIntoVehicle) |
| vehicle.freze_position | Toggle for frezing the vehicles position | vehicle.freeze_position(true) |

**World namespace**
| Function | Description | Usage |
| ----- | ---- | ----- |
| world.blow_up_all_vehicles | Blow up all vehicles near the player. | |
| world.switch_roads_off | Turn the roads off in the area. | world.switch_roads_off({x = 25, y = 25, z = 25}, {x = 50, y = 50, z = 50}) |
| world.switch_roads_on | Turn the roads on in the area. | world.switch_roads_on({x = 25, y = 25, z = 25}, {x = 50, y = 50, z = 50}) |
| world.set_ped_density | Set the ped density, takes a value between 0 and 1.0 | |
| world.set_vehicle_density | Set the vehicle density, takes a value between 0 and 1.0 | |
