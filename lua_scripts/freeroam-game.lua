---@diagnostic disable: unused-local
-- This format works with my setup! I had to have a subdirectory for it.
dofile("ViceExtended/lua_scripts/freeroam-locations.lua")

-- Add new enums for freeroam-game.lua
dofile("ViceExtended/lua_scripts/freeroam-enums.lua")

-- For functions such as spawning vehicles, lua helper functions.
dofile("ViceExtended/lua_scripts/freeroam-functions.lua")

-- Debug testing
-- dofile("ViceExtended/lua_scripts/extra_functions/test_disable_road_blocks.lua")

-- New for blips
dofile("ViceExtended/lua_scripts/freeroam-blips.lua")

-- New for garages
dofile("ViceExtended/lua_scripts/freeroam-garages.lua")

-- New for objects on the map
dofile("ViceExtended/lua_scripts/freeroam-objects.lua")

-- New for pickups on the map, such as save pickups and weapon pickups
dofile("ViceExtended/lua_scripts/freeroam-pickups.lua")

-- For most configs that I will use now.
dofile("ViceExtended/lua_scripts/freeroam-config.lua")

-----------
-- WARNING
-- If there are any errors in this file, ReVC will crash because this script spawns the player.
-- Like the original game scripts, my ReVC build doesn't spawn the player directly in the games code but in here.
-----------

-----------------------
--- KCNet Freeroam - Main Game init script.
-----------------------


-- Obtained from freeroam-locations.lua
local oldSpawn = GameLocations.oldSpawn
local airport = GameLocations.airport
local policeStation = GameLocations.policeStation
local construction_site = GameLocations.constructionSiteVehicle
local payNSpray1 = GameLocations.payNSpray1

-- Hospitals/police stations from scripts.
local hospital1 = GameLocations.hospital1
local hospital2 = GameLocations.hospital2
local hospital3 = GameLocations.hospital3
local hospital4 = GameLocations.hospital4

local policeSt1 = GameLocations.policeSt1
local policeSt2 = GameLocations.policeSt2
local policeSt3 = GameLocations.policeSt3
local policeSt4 = GameLocations.policeSt4

local use_original_spawns = false


-- If this is set, most of the road blocks will block the islands like in the original scripts.
-- This is mostly for testing, currently I cannot disable the vehicle roads in these areas.
local roadBlocksEnabled = false

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
	-- TODO Use this function for variables that should only ever be set on startup.
	-- It now can create the player in here, although it'll break my game if I start a new game or load a save.
	-- So I won't use this just yet.

	-- New for setting up blips on the map.
	-- Currently these cannot be modified but they do show up now.
	-- TODO Load these from json list later.
	map_blips.setup()

	-- Setup the garages, moved out of keybind events.
	garage_util.setup_garages()

	-- Setup some of the objects on the map.
	-- In the future, I will use this for custom objects.
	-- object_util.setup_objects()

	-- Setup all of the road blocks on the map
	if roadBlocksEnabled then
		object_util.setup_road_blocks()
	end

	-- Setup pickups, some of these get set back in the OnTick function when picked up

	-- Save pickups, these run in the loop also and respawn the pickup.
	map_pickups.create_save_markers()

	-- Setup the money pickups, these will only spawn once.
	-- So far this is just for testing.
	-- map_pickups.money_pickups()

	-- Create testing hidden package pickups
	-- map_pickups.hidden_package_pickups()

	-- TODO Implement these below
	-- Save pickups, which save to my custom json file.

	-- Fix the turn_ped_roads_off functions so I can disable the roads where peds shouldn't be.

	-- Spawning objects, I haven't figured this out in the code yet.


	-- This works in here now!

	-- This only runs once in the init, if there are more then one of the player.create functions they won't do anything.
	-- Fixes some bugs I was having, which was spawning multiple players for me to control lol.

	-------
	-- REQUIRED if DISABLE_GAME_SCRIPTS is toggled on in the game code, otherwise it won't spawn the player.
	-- Locations are stored in freeroam-locations.lua, and more can be added.
	-------
	-- Putting this at the end, if there are errors above this will probably crash anyways
	
	-- Spawn in the player, mostly for spawning without the .scm scripts
	player_functions.load_player_data()
end


-- This gives the player a weapon with some ammo
-- You can use any weapons from the eWeaponType enum in freeroam-enums.lua.
player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_COLT45, 100)
player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_KATANA, 1)
player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_MOLOTOV, 100)


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

----------------------------------
--- Respawns when wasted/busted
--- There can only be a max of 8 of these.
----------------------------------

--------------------
-- I have fixed these functions in v1.2.12-10a.
--------------------

-- Setup some respawn points, I'm quite sure a max of 8 can be set.
-- TODO Setup a random number generator for random spawns, I could just do it in the lua scripts.
-- Actually, I would need to run the override next restart since the hospital respawns take over.

-----
-- Respawns when wasted
-----

game.set_hospital_respawn({ x = oldSpawn.pos.x, y = oldSpawn.pos.y, z = oldSpawn.pos.z }, 1.0)
game.set_hospital_respawn({ x = airport.pos.x, y = airport.pos.y, z = airport.pos.z }, 1.0)
game.set_hospital_respawn({ x = payNSpray1.pos.x, y = payNSpray1.pos.y, z = payNSpray1.pos.z }, 1.0)

------
-- Load the game script hospital respawns
if use_original_spawns then
	game.set_hospital_respawn({ x = hospital1.pos.x, y = hospital1.pos.y, z = hospital1.pos.z }, hospital1.heading)
	game.set_hospital_respawn({ x = hospital2.pos.x, y = hospital2.pos.y, z = hospital2.pos.z }, hospital2.heading)
	game.set_hospital_respawn({ x = hospital3.pos.x, y = hospital3.pos.y, z = hospital3.pos.z }, hospital3.heading)
	game.set_hospital_respawn({ x = hospital4.pos.x, y = hospital4.pos.y, z = hospital4.pos.z }, hospital4.heading)
end
------

-----
-- Respawns when busted
-----

game.set_police_respawn({ x = oldSpawn.pos.x, y = oldSpawn.pos.y, z = oldSpawn.pos.z }, 1.0)
game.set_police_respawn({ x = airport.pos.x, y = airport.pos.y, z = airport.pos.z }, 1.0)
game.set_police_respawn({ x = payNSpray1.pos.x, y = payNSpray1.pos.y, z = payNSpray1.pos.z }, 1.0)

------
-- Load the game script busted respawns
if use_original_spawns then
	game.set_police_respawn({ x = policeSt1.pos.x, y = policeSt1.pos.y, z = policeSt1.pos.z }, policeSt1.heading)
	game.set_police_respawn({ x = policeSt2.pos.x, y = policeSt2.pos.y, z = policeSt2.pos.z }, policeSt2.heading)
	game.set_police_respawn({ x = policeSt3.pos.x, y = policeSt3.pos.y, z = policeSt3.pos.z }, policeSt3.heading)
	game.set_police_respawn({ x = policeSt4.pos.x, y = policeSt4.pos.y, z = policeSt4.pos.z }, policeSt4.heading)
end

------

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



------------------
-- Now this runs all the time only if there is a while true in here.
-- Somewhat mimics the original scripts and mta sa.
-- This was fixed to work better in v1.2.14-7a.
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

	-- This format is actually working!
	-- I finally got the wait timers to work.
	-- Main game loop goes here, mimics original scripts.
	-- while config.lock_game_time do
	-- 	game.wait(3000)
	-- 	game.set_time(10, 55)
	-- 	-- player.kill_wanted()
	-- 	-- print("DEAD")
	-- end

	-- Anything in here will run all the time.
	while true do
		-- Well I cannot call functions outside of OnTick in here, at least in other files.
		-- player_functions.fade_effect(2.0)

		game.wait(0)


		-----------------------
		--- Save pickup testing
		-----------------------

		map_pickups.save_loop()

		-- player_functions.low_health_kill()

		-- Randomly blow up vehicles for some chaos.

		-- game.wait(5000)
		-- Hmm, some fun.. This causes vehicles to randomly blow up.
		-- world.blow_up_all_vehicles()

		--
		-- game.wait(3000)
		--
	end
end

--------
-- Custom functions go below
-- TODO Move the options for this into freeroam-config.lua
-- TODO Move these functions elsewhere.
--------

--- Cheat toggles for debugging.
local enableNeverWanted = false
local enableInfiniteHealth = false

-- Added in v1.2.14-4a
local enableInfiniteSprint = false
---

--- Set ped density to a custom value.
local toggle_ped_density = true
local toggle_vehicle_density = true

-- This can be set to 0.0 to disable the peds and vehicles.
-- These values can be between 0.0 and 1.0, otherwise this won't work.
-- local ped_density = 0.5
local ped_density = 1.0
-- local ped_density = 0.0
-- local vehicle_density = 0.5
local vehicle_density = 1.0
-- local vehicle_density = 0.0

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

if enableInfiniteSprint then
	player.set_infinite_sprint(true)
else
	player.set_infinite_sprint(false)
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
-- local vehicle_spawn_pos = {
-- 	x = construction_site.pos.x + 5.0,
-- 	y = construction_site.pos.y + 5.0,
-- 	z = construction_site.pos.z + 2.0
-- }

-- vehicle.create(145, {
-- 	x = construction_site.pos.x + 5.0,
-- 	y = construction_site.pos.y + 5.0,
-- 	z = construction_site.pos.z + 2.0}, true, false)

-- vehicle.create(145, vehicle_spawn_pos, false, false)

-- Spawn some peds
