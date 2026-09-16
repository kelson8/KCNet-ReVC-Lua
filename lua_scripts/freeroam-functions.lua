-- This will be a list of functions for my lua scripts that can be called easily
-- It will document them a bit

-- To use in another script:
-- dofile("ViceExtended/lua_scripts/freeroam-functions.lua")
dofile("ViceExtended/lua_scripts/freeroam-locations.lua")

-- New for reading from my save format and other json files like lists of locations.
local json = dofile("ViceExtended/lua_scripts/lib/dkjson.lua")


-- TODO Try to make fading work in my lua scripts for teleporting the player
-- I will be giving the scripts more control once I implement more, so you can load collisions and more.
-- I plan on re-creating my teleport function in lua from the C++ code.

-- COMMAND_DO_FADE

blip_util = {}

cheat_functions = {}

file_util = {}
log_util = {}

player_functions = {}

-- If this is turned off, this script won't attempt to load the save data from kcnet-revc-save.json.
-- Otherwise it will attempt to load the save data.
-- I plan on using the saved stats for like a high score system or something.
-- Also, to keep track of how long you have had 1-6 stars and more stats.
-- I will be adding a lot to this once I figure this out and some events and objectives to play with.
player_functions.load_stats = true

-- If this is enabled, it will load the saved marker from the save data if it exists.
-- Otherwise, it will just not display any user placed marker on the map.
-- I have this currently disabled by default, so it doesn't always load a marker.
player_functions.load_saved_marker = false

save_functions = {}
-- save_util = {}
vehicle_util = {}

local current_blip = nil



-- For package path
-- TODO Test this later.
-- package.path = package.path .. ";ViceExtended/lua_scripts/lib/?.lua"


--- I can add a deprecated message to a function with this, could be useful for later when I get a more stable API.
-- -@deprecated

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
-- These pretty much run the original cheat codes from Vice City.
------------

--- Runs weapon cheat 1.
function cheat_functions.weapon_cheat1()
	local weaponAmmo = 100
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

file_util.save_path = "ViceExtended/kcnet-revc-save.json"

--- Check if a file exists
--- https://stackoverflow.com/questions/4990990/check-if-a-file-exists-with-lua
---@param file_name string The file to check.
---@return boolean If the file exists.
function file_util.does_file_exist(file_name)
	local f = io.open(file_name, "r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end

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
--- Log util
------------
---
---

--- This will log a message with my custom prefix for the KCNet freeroam.
---@param message string The message to print to the console.
function log_util.print_msg(message)
	print("[KCNet-ReVC-Lua]: " .. message)
end

--- This will log an error message with my custom prefix for the KCNet freeroam.
---@param message string The message to print to the console.
function log_util.print_error(message)
	print("[KCNet-ReVC-Lua][Error]: " .. message)
end


------------
-- Save file validation
-- This says the save is valid in the below test! I guess it works
-- I should use this.
------------

---@param save RevcSave
---@return boolean valid
---@return string? error_message
function save_functions.validate_save(save)
	if type(save) ~= "table" then
		return false, "Save data is not a table"
	end

	-- If wanting to use custom save versions, disable this below and switch to the lua enum.
	-- This currently reads from my ReVC code.
	if save.version ~= EXPECTED_SAVE_VERSION then
	-- if save.version ~= custom_save.eSaveVersion.save_version then
		return false, "Invalid save version"
	end

	if save.format ~= EXPECTED_SAVE_FORMAT then
	-- if save.format ~= custom_save.eSaveVersion.save_format then
		return false, "Invalid save format"
	end

	if type(save.player) ~= "table"
		or type(save.player.position) ~= "table" then
		return false, "Missing player position"
	end

	if type(save.stats) ~= "table" then
		return false, "Missing stats"
	end

	return true
end

-------
--- Test for save being valid
--- This works!
-------


local function test_save_validate(file)
	local save_file, err = file_util.read_json_file(file)
	if not save_file then
		print(err)
		return
	end

	local is_save_valid = save_functions.validate_save(save_file)
	if is_save_valid then
		log_util.print_msg("ReVC Freeroam save was valid!")
	else
		log_util.print_error("ReVC Freeroam save was invalid!")
	end
end

-- test_save_validate(file_util.save_path)

------------
-- Player

------------

--- Run a fade effect on the player
--- TODO Fix this to work, currently it doesn't for some reason.
--- @param time number The time for the fade in miliseconds.
function player_functions.fade_effect(time)
	world.fade_camera(time, camera_enums.eFadeDirection.FADE_OUT)
	game.wait(3000)
	world.fade_camera(time, camera_enums.eFadeDirection.FADE_IN)
end

--- Kill the player when their health is low
--- This is mostly a test for the new game.wait command in freeroam-game.lua.
function player_functions.low_health_kill()
	if player.get_health() < 60 then
		player.kill()
	end
end

-- Temporary

local airport = GameLocations.airport
local policeStation = GameLocations.policeStation

--- Teleport the player to a random position
--- TODO Set this up to get where the player is, and set a bounds for this.
function player_functions.random_position()
	-- local minTeleport = {x = 25, y = 25, z = 20}
	local minTeleport = { x = airport.pos.x, y = airport.pos.y, z = airport.pos.z }
	local maxTeleport = { x = policeStation.pos.x, y = policeStation.pos.y, z = policeStation.pos.z }
	-- local maxTeleport = {x = 50, y = 50, z = 25}
	-- local maxTeleport = {x = 50, y = 50, z = 25}

	local randomPosition = {
		x = math.random(minTeleport.x, maxTeleport.x),
		y = math.random(minTeleport.y, maxTeleport.y),
		z = math.random(minTeleport.z, maxTeleport.z)
	}

	-- TODO Make this get a random position from the list above.

	player.set_position(randomPosition)
end

--------------
-- Player Stats
-- TODO Move into freeroam-save.lua.
--------------

--- Load the saved position for the player
---
--- This is separate so I can load the player before the stats.
--- Otherwise the game will crash.
---
---@param file string
-- -@return CVector
function player_functions.get_saved_position(file)
	local save_file, err = file_util.read_json_file(file)
	if not save_file then
		print(err)
		return
	end

	local playerX = save_file.player.position.x
	local playerY = save_file.player.position.y
	local playerZ = save_file.player.position.z


	return { x = playerX, y = playerY, z = playerZ }
end

--- Load the stats for the player
---
---@param file string
function player_functions.load_save_stats(file)
	-- local save_file_path = "ViceExtended/kcnet-revc-save.json"

	-- If this type value is here, it uses the type defined in types.lua.
	-- Since I modified the read_json_file function, this doesn't seem to be needed so I'll comment it out.
	-- -@type RevcSave
	local save_file, err = file_util.read_json_file(file)
	if not save_file then
		print(err)
		return
	end


	--------
	-- All required save values
	--------
	local forcedWeather = save_file.game.weather.forced
	local oldWeather = save_file.game.weather.old
	local newWeather = save_file.game.weather.new



	local gameHour = save_file.game.time.hours
	local gameMinute = save_file.game.time.minutes

	-- Stats
	-- Currently these don't get loaded, although I could enable them.
	local playerHealth = save_file.stats.health
	local playerArmor = save_file.stats.armor
	local playerMoney = save_file.stats.money
	-- local playerMoney = save_file.stats.money

	local boatsExploded = save_file.stats.boats_exploded
	local helisExploded = save_file.stats.helis_destroyed
	local carsExploded = save_file.stats.vehicles_exploded

	-- Peds killed
	local killsSinceLastCheckpoint = save_file.stats.kills_since_last_checkpoint
	local headsPopped = save_file.stats.heads_popped
	local peopleKilledByPlayer = save_file.stats.peds_killed_by_player
	local peopleKilledByOthers = save_file.stats.peds_killed_by_others
	local totalKills = save_file.stats.total_kills

	local daysPassed = save_file.stats.days_passed

	local wantedStarsAttained = save_file.stats.wanted_stars_attained
	local wantedStarsEvaded = save_file.stats.wanted_stars_evaded

	local bulletsThatHit = save_file.stats.bullets_that_hit
	local explosivesUsed = save_file.stats.kgs_of_explosives_used

	-- Distance travelled
	local distanceTravelledByBike = save_file.stats.distance_traveled_by_bike
	local distanceTravelledByBoat = save_file.stats.distance_traveled_by_boat
	local distanceTravelledByCar = save_file.stats.distance_traveled_by_car
	local distanceTravelledByGolfCar = save_file.stats.distance_traveled_by_golf_cart
	local distanceTravelledByHelicopter = save_file.stats.distance_traveled_by_helicopter
	local distanceTravelledByPlane = save_file.stats.distance_traveled_by_plane
	local distanceTravelledOnFoot = save_file.stats.distance_traveled_on_foot

	local firesExtinguished = save_file.stats.fires_extinguished
	local timesArrested = save_file.stats.times_arrested
	local timesDied = save_file.stats.times_died
	local timesDrowned = save_file.stats.times_drowned

	local tiresPopped = save_file.stats.tires_popped


	local seagullsKilled = save_file.stats.seagulls_killed

	-- Longest stoppies and other stats.
	local longest2WheelDistance = save_file.stats.longest_2_wheel_distance
	local longest2WheelTime = save_file.stats.longest_2_wheel_time
	local longestStoppieDistance = save_file.stats.longest_stoppie_distance
	local longestStoppieTime = save_file.stats.longest_stoppie_time
	local longestWheelieDistance = save_file.stats.longest_wheelie_distance
	local longestWheelieTime = save_file.stats.longest_wheelie_time

	-- Target marker
	local targetMarkerPos = { x = save_file.map.target_marker.x, y = save_file.map.target_marker.y }

	-----
	-- Save file version and format.
	local saveFileVersion = save_file.version
	local saveFileFormat = save_file.format
	--
	-------

	-- TODO Add error handling to this.
	-- If the version or save format is changed or invalid it shouldn't try to load or save that file.
	if saveFileVersion == custom_save.eSaveVersion.save_version then
		log_util.print_msg("The save version is valid")
	else
		log_util.print_error("The save version is invalid! Cannot load the save file!")
		return
	end

	if saveFileFormat == custom_save.eSaveVersion.save_format then
		log_util.print_msg("The save file format is valid")
	else
		log_util.print_error("The save file format is invalid! Cannot load the save file!")
		return
	end

	-- Set the players health and armor
	-- This works for setting the players health and armor.
	-- player.set_health(playerHealth)
	-- player.set_armor(playerArmor)

	-------------------------------
	--- Stat loading
	-------------------------------

	-- Stop the game loading here if the stats shouldn't be loaded.
	-- The game will still run fine, but it won't load any stats.
	-- Useful for debugging and testing, so the stats don't get corrupted.
	if not player_functions.load_stats then return end

	-- Save and restore some stats such as how many peds were wasted, how many times the player was wasted and more.
	player.set_stat(stat_enums.eStatType.CARS_EXPLODED, carsExploded)
	player.set_stat(stat_enums.eStatType.BOATS_EXPLODED, boatsExploded)
	player.set_stat(stat_enums.eStatType.HELIS_DESTROYED, helisExploded)

	-- Setting distance travelled.
	player.set_stat(stat_enums.eStatType.DISTANCE_TRAVELLED_BY_BIKE, distanceTravelledByBike)
	player.set_stat(stat_enums.eStatType.DISTANCE_TRAVELLED_BY_BOAT, distanceTravelledByBoat)
	player.set_stat(stat_enums.eStatType.DISTANCE_TRAVELLED_BY_CAR, distanceTravelledByCar)
	player.set_stat(stat_enums.eStatType.DISTANCE_TRAVELLED_BY_GOLF_CART, distanceTravelledByGolfCar)
	player.set_stat(stat_enums.eStatType.DISTANCE_TRAVELLED_BY_HELICOPTOR, distanceTravelledByHelicopter)
	player.set_stat(stat_enums.eStatType.DISTANCE_TRAVELLED_BY_PLANE, distanceTravelledByPlane)
	player.set_stat(stat_enums.eStatType.DISTANCE_TRAVELLED_ON_FOOT, distanceTravelledOnFoot)

	player.set_stat(stat_enums.eStatType.WANTED_STARS_ATTAINED, wantedStarsAttained)
	player.set_stat(stat_enums.eStatType.WANTED_STARS_EVADED, wantedStarsEvaded)

	player.set_stat(stat_enums.eStatType.BULLETS_THAT_HIT, bulletsThatHit)

	player.set_stat(stat_enums.eStatType.TYRES_POPPED, tiresPopped)

	player.set_stat(stat_enums.eStatType.SEAGULLS_KILLED, seagullsKilled)

	-- Peds killed
	-- player.set_stat(stat_enums.eStatType.HEADS_POPPED, headsPopped)
	player.set_stat(stat_enums.eStatType.PEOPLE_KILLED_BY_OTHERS, peopleKilledByOthers)
	player.set_stat(stat_enums.eStatType.PEOPLE_KILLED_BY_PLAYER, peopleKilledByPlayer)
	player.set_stat(stat_enums.eStatType.TOTAL_LEGITIMATE_KILLS, totalKills)
	player.set_stat(stat_enums.eStatType.KILLS_SINCE_LAST_CHECKPOINT, killsSinceLastCheckpoint)


	-- Longest stoppie, 2 wheels and more
	player.set_stat(stat_enums.eStatType.LONGEST_2_WHEEL_DIST, longest2WheelDistance)
	player.set_stat(stat_enums.eStatType.LONGEST_2_WHEEL, longest2WheelTime)
	player.set_stat(stat_enums.eStatType.LONGEST_STOPPIE_DIST, longestStoppieDistance)
	player.set_stat(stat_enums.eStatType.LONGEST_STOPPIE, longestStoppieTime)
	player.set_stat(stat_enums.eStatType.LONGEST_WHEELIE_DIST, longestWheelieDistance)
	player.set_stat(stat_enums.eStatType.LONGEST_WHEELIE, longestWheelieTime)

	-- player.set_stat(stat_enums.eStatType.FIRES_EXTINGUISHED, firesExtinguished)

	-- Times died and other stuff.
	player.set_stat(stat_enums.eStatType.TIMES_ARRESTED, timesArrested)
	player.set_stat(stat_enums.eStatType.TIMES_DIED, timesDied)
	player.set_stat(stat_enums.eStatType.TIMES_DROWNED, timesDrowned)

	-- Days passed
	player.set_stat(stat_enums.eStatType.DAYS_PASSED, daysPassed)

	-- Explosives
	player.set_stat(stat_enums.eStatType.KGS_OF_EXPLOSIVES_USED, explosivesUsed)

	------------------------
	-- End setting stats
	------------------------

	-- Set the previous weather
	game.force_weather(newWeather)
	game.force_weather_now(newWeather)

	-- Set the game time
	game.set_time(gameHour, gameMinute)

	if player_functions.load_saved_marker then
		-- Set the world blip marker if it was stored.
		-- I got this working in v1.2.14-2a.
		world.set_marker(targetMarkerPos)
	end

	-- New, for setting the players money.
	player.set_money(playerMoney)

end

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
