-- Keybind events are in here for when running with F9.

-- For vehicle functions, such as converting a model name to an ID.
dofile("ViceExtended/lua_scripts/vehicles.lua")

-- For loading locations
dofile("ViceExtended/lua_scripts/freeroam-locations.lua")

------
-- Locations from freeroam-locations.lua
------

local oldSpawn = GameLocations.oldSpawn
local airport = GameLocations.airport
local policeStation = GameLocations.policeStation
local construction_site = GameLocations.constructionSiteVehicle

-- The current players position.
-- This adds an offset for spawning vehicles.
-- TODO Make into a player.get_position function later.
local playerPos = {x = playerX + 5.0, y = playerY + 5.0, z = playerZ + 2.0}

-- TODO Rename this file to freeroam-keybind-events.lua later.

------
-- Toggles
------

-- If the vehicle spawned message gets displayed on the screen.
-- Only does anything if create_vehicle_toggle is enabled
local dbgShowVehicleIdMsg = false

-- If this should heal the player.
local dbgHealPlayer = false

-- This works but doesn't delete the previous vehicle.
local create_vehicle_toggle = false

-- TODO Make this get from a list of random values
-- Teleport the player to a random spawn I setup.
local teleportPlayerToSpawn = false
local teleportPlayerToAirport = false

-- If the player should teleport to the position set when 'F9' is pressed.
local teleportPlayer = false

------
-- Player functions
------

-- Get the players position, this only works in this file
-- Use these globals:
-- playerX
-- playerY
-- playerZ

------
-- Vehicle functions
------
-- Create a vehicle
-- Currently, delete last vehicle and warp into vehicle are buggy so they should be kept off for now.

-- create_vehicle(vehicle id, CVector pos, delete last vehicle, warp into vehicle)
-- Example:
-- vehicle.create(id, {x = 2, y = 2, z = 2}, false, false)

-- Disabled this message
-- print("kcnet-keybind-events.lua loaded")

-- Set the players position if enabled, new values can easily be added into freeroam-locations.lua.
if teleportPlayer then
	player.set_position({
		x = airport.pos.x,
		y = airport.pos.y,
		z = airport.pos.z
	})
end

-- New format, heal the player
if dbgHealPlayer then
	player.heal()
end

-- Get the players position, this only works in this file
-- TODO Move into a CVector value instead of the floats later.
-- print("Player coordinates, X: " .. playerX .. " Y: " .. playerY .. " Z: " .. playerZ)

if create_vehicle_toggle then
	local vehicle_id = getVehicleIdByName("Infernus")
	-- local vehicle_id = getVehicleIdByName("Romero's Hearse")
	local vehicle_name = getVehicleNameById(vehicle_id)

	local vehicle_id_msg = "Vehicle ID: " .. vehicle_id .. " name " .. vehicle_name

	-- Log the message to the console.
	print(vehicle_id_msg)

	-- Display the message to the screen.
-- 	print_msg(vehicle_id_msg)

	print("Spawned ID " .. vehicle_id)
	-- Well this crashes it..
	-- TODO Add error handling to the lua vehicle script so it only spawns valid models.
	-- TODO Make this place the vehicle in a safe place, sometimes it can get stuck in a tree.
	-- I'll fix it later.

	-- New vehicle format, this works for spawning a vehicle now.
	vehicle.create(
    	vehicle_id,
		-- CVector of the position to spawn the vehicle, currently this just spawns it near the player.
		-- The playerPos variable has a bit of an offset.
    	{
        	x = playerPos.x,
        	y = playerPos.y,
        	z = playerPos.z
    	},
    	false, -- Should this remove the previous vehicle, this needs fixed it doesn't work.
    	false -- Should this warp the player into the vehicle, somewhat buggy so defaults to false.
	)

	-- TODO Fix this below, should create a random vehicle.
	-- To create a random vehicle from the available IDs (keys):
	-- print(vehicles)
	-- print("Inspecting vehicles table:")
	-- for k, v in pairs(vehicles) do
	--   print("Key:", k, "Value:", v)
	-- end

	-- local availableIds = {}
	-- print("Before loop - availableIds:", availableIds) -- Check if it's an empty table initially

  	-- -- Populate availableIds with vehicle IDs
  	-- for id, name in pairs(vehicles) do
    -- 	print("Inside loop - ID:", id, "Name:", name)
    -- 	table.insert(availableIds, id)
    -- 	print("Inside loop - availableIds:", availableIds)
  	-- end

	-- print("After loop - availableIds:", availableIds) -- Check the final content

	-- -- This print doesn't run but it shows nil if i comment the above code out.
	-- -- print(availableIds)

  	-- -- Select a random ID and create the vehicle
  	-- if #availableIds > 0 then -- Ensure there are IDs in the table
    -- 	local randomIndex = math.random(#availableIds)
    -- 	local randomVehicleId = availableIds[randomIndex]
    -- 	create_vehicle(randomVehicleId, true, true)
    -- 	print("Created random vehicle with ID:", randomVehicleId)
  	-- else
    -- 	print("Error: No vehicle IDs found in availableIds.")
  	-- end
end


------
-- Misc functions
------

blow_up_vehicles_cheat = false
if blow_up_vehicles_cheat then
	blow_up_all_vehicles()
end

-- This will crash normally, with my new clothes changing function it will try and
--  check if the clothes exist first, if not it will log an error and just not do anything
--  which prevents crashing.
-- change_clothes("TT")

-- This works fine for changing clothes.
-- change_clothes("Sonny Forelli")

-- New for namespace testing
-- newtest.loginfo("Test123")

-- New for TCP server testing, sending message from client (the ReVC game)
-- send_msg_tcp_server("Message from lua on ReVC")

-- Send the players health to the TcpServer
-- send_msg_tcp_server("[ReVC]: Players health: " .. player_health())

-- Get the players health
-- print("[ReVC]: Players health: " .. player_health())
