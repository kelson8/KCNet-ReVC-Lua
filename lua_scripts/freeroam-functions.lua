-- This will be a list of functions for my lua scripts that can be called easily
-- It will document them a bit

-- To use in another script:
-- dofile("ViceExtended/lua_scripts/freeroam-functions.lua")

-------------
-- Misc
-------------

-------------
-- Vehicle
-------------

--- Create a vehicle at the specified coords
-- This can create a vehicle at any coordinates.
-- Basic lua function to call this, which is in C++.
-- @param id The vehicle model id to spawn in
-- @param pos The CVector position, like this {x = 2, y = 2, z = 2}
-- @param deletePreviousVehicle If this deletes the previous vehicle, boolean.
--
function create_vehicle(id, pos, deletePreviousVehicle, warpIntoVehicle)
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
