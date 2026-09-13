---@diagnostic disable: unused-local
-- This format works with my setup! I had to have a subdirectory for it.
dofile("ViceExtended/lua_scripts/freeroam-locations.lua")

-- Add new enums for freeroam-game.lua
dofile("ViceExtended/lua_scripts/freeroam-enums.lua")

-- For functions such as spawning vehicles, lua helper functions.
dofile("ViceExtended/lua_scripts/freeroam-functions.lua")

-----------
-- WARNING
-- If there are any errors in this file, ReVC will crash because this script spawns the player.
-- Like the original game scripts, my ReVC build doesn't spawn the player directly in the games code but in here.
-----------

-- Obtained from freeroam-locations.lua
local oldSpawn = GameLocations.oldSpawn
local airport = GameLocations.airport
local policeStation = GameLocations.policeStation
local construction_site = GameLocations.constructionSiteVehicle
local payNSpray1 = GameLocations.payNSpray1

-- If this is set, this will read the saved player position from the custom JSON save file.
-- Otherwise it just sets a debug position to spawn at.

-- If this is set, it will load the custom save file.
-- Which is named 'kcnet-revc-save.json'.
local read_save_data = true

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
gbDisplayPosn = true

-- If the emergency vehicles are disabled.
-- This should stop firetrucks, ambulances, and police vehicles from spawning for crimes.
-- TODO Test this.
gbDisableEmergencyVehicleSpawning = false

-- This enables infinite ammo for the player.
gbInfiniteAmmoCheat = true

-- This toggles fading the player when they die and get busted.
-- If this is false, they won't fade and it'll spawn the player quicker.
-- By default, this is enabled in the game code.
-- If this is not here, it will still be set to true by default.
-- So it's not required, but I will document it in here.
gbFadeOnDeath = true

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

-- player.create(0, { x = construction_site.pos.x, y = construction_site.pos.y, z = construction_site.pos.z })

----------------------
--- New save format
--- This can load from the kcnet-revc-save.json custom json format
--- I will be making a save pickup or something later in this but this is all loaded in with lua.
--- So I can easily modify how this loads without even rebuilding the game code!
----------------------

-- This works now! Reads from my custom save json format.
-- I will use this later for respawning me where I last was pretty much.
-- Requires the ViceExtended subfolder since the games root folder isn't in lua_scripts.

if read_save_data then
	local save_file_path = "ViceExtended/kcnet-revc-save.json"

	--------
	-- Player position to load spawn at.
	--------

	local storedPlayerPosition = player_functions.get_saved_position(save_file_path)

	-- The game will crash here, the player position wasn't found.
	if not storedPlayerPosition then
		return
	end

	-- Spawn the player at the coordinates set in the save file.
	-- player.create(0, {x = playerX, y = playerY, z = playerZ})
	player.create(0, { x = storedPlayerPosition.x, y = storedPlayerPosition.y, z = storedPlayerPosition.z })

	-- This works for loading the stats from the function!
	-- Cleans up the freeroam-game.lua file quite a bit.
	player_functions.load_save_stats(save_file_path)

	-- TODO Setup these below.
	-- Set the players heading
else
	-- If the save file isn't going to be used, this below is set as a manual spawn point.

	-- Spawn at the pay n spray I am testing the garage at.
	-- TODO Make this spawn the player at the coordinates in the JSON save file that I am testing.
	player.create(0, { x = payNSpray1.pos.x, y = payNSpray1.pos.y, z = payNSpray1.pos.z })
	-- print(save_file.stats.health)
end


-- This gives the player a weapon with some ammo
-- You can use any weapons from the eWeaponType enum in freeroam-enums.lua.
player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_COLT45, 100)


----
--- Misc init features
---

-----------------
-- Disable some ped roads on the map
-- A lot of these values came from the decompiled game scripts.
-- TODO Fix this to work, it doesn't seem to do anything.
-- This is currently disabled in the game code.


-- Back of mansion.
-- world.switch_ped_roads_off({x = -395.6, y = -658.6, z = 0.0}, { x = -363.2, y = -636.7, z = 32.0})

------------------





-- Silence all game phones, in case they are running
-- TODO Test this, it should work on game start, it doesn't crash so I'll leave this enabled.
for i = 1, config_enums.eGameLimits.NUMPHONES do
	game.turn_phone_off(i)
end

--------------------
-- I have fixed these functions in v1.2.12-10a.
-- Well I thought I had these working, they seem to change the spawn once.
-- Although it's not crashing anymore so I have enabled these in the C++ code.
--------------------

-- Setup some respawn points, I'm quite sure a max of 8 can be set.
-- TODO Setup a random number generator for random spawns, I could just do it in the lua scripts.

-----
-- Respawns when wasted
-----

game.set_hospital_respawn({ x = oldSpawn.pos.x, y = oldSpawn.pos.y, z = oldSpawn.pos.z }, 1.0)
game.set_hospital_respawn({ x = airport.pos.x, y = airport.pos.y, z = airport.pos.z }, 1.0)
game.set_hospital_respawn({ x = payNSpray1.pos.x, y = payNSpray1.pos.y, z = payNSpray1.pos.z }, 1.0)

-- -----
-- -- Respawns when busted
-- -----

game.set_police_respawn({ x = oldSpawn.pos.x, y = oldSpawn.pos.y, z = oldSpawn.pos.z }, 1.0)
game.set_police_respawn({ x = airport.pos.x, y = airport.pos.y, z = airport.pos.z }, 1.0)
game.set_police_respawn({ x = payNSpray1.pos.x, y = payNSpray1.pos.y, z = payNSpray1.pos.z }, 1.0)


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
---

-- Seed the random number generator.
math.randomseed(os.time())


-- This runs every frame (called by the C++ Update/Heartbeat)
function OnTick()
	-- local random_number = math.random(1, 1000)
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

	-- This works for kind of a timer, its just for screwing around with though.
	-- if random_number == 30 then
	-- Hmm, some fun.. This causes vehicles to randomly blow up.
	-- world.blow_up_all_vehicles()
	-- end

	-- Would be better to just freeze the clock though, probably less resource intensive.

	-- Update the coroutine threads.
	-- TODO Try to fix this to work.
	-- This is now in freeroam-coroutine-test.lua, since it doesn't work.
	-- updateThreads(deltaTime * 1000)
end

--------
-- Custom functions go below
--------

--- Cheat toggles for debugging.
local enableNeverWanted = false
local enableInfiniteHealth = false
---

--- Set ped density to a custom value.
local toggle_ped_density = true
local toggle_vehicle_density = true

-- This can be set to 0.0 to disable the peds and vehicles.
-- These values can be between 0.0 and 1.0, otherwise this won't work.
local ped_density = 0.5
-- local ped_density = 0.0
local vehicle_density = 0.5
-- local vehicle_density = 0.0

------
-- These shouldn't be in here.
local blow_up_cars_toggle = false

local clear_area_toggle = false
-------


-- If this is disabled, you won't lose weapons when busted or wasted.
local lose_weapons = true

-----------
-- Toggles
-----------

-- Toggle losing weapons on death.
if not lose_weapons then
	player.lose_weapons_on_death(false)
else
	player.lose_weapons_on_death(true)
end


-- Blow up all cars cheat
-- TODO Move into kcnet-keybind-events.lua.
if blow_up_cars_toggle then
	world.blow_up_all_vehicles()
end

-- Clear the area of any peds and vehicles.
-- TODO Move into kcnet-keybind-events.lua.
if clear_area_toggle then
	world.clear_area(25)
end

-- Set the ped density to a custom value.
if toggle_ped_density then
	world.set_ped_density(ped_density)
end

-- Set the vehicle density to a custom value.
-- TODO Make this disable the emergency vehicles too, I didn't know fire trucks still spawned.
if toggle_vehicle_density then
	world.set_vehicle_density(vehicle_density)
end

-- Fixes below here, if game is reloaded with F5 these never get disabled.
-- So this just always disables them if they aren't toggled.
-- Although these have a cheat activated message, I'll deal with this later.
-- For now they can manually be disabled with the keybind events or something.
if enableNeverWanted then
	player.set_never_wanted(true)
else
	-- Only needed to turn it back off.
	-- player.set_never_wanted(false)
end

-- TODO Fix this to work with my new format, for some reason it doesn't.
if enableInfiniteHealth then
	player.set_infinite_health(true)
else
	player.set_infinite_health(false)
end

-----------
-- End Toggles
-----------

-- TODO Implement these in this freeroam-game.lua script.

-- Create some vehicles

-- Currently this can be called by adding it into the kcnet-keybind-events.lua file and pressing 'F9'.
-- Vehicle ID, posX, posY, posZ, Delete last vehicle, Warp into vehicle.
-- vehicle_util.create_vehicle(145, spawnX + 10, spawnY + 10, spawnZ + 2, false, false)
-- TODO Fix this to work in the freeroam-game.lua script.

-- Wait, if I reload with F5 or start a new game, this spawns in? Is it just not working on init or something?
-- I wonder if this just isn't loading the model this early for some reason.

-- I have tried everything but this doesn't seem to want to work in here, I'll fix it later.

-- vehicle_util.create_vehicle(145, airportX + 10.0, airportY + 10.0, airportZ + 2.0, false, false)
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
