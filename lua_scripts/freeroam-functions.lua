-- This will be a list of functions for my lua scripts that can be called easily
-- It will document them a bit

-- To use in another script:
-- dofile("ViceExtended/lua_scripts/freeroam-functions.lua")

blip_util = {}

file_util = {}
-- save_util = {}
vehicle_util = {}

local current_blip = nil

-- New for json testing from my save file format
-- dofile("ViceExtended/lua_scripts/lib/dkjson.lua")

-- For package path
-- TODO Test this later.
-- package.path = package.path .. ";ViceExtended/lua_scripts/lib/?.lua"

local json = dofile("ViceExtended/lua_scripts/lib/dkjson.lua")

------------
-- Blip
-- TODO Try to fix these.
------------
---


-- function blip_util.set_blip(coords)
-- 	if current_blip ~= nil then
-- 		game.remove_blip(current_blip)
-- 		current_blip = nil
-- 	end

-- 	current_blip = game.add_blip_for_coord(
-- 		coords,
-- 		radar_enums.eRadarSprite.RADAR_SPRITE_SAVE,
-- 		false
-- 	)

-- 	return current_blip
-- end

-- function blip_util.remove_blip()
-- 	if current_blip ~= nil then
-- 		game.remove_blip(current_blip)
-- 		current_blip = nil
-- 	end
-- end

-------------
-- File util
-------------

-- Read from a json file for the saves
-- local function read_json_file(filename)

--- Read from a json file for the custom JSON save format.
---@param filename string The json file to read from.
---@return RevcSave|nil data
---@return string|nil error
function file_util.read_json_file(filename)
	local file, err = io.open(filename, "r")

	if not file then
		return nil, "Could not open file: " .. tostring(err)
	end

	local contents = file:read("*a")
	file:close()

	local data, position, decode_err = json.decode(contents, 1, nil)

	if decode_err then
		return nil, string.format(
			"JSON error at position %s: %s",
			tostring(position),
			tostring(decode_err)
		)
	end

	---@diagnostic disable-next-line: missing-return-value
	return data
end

-- TODO Make a save player data function here in lua once I get enough values replicated to be used in here.
-- function save_util.save_player_data(filename)

-- end

-------------
-- Vehicle
-------------

--- Create a vehicle at the specified coordinates.
--- This is a basic helper function for this that can give some type hints with VSCode.
---@param id number The vehicle model id to spawn in
---@param pos CVector The CVector position, like this {x = 2, y = 2, z = 2}
---@param deletePreviousVehicle boolean If this deletes the previous vehicle, boolean.
---@param warpIntoVehicle boolean If the player warps into the vehicle
function vehicle_util.create_vehicle(id, pos, deletePreviousVehicle, warpIntoVehicle)
	vehicle.create(
		id,
		-- CVector of the position to spawn the vehicle.
		{
			x = pos.x,
			y = pos.y,
			z = pos.z
		},
		deletePreviousVehicle, -- Should this remove the previous vehicle, now this works for removing the last spawned vehicle.
		warpIntoVehicle  -- Should this warp the player into the vehicle, works fine now unless it's spammed.
	)
end
