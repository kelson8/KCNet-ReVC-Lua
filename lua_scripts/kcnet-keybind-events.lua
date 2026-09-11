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

-- New for json testing from my save file format
dofile("ViceExtended/lua_scripts/lib/dkjson.lua")

-- For package path
-- TODO Test this later.
-- package.path = package.path .. ";ViceExtended/lua_scripts/lib/?.lua"

-- local json = require ("dkjson")
local json = dofile("ViceExtended/lua_scripts/lib/dkjson.lua")

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

-- The current players position.
-- This adds an offset for spawning vehicles.

local playerPos = { x = player.get_position().x + 5.0, y = player.get_position().y + 5.0, z = player.get_position().z + 5.0}

-- TODO Rename this file to freeroam-keybind-events.lua later.

------
-- Toggles
------

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
-- world.set_ped_objectives()

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


-- Blow up vehicle has been enabled, now you can blow up your vehicle you are in with this.
-- player.blow_up_vehicle()

-----------------------------------------------



-- This works now! Reads from my custom save json format.
-- I will use this later for respawning me where I last was pretty much.
-- Requires the ViceExtended subfolder since the games root folder isn't in lua_scripts.
if dbgReadCustomSave then
	local save_file_path = "ViceExtended/kcnet-revc-save.json"

	local save_file, err = file_util.read_json_file(save_file_path)
	if not save_file then
		print(err)
		return
	end

	-- This works! I can print these values
	print(save_file.stats.health)
end


-------
-- Internal TCP Server testing
-- This may be used for a small multiplayer test or something else.
-------

-- New for TCP server testing, sending message from client (the ReVC game)
-- send_msg_tcp_server("Message from lua on ReVC")

-- Send the players health to the TcpServer
-- send_msg_tcp_server("[ReVC]: Players health: " .. player_health())
