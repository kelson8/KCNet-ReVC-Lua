-- This will be a list of functions for my lua scripts that can be called easily
-- It will document them a bit

-- To use in another script:
-- dofile("ViceExtended/lua_scripts/freeroam-functions.lua")

blip_util = {}

cheat_functions = {}

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

------------
-- Cheat functions
------------

--- Runs weapon cheat 1.
function cheat_functions.weapon_cheat1()
	local weaponAmmo = 100
	-- This gives the player a weapon with some ammo
	-- You can use any weapons from the eWeaponType enum in freeroam-enums.lua.
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_BRASSKNUCKLE, 1)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_BASEBALLBAT, 1)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_MOLOTOV, weaponAmmo)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_COLT45, weaponAmmo)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_SHOTGUN, weaponAmmo)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_TEC9, 100)

	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_RUGER, weaponAmmo)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_SNIPERRIFLE, weaponAmmo)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_FLAMETHROWER, weaponAmmo)
end

--- Runs weapon cheat 2.
function cheat_functions.weapon_cheat2()
	local weaponAmmo = 100
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_KATANA, 1)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_GRENADE, weaponAmmo)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_DETONATOR, weaponAmmo)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_PYTHON, weaponAmmo)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_STUBBY_SHOTGUN, weaponAmmo)

	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_SILENCED_INGRAM, weaponAmmo)

	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_M4, weaponAmmo)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_LASERSCOPE, weaponAmmo)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_ROCKETLAUNCHER, weaponAmmo)
end

--- Runs weapon cheat 3.
function cheat_functions.weapon_cheat3()
	local weaponAmmo = 100

	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_CHAINSAW, 1)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_GRENADE, weaponAmmo)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_PYTHON, weaponAmmo)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_SPAS12_SHOTGUN, weaponAmmo)

	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_MP5, weaponAmmo)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_M4, weaponAmmo)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_LASERSCOPE, weaponAmmo)
	player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_MINIGUN, weaponAmmo)
	-- TODO What is minigun2? I'm not sure what it is for.
	-- player.give_weapon(weapon_enums.eWeaponType.WEAPONTYPE_MINIGUN, weaponAmmo)

end

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

------------
-- Player
------------



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
