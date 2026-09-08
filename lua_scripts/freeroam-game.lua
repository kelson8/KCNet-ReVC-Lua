-- This format works with my setup! I had to have a subdirectory for it.
dofile("ViceExtended/lua_scripts/freeroam-locations.lua")

-- Add new enums for freeroam-game.lua
dofile("ViceExtended/lua_scripts/freeroam-enums.lua")

-- Obtained from freeroam-locations.lua
local oldSpawn = GameLocations.oldSpawn
local airport = GameLocations.airport
local policeStation = GameLocations.policeStation
local construction_site = GameLocations.constructionSiteVehicle

---------
--- New, for testing features.
---------

-- Turn phones on
-- TODO Test this later, not sure what this could be used for though
-- game.turn_phone_on()

-- Grab phones
-- game.grab_phone(x, y)

--------
-- REQUIRED
-- If you remove these functions out of the freeroam script you will most likely crash!
-- They are needed for the game to know what to do without the '.scm' scripts.
--------

-----------
-- Globals - These get read from the C++ code for the game scripts.
-- I will try to keep these named like they are in C++.
-- If these are missing the game will probably crash.
-----------

-- true is enabled and false is disabled

-- If this is enabled, vehicles won't catch on fire when upside down.
-- false = vehicles explode when upside down.
-- true = no vehicles explode when upside down.
-- This is in the ini, but I will load it in the freeroam-game.lua script.
gbVehiclesDontCatchFireWhenTurningOver = false


-- If this is enabled, you can reload the lua script with F5 but anytime you press F5 you'll be teleported away.
-- So this can be useful for debugging the script, otherwise you can press new game from the menu to reload the scripts.
gbReloadLuaScriptWithKeybind = true


-- If the position should be displayed on the screen.
-- This can be very useful for debugging.
gbDisplayPosn = false

--------
-- Game Init
-- Runs on game startup
-- TODO Implement this, so I only load stuff like the player once.
-- Currently, I cannot call functions like vehicle.create() in this init script since it only runs once.
-- Although the vehicles will spawn in if I press 'F5' or start a new game to reload the script.

-- TODO Implement reloading the game script itself with 'F5' instead of jumping to a new game.
-- I'll need to fix this OnInit function so it doesn't try to spawn in more player peds or crash.
--------

function OnInit()
	-- TODO Make this function only be allowed in the init, the player should only ever be created once.
	-- Although my code has protections in place so this doesn't run more then once.

	-- Init player, spawn them in.

	-- To find a spawn position, look into the GameLocations table in freeroam-locations.lua.

	-- Spawn at the custom spawn in the middle of the map.
	-- player.create(0, {x = oldSpawn.pos.x, y = oldSpawn.pos.y, z = oldSpawn.pos.z})

	-- Spawn at the airport.
	-- player.create(0, {x = airport.pos.x, y = airport.pos.y, z = airport.pos.z})

	-- Spawn at the police station.
	-- player.create(0, {x = policeStation.pos.x, y = policeStation.pos.y, z = policeStation.pos.z})

	-- Spawn at the construction site.

	-- player.create(0, {x = construction_site.pos.x, y = construction_site.pos.y, z = construction_site.pos.z})
end

-- Spawn in the player, mostly for spawning without the .scm scripts
-- This works in here now!
-------
-- REQUIRED if DISABLE_GAME_SCRIPTS is toggled on in the game code, otherwise it won't spawn the player.
-- Locations are stored in freeroam-locations.lua, and more can be added.
-------

-- This only runs once in the init, if there are more then one of the player.create functions they won't do anything.
-- Fixes some bugs I was having, which was spawning multiple players for me to control lol.

player.create(0, { x = construction_site.pos.x, y = construction_site.pos.y, z = construction_site.pos.z })

----
--- Misc init features
---


-- Silence all game phones, in case they are running
-- TODO Test this, it should work on game start, it doesn't crash so I'll leave this enabled.
for i = 1, config_enums.eGameLimits.NUMPHONES do
	game.turn_phone_off(i)
end

--------------------
-- These functions are disabled and currently crash
--------------------

-- Setup some respawn points, I'm quite sure a max of 8 can be set.
-- TODO Setup a random number generator for random spawns, I could just do it in the lua scripts.

-----
-- Respawns when wasted
-----

-- game.set_hospital_respawn({x = oldSpawn.pos.x, y = oldSpawn.pos.y, z = oldSpawn.pos.z}, 1.0)
-- game.set_hospital_respawn({x = airport.pos.x, y = airport.pos.y, z = airport.pos.z}, 1.0)

-- -----
-- -- Respawns when busted
-- -----

-- game.set_police_respawn({x = oldSpawn.pos.x, y = oldSpawn.pos.y, z = oldSpawn.pos.z}, 1.0)
-- game.set_police_respawn({x = airport.pos.x, y = airport.pos.y, z = airport.pos.z}, 1.0)


--------------------
-- End functions are disabled and currently crash
--------------------





--------
-- End REQUIRED
--------

--------
-- Game Tick
-- Runs all the time
-- WARNING do not put anything in here that will crash, such as spawning vehicles or creating the player.
-- You will spam the command and the game will crash pretty quickly
--------

-- This runs every frame (called by the C++ Update/Heartbeat)
function OnTick()
	-- TODO Implement getting player keybinds in lua directly, I should be able to.
	--     if GetPlayerKey('W') then
	-- Do something
	--     end

	-- Kill player if they get cops
	-- This works, although I need to start a new game to change these in the tick function.
	-- player.kill_wanted()

	-- Well this is one way to lock the time..
	-- Although not this ticks intended purpose, it does work here.

	-- game.set_time(10, 55)

	-- TODO Fix this game.wait() to work in here, it doesn't work just yet in my scripts.
	-- game.wait(2000)


	-- Would be better to just freeze the clock though, probably less resource intensive.
end

--------
-- Custom functions go below
--------

local enableNeverWanted = false
local enableInfiniteHealth = false

-- Set ped density to 0.0
local disablePeds = false
-- Set vehicle density to 0.0
local disableVehicles = false

local blow_up_cars_toggle = false

local clear_area_toggle = false

-- If this is disabled, you won't lose weapons when busted or wasted.
local lose_weapons = true

-----------
-- Toggles
-----------

-- Toggle losing weapons on death.
if not lose_weapons then
	player.disable_lose_weapons_on_death()
else
	player.enable_lose_weapons_on_death()
end


-- Blow up all cars cheat
if blow_up_cars_toggle then
	blow_up_all_vehicles()
end

-- Clear the area of any peds and vehicles.
if clear_area_toggle then
	world.clear_area(25)
end

-- Turn the ped density multiplier to 0.0
if disablePeds then
	world.disable_peds()
end

-- Turn the vehicle density multiplier to 0.0
-- TODO Make this disable the emergency vehicles too, I didn't know fire trucks still spawned.
if disableVehicles then
	world.disable_vehicles()
end

-- Fixes below here, if game is reloaded with F5 these never get disabled.
-- So this just always disables them if they aren't toggled.
-- Although these have a cheat activated message, I'll deal with this later.
-- For now they can manually be disabled with the keybind events or something.
if enableNeverWanted then
	player.enable_never_wanted()
else
	--     player.disable_never_wanted()
end

if enableInfiniteHealth then
	player.enable_infinite_health()
else
	--     player.disable_infinite_health()
end

-----------
-- End Toggles
-----------

-- TODO Implement these in this freeroam-game.lua script.

-- Create some vehicles

-- Currently this can be called by adding it into the kcnet-keybind-events.lua file and pressing 'F9'.
-- Vehicle ID, posX, posY, posZ, Delete last vehicle, Warp into vehicle.
-- create_vehicle(145, spawnX + 10, spawnY + 10, spawnZ + 2, false, false)
-- TODO Fix this to work in the freeroam-game.lua script.

-- Wait, if I reload with F5 or start a new game, this spawns in? Is it just not working on init or something?
-- I wonder if this just isn't loading the model this early for some reason.

-- I have tried everything but this doesn't seem to want to work in here, I'll fix it later.

-- create_vehicle(145, airportX + 10.0, airportY + 10.0, airportZ + 2.0, false, false)
local vehicle_spawn_pos = {
	x = construction_site.pos.x + 5.0,
	y = construction_site.pos.y + 5.0,
	z = construction_site.pos.z + 2.0
}

-- vehicle.create(145, {
-- 	x = construction_site.pos.x + 5.0,
-- 	y = construction_site.pos.y + 5.0,
-- 	z = construction_site.pos.z + 2.0}, true, false)

-- vehicle.create(145, vehicle_spawn_pos, false, false)

-- Spawn some peds
