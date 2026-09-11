-- This will be a list of functions for my lua scripts that can be called easily
-- It will document them a bit

-- To use in another script:
-- dofile("ViceExtended/lua_scripts/freeroam-functions.lua")

file_util = {}
-- save_util = {}
vehicle_util = {}


-------------
-- File util
-------------

-- Read from a json file for the saves
-- local function read_json_file(filename)

--- Read from a json file for the custom JSON save format.
---@param filename any The json file to read from.
---@return nil
---@return string
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
		warpIntoVehicle     -- Should this warp the player into the vehicle, works fine now unless it's spammed.
	)
end
