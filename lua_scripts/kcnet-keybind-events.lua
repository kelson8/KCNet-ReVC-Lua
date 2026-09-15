---@diagnostic disable: empty-block
-- Keybind events are in here for when running with F9.

-- For vehicle functions, such as converting a model name to an ID.
dofile("ViceExtended/lua_scripts/vehicles.lua")

-- For loading locations
dofile("ViceExtended/lua_scripts/freeroam-locations.lua")

-- For functions such as spawning vehicles, lua helper functions.
dofile("ViceExtended/lua_scripts/freeroam-functions.lua")

-- New for enums, which will be used in my freeroam and other scripts.
dofile("ViceExtended/lua_scripts/freeroam-enums.lua")

-- New, for radar blips and other stuff that should only ever be setup once.
-- Hmm, I can't put this here I'll just spawn infinite players lol.
-- I'm not sure how to check the ID of this then.
-- I guess my new code no longer checks if only one player is spawned, oops.
-- TODO Fix this to only ever spawn one player if the game is running..
-- dofile("ViceExtended/lua_scripts/freeroam-game.lua")

-- New for blips
dofile("ViceExtended/lua_scripts/freeroam-blips.lua")


-----------------------
--- KCNet Freeroam - Keybind events with F9
-----------------------

-- This prints all globals.
-- https://www.lua.org/pil/14.html
-- for n in pairs(_G) do print(n) end

------
-- Prefix for logging values to the console.
------

local lua_log_prefix = "[KcNet-Lua]: "

--- Print a message to the console with my log prefix.
-- Adds the specific lua_log_prefix to this.
-- @param msg The message to print.
--
local function print_info(msg)
	print(lua_log_prefix .. msg)
end

------
-- Locations from freeroam-locations.lua
------

local oldSpawn = GameLocations.oldSpawn
local airport = GameLocations.airport
local policeStation = GameLocations.policeStation
local construction_site = GameLocations.constructionSiteVehicle
local payNSpray1 = GameLocations.payNSpray1

-- The current players position.
-- This adds an offset for spawning vehicles.

--@type CVector
local playerPos = { x = player.get_position().x + 5.0, y = player.get_position().y + 5.0, z = player.get_position().z + 5.0}


-- TODO Rename this file to freeroam-keybind-events.lua later.

------
-- Toggles
------
---

-- player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_COLT45, 100)

-------------------------
-- Debug, may be disabled in the future.
-------------------------

-- If the vehicle spawned message gets displayed on the screen.
-- Only does anything if create_vehicle_toggle is enabled
local dbgShowVehicleIdMsg = false

-- If this should heal the player.
local dbgHealPlayer = false

-- Cheat codes testing
local dbgCheatCodes = false

-- Starting a fire, for testing
local dbgStartFire = false

-- Clear an area
local dbgClearArea = false

-- Unlock all car doors in the players area.
local dbgUnlockAllDoorsInArea = false

-- Run a random number test function
local dbgRandomNumberTest = false

-- Teleport to the marker if its set on the map.
local dbgTeleportToMarker = false

-- Test for adding an explosion
local dbgAddExplosion = false

------
-- Make the peds and cops ignore the player
local dbgEveryoneIgnorePlayer = false

local dbgPoliceIgnorePlayer = false


--- Change players skin, I may rename this function later.
local dbgChangeClothes = false

-- Remove all weapons from the player.
local dbgRemoveAllWeapons = false

-- Give the player an rc car
-- This is disabled in the games code until I fix it.
-- So it won't have any effect.
-- local dbgGiveRcCar = true

-- Test for reading my custom save format
local dbgReadCustomSave = false

-- Blow up the current vehicle you are in.
local dbgBlowUpCurrentVehicle = false

-- Test for setting the weather.
local dbgSetWeather = false

-- Test for creating an object on the map.
-- Disabled in game code, currently crashes it.
local dbgCreateObject = false

-- Test with new set_health and armor functions.
-- These work.
local dbgHealthTest = false

-- This just attempts to print the blip value, it doesn't get stored but gets set in OnInit.
-- The blips get set in OnInit in freeroam-game.lua.
local dbgBlipTest = false

-- Setting and getting the players stats as a test for my save system.
-- I can now set the player stats with this.
-- Although I haven't tested all of them I might want.
local dbgStatTest = false




-- Teleport the player to a random position.
-- TODO Fix this to work right.
local dbgTeleportRandomPosn = false

-- Camera fade testing, this mostly works but it's too fast to run fade out and in at once without a timer.
local dbgCameraFadeTest = false

-- Car generators test, I need to figure out how to store these.
local dbgCarGeneratorsTest = false

-- Testing overriding the respawn points for the game.
local dbgOverrideRestartTest = true

-----------

-------------------------
-- Normal game flow, will always be here.
-------------------------

-- This works now and can delete the previous vehicle.
local create_vehicle_toggle = false

-- TODO Make this get from a list of random values
-- Teleport the player to a random spawn I setup.
-- local teleportPlayerToSpawn = false
-- local teleportPlayerToAirport = false

-- If the player should teleport to the position set when 'F9' is pressed.
local teleportPlayer = false

------
-- Player functions
------

-- Get the players position
-- player.get_position

------
-- Vehicle functions
------
-- Create a vehicle
-- You can now delete the previous vehicle with this, but warping into it is stilled glitched - 1.2.10-3a.

-- I think I have fixed warping into the vehicles now - 1.2.10-4a

-- TODO Fix this to not place the vehicle in a building or a wall.
-- TODO Check if area is safe to spawn.

-- vehicle_util.create_vehicle(vehicle id, CVector pos, delete last vehicle, warp into vehicle)
-- Example:
-- vehicle.create(id, {x = 2, y = 2, z = 2}, false, false)

-- Disabled this message
-- print("kcnet-keybind-events.lua loaded")

----
-- Set the players position if enabled, new values can easily be added into freeroam-locations.lua.
if teleportPlayer then
	player.set_position({
		x = airport.pos.x,
		y = airport.pos.y,
		z = airport.pos.z
	})
end

-------------
-- This works for using my new vector push function from C++.
-- print("Player position: " ..
	-- "X: " .. player.get_position().x,
	-- "Y: " .. player.get_position().y,
	-- "Z: " .. player.get_position().z
-- )
-------------

----
-- New format, heal the player
if dbgHealPlayer then
	player.heal()
end

----
-- Testing cheat codes.
----

-- List of cheats to use currently.
-- This is mostly just shortcuts for functions that I will implement into the lua code later.

--[[
KILLME - This kills the player.
BLOWMEUP - Blows up the vehicle you are in, well currently this just sets it on fire.
]]
if dbgCheatCodes then
	-- game.cheat("KILLME")
	game.cheat("BLOWMEUP")
end

----
-- Start a fire for testing the function.
if dbgStartFire then
	game.start_fire({ x = playerPos.x, y = playerPos.y + 2, z = playerPos.z })
	-- game.start_fire({x = construction_site.pos.x + 5.0,
	-- y = construction_site.pos.y + 5.0,
	-- z = construction_site.pos.z})
end

----
-- Clear the area around the player, with a set radius.
if dbgClearArea then
	world.clear_area(20)
end

----
-- Unlock all locked cars in the players area
-- This works! Tested with a cop car that normally has the doors locked and driving.
if dbgUnlockAllDoorsInArea then
	local leftBottomX = playerPos.x - 20
	local leftBottomY = playerPos.y - 20
	local topRightX = playerPos.x + 20
	local topRightY = playerPos.y + 20

	world.unlock_all_car_doors_in_area(leftBottomX, leftBottomY, topRightX, topRightY)
end

-----

-- Test, may be changed/removed later.
-- Currently, gives the players a weapon and tries to have them kill the player.
-- Usage (These are all boolean values):
-- world.set_ped_objectives(give_ped_weapons, attack_player, should_exit_vehicle, kill_peds)
-- world.set_ped_objectives(true, true, false, false)
-- 

-- Set the game time.
-- game.set_time(10, 55)

-- Test for my enums, this works.
-- print("Weapon index MI_BRASS_KNUCKLES: " .. weapon_enums.eWeaponModelIndices.MI_BRASS_KNUCKLES)

-- TODO Fix below to work

-- Set the time scale
-- game.set_time_scale(0.5)

-- Freeze the vehicle position.
-- local vehicleFrozen = false
-- vehicle.freeze_position(is_frozen)

-----
--- Garage testing
--- TODO Fix this to work right.
-----

-- Setting a respray garage as a test.
-- garage.set(leftBottomX, leftBottomY, leftBottomZ, frontX, frontY, rightTopX, rightTopY, rightTopZ, type)
-- garage.set(-886.157, -115.158, 9.992, -882.699, -108.312, -876.7, -119.83, 15.58, garage_enums.eGarageType.GARAGE_RESPRAY)

-- TODO Test this, not sure of what the id number is for this..
-- Trying to use 0 seems to break it in my lua scripts.
-- It gives a lua error in the console with 0, and that is probably what this garage is.
-- garage.open(1)
-- garage.close(1)


-- local garage_id = 2

-- if garage.is_open(garage_id) then
-- 	print("Garage with id " .. garage_id .. " is open")
-- else
-- 	print("Garage with id " .. garage_id .. " is closed")
-- end



-- garage.is_open(1)
-- garage.is_closed(1)

-- garge.change_type(1, 2)


----
---
--


----
-- Random number testing, using a very basic random number generator in lua.
if dbgRandomNumberTest then
	local min_random_number = 1
	-- local max_random_number = 150
	local max_random_number = 6
	local random_number = math.random(min_random_number, max_random_number)
	-- This works for a basic random number generator.
	print_info("Random number: " .. random_number)

	-- Check if the random number was even
	if random_number % 2 == 0 then

		-- Unfreeze the players vehicle
		-- vehicle.freeze_position(false)

		-- Put the player at the airport
		player.set_position({
			x = airport.pos.x,
			y = airport.pos.y,
			z = airport.pos.z
		})

		-- print_info("Random number was even.")
	else
		-- Freeze the players vehicle
		-- vehicle.freeze_position(true)

		-- Put the player at the Police station.
		player.set_position({
			x = policeStation.pos.x,
			y = policeStation.pos.y,
			z = policeStation.pos.z
		})

		-- Kill the player if the number was odd, make this like a dice roll.
		-- print_info("Random number was odd.")
		-- player.kill()
	end
end

-- Telepor to the marker, this works now.
if dbgTeleportToMarker then
	player.tp_to_marker()
end

-- Add an explosion at the players position with sound.
-- If the boolean for parameter 2 is false, this disables the explosion sound.
if dbgAddExplosion then
	game.add_explosion({x = playerPos.x, y = playerPos.y, z = playerPos.z}, true)
end



if create_vehicle_toggle then
	-- local vehicle_id = getVehicleIdByName("Infernus")
	-- local vehicle_id = getVehicleIdByName("Romero's Hearse")

	local vehicle_id = getRandomVehicleId()
	local vehicle_name = getVehicleNameById(vehicle_id)

	local vehicle_id_msg = "Vehicle ID: " .. vehicle_id .. " name " .. vehicle_name

	-- Log the message to the console.
	print(vehicle_id_msg)

	-- Display the message to the screen.
	-- 	hud.print_msg(vehicle_id_msg)

	print("Spawned ID " .. vehicle_id)
	-- Well this crashes it..
	-- TODO Add error handling to the lua vehicle script so it only spawns valid models.
	-- TODO Make this place the vehicle in a safe place, sometimes it can get stuck in a tree.
	-- I'll fix it later.

	-- New vehicle format, this works for spawning a vehicle now.
	-- vehicle.create(
	-- 	vehicle_id,
	-- 	-- CVector of the position to spawn the vehicle, currently this just spawns it near the player.
	-- 	-- The playerPos variable has a bit of an offset.
	-- 	{
	--     	x = playerPos.x,
	--     	y = playerPos.y,
	--     	z = playerPos.z
	-- 	},
	-- 	true, -- Should this remove the previous vehicle, now this works for removing the last spawned vehicle.
	-- 	true -- Should this warp the player into the vehicle, works fine now unless it's spammed.
	-- )

	vehicle_util.create_vehicle(vehicle_id, { x = playerPos.x, y = playerPos.y, z = playerPos.z }, true, true)
end


------
-- Misc functions
------

blow_up_vehicles_cheat = false
if blow_up_vehicles_cheat then
	blow_up_all_vehicles()
end

-------
-- Make the peds and cops ignore the player
-------

-- Make everyone ignore the player.
if dbgEveryoneIgnorePlayer then
	player.everyone_ignore(true)
else
	player.everyone_ignore(false)
end

-- Make police ignore the player.
if dbgPoliceIgnorePlayer then
	player.police_ignore(true)
else
	player.police_ignore(false)
end

-------
-- Change clothes
-------

if dbgChangeClothes then
	player.change_clothes("Sonny Forelli")
end

-------
-- Remove weapon test
-------

-- Parameter is the slot to remove the weapon from.
-- player.remove_weapon(0)

-- Amount of weapon slots for player to remove from
-- This works!
-- I guess instead of doing the loops in C++, I should handle them in the lua scripts when I can.
if dbgRemoveAllWeapons then
	for i = 1, 10 do
		player.remove_weapon(i)
	end
end

-----------------------------------------------
--- New tests and functions as of v1.2.13-2a.
-----------------------------------------------

-- Give the player an rc car.

-- This works! But it doesn't disable the players control they still move around.
-- And to drive the RC Car forward you need to use the 'Left Shift' key instead of 'W'
-- Well this is somewhat glitchy so I disabled it in the C++ code.
-- It doesn't remove the old RC cars and will just keep spawning them.
-- if dbgGiveRcCar and not player.is_in_vehicle() then
-- 	player.give_rc_car()
-- end

--- Check if player is in a vehicle.
-- if player.is_in_vehicle() then
-- 	print("You are in a vehicle.")
-- else
-- 	print("You are not in a vehicle")
-- end

--- Test log outputs.
-- Well these don't work for some reason, I guess I'll fix them later.
-- log.info("Info message")
-- log.warning("Warning message")
-- log.error("Error message")

--- Output a hud message, I think this can only go up to 16 characters but I'm not sure.
--- This may crash if the text is too long.
-- hud.print_msg("Test Hud Msg")

-- 


-----------------------------------------------

-- This works now! Reads from my custom save json format.
-- I will use this later for respawning me where I last was pretty much.
-- Requires the ViceExtended subfolder since the games root folder isn't in lua_scripts.
if dbgReadCustomSave then
	-- If this type value is here, it uses the type defined in types.lua.
	-- Since I modified the read_json_file function, this doesn't seem to be needed so I'll comment it out.
	-- -@type RevcSave
	local save_file, err = file_util.read_json_file(file_util.save_path)
	if not save_file then
		print(err)
		return
	end

	-- This works! I can print these values, now this has auto complete from the JSON save format.
	-- print(save_file.stats.health)
	-- print(save_file.player.position.x)
	print(save_file.stats.health)
end

-- Blow up vehicle has been enabled, now you can blow up your vehicle you are in with this.
if dbgBlowUpCurrentVehicle then
	player.blow_up_vehicle()
end
-- 

-- This can set the weather from the weather enums.
-- TODO Make this get a random value from the weather enums.
if dbgSetWeather then

	game.force_weather(weather_enums.eWeatherType.WEATHER_SUNNY)
	game.force_weather_now(weather_enums.eWeatherType.WEATHER_SUNNY)
	-- game.force_weather(weather_enums.eWeatherType.WEATHER_RAINY)

	-- game.force_weather_now(weather_enums.eWeatherType.WEATHER_RAINY)


	-- Release the weather type.
	-- game.release_weather()

	-- TODO Implement this
	-- Get the current weather type
	-- game.get_weather()

	-- Set if hurricanes are allowed
	-- game.set_allow_hurricanes(true)
end

-- TODO Test this.
-- Test for creating an object on the map.
-- Well this just crashes it, I don't think I'm spawning the object right.
if dbgCreateObject then
	world.create_object_no_offset({x = playerPos.x + 3, y = playerPos.y + 3, z = playerPos.z})
end

-- Test for new health functions, I only had heal on here before.
-- These work now.
if dbgHealthTest then
	player.set_health(200)
	player.set_armor(150)

	print(player.get_health())
	print(player.get_armor())
end



-- This works for removing the blip that is created with freeroam-game.lua now.
if dbgBlipTest then
	-- Moved into freeroam-game.lua, I think I have to load it on init instead of in here.

	-- This works for deleting the blip now!
	-- Although I am only storing one of them in the text file, I can probably put more on multiple lines.
	-- TODO Make this store and read from a json file with this format:
	----
	--- {
	--- 	blip1_id: 1,
	--- 	blip1_id: 2,
	--- }
	---
	---
	current_blip = map_blips.get_current_blip()
	print(current_blip)
	game.remove_blip(current_blip)
end

-- Test for setting the players stats.
if dbgStatTest then
	player.set_stat(stat_enums.eStatType.ROUNDS_FIRED_BY_PLAYER, 2000)
end

-- Print the health and armor for testing my new internal format.
-- print("Health: " .. player.get_health())
-- print("Armor: " .. player.get_armor())

-- Teleport the player to a random position.
if dbgTeleportRandomPosn then
	player_functions.random_position()
end

-- Test for fading the camera in and out, probably won't work without a timer.
-- This works!
-- If I run these one at a time it'll work, I will need to implement the wait timer like in the original scripts.
-- Otherwise this won't work properly for teleports in my lua scripts.
if dbgCameraFadeTest then
	world.fade_camera(2.0, camera_enums.eFadeDirection.FADE_OUT)
	world.fade_camera(2.0, camera_enums.eFadeDirection.FADE_IN)
end

-------------------
--- Clock testing
-------------------

-- Show the game time.
-- https://devforum.roblox.com/t/how-do-i-remove-decimals/405222
-- local game_clock = math.floor(game.get_hour() + 0.5) .. ":" .. math.floor(game.get_minute() + 0.5)

-- print(game_clock)

-------------------
--- Money testing
-------------------

-- print("Current $: " .. player.get_money())

-- player.set_money(1000)
-- print("New $: " .. player.get_money())

-- I can make this give the player a random amount of money.
-- for i = 1, 100000 do
	-- player.set_money(math.random(1, 100000))
-- end

-- player.set_money(math.random(1, 100000))

-- Test for car generators, these work but I have disabled them until I setup a better system for storing these.

if dbgCarGeneratorsTest then
	-- log_util.print_msg("Car generators not enabled!")
	-- TODO Make this return the int from the car generators, so I can toggle it also.
	world.create_car_generator({x = airport.pos.x, y = airport.pos.y, z = airport.pos.z},
	airport.heading, 145, 1, 1,
	true, 0,
	0, 0, 10000)

	-- This works now! The car generator values start at 0.
	-- Maybe I can store these in my save file like the original game does.
	world.switch_car_generator(0, 101)
end

if dbgOverrideRestartTest then
	-- Override the spawn point, so instead of a wasted/busted respawn the player spawns here.

	local beachRespawn = { x = 664.173, y = -623.533, z = 11.071}

	-- game.override_next_restart({x = beachRespawn.x, y = beachRespawn.y, z = beachRespawn.z},
	-- airport.heading)

	-- log_util.print_msg("Spawn has been overridden to X: " .. beachRespawn.x ..
	-- 				  " Y: " .. beachRespawn.y ..
	-- 				  " Z: " .. beachRespawn.z)

	-- Cancel an overridden spawn point
	game.cancel_override_restart()
	log_util.print_msg("Cancelled override for spawn point.")
end

-------
-- Internal TCP Server testing
-- This may be used for a small multiplayer test or something else.
-------

-- New for TCP server testing, sending message from client (the ReVC game)
-- send_msg_tcp_server("Message from lua on ReVC")

-- Send the players health to the TcpServer
-- send_msg_tcp_server("[ReVC]: Players health: " .. player_health())
