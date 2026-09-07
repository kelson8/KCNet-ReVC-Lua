-- This format works with my setup! I had to have a subdirectory for it.
dofile("ViceExtended/lua_scripts/freeroam-locations.lua")

-- Obtained from freeroam-locations.lua
local oldSpawn = GameLocations.oldSpawn
local airport = GameLocations.airport
local policeStation = GameLocations.policeStation
local construction_site = GameLocations.constructionSiteVehicle

-- TODO Attempt to make freeroam_miami.scm load a custom script called freeroam-game.lua.

-- I will need to figure out how to disable the game scripts which might be a bit easy to do.

-- TODO Switch game from using .scm to lua. 
-- Reimplement the init player and other required startup functions into my player cheats for lua.
-- Or just call functions like that if I can.

-- TODO Make this able to be toggled in the ini, with a flag such as gbDisableGameScripts.
-- It should shut down the game scm scripting engine, return and exit out of some script functions.
-- Also this should do some things to prevent the game from crashing without the scripts in place.

-- Look into my Vice City scm scripts repo for setting up the player and other scm script examples.
-- https://git.internal.kelsoncraft.net/kelson8/GTAVC-ScmScripts

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

-- Spawn in the player, mostly for spawning without the .scm scripts
-- This works in here now!
-------
-- REQUIRED if DISABLE_GAME_SCRIPTS is toggled on in the game code, otherwise it won't spawn the player.
-- Locations are stored in freeroam-locations.lua, and more can be added.
-------

-- This only runs once in the init, if there are more then one of the create_player functions they won't do anything.
-- Fixes some bugs I was having, which was spawning multiple players for me to control lol.

-- Init player, spawn them in.

-- Spawn at the custom spawn in the middle of the map.
-- create_player(0, oldSpawn.pos.x, oldSpawn.pos.y, oldSpawn.pos.z)

-- Spawn at the airport.
-- create_player(0, airport.pos.x, airport.pos.y, airport.pos.z)

-- Spawn at the police station.
-- create_player(0, policeStation.pos.x, policeStation.pos.y, policeStation.pos.z)

-- Spawn at the construction site.
-- create_player(0, construction_site.pos.x, construction_site.pos.y, construction_site.pos.z)

-- Spawn player at spawn set in freeroam-locations.lua
-- I got this working with my new table setup in freeroam-locations.lua!
-- To find a spawn position, look into the GameLocations table in freeroam-locations.lua.
-- create_player(0, construction_site.pos.x, construction_site.pos.y, construction_site.pos.z)
player.create(0, construction_site.pos.x, construction_site.pos.y, construction_site.pos.z)

--------
-- End REQUIRED
--------

--------
-- Game Tick
-- Runs all the time
-- WARNING do not put anything in here that will crash, such as spawning vehicles or creating the player.
-- You will spam the command and the game will crash pretty quickly
--------

-- This runs every frame (called by the C++ Update/Heartbeat)
function OnTick()
    -- TODO Implement getting player keybinds in lua directly, I should be able to.
--     if GetPlayerKey('W') then
        -- Do something
--     end

    -- Kill player if they get cops
    -- This works, although I need to start a new game to change these in the tick function.
	-- kill_wanted_player()
-- 	player.kill_wanted()
end

--------
-- Custom functions go below
--------

local enableNeverWanted = false
local enableInfiniteHealth = false

-- Set ped density to 0.0
local disablePeds = true
-- Set vehicle density to 0.0
local disableVehicles = true

local blow_up_cars_toggle = false

local clear_area_toggle = false

-- If this is disabled, you won't lose weapons when busted or wasted.
local lose_weapons = true

-----------
-- Toggles
-----------

-- Toggle losing weapons on death.
if not lose_weapons then
	player.disable_lose_weapons_on_death()
else
	player.enable_lose_weapons_on_death()
end


-- Blow up all cars cheat
if blow_up_cars_toggle then
	blow_up_all_vehicles()
end

-- Clear the area of any peds and vehicles.
if clear_area_toggle then
	world.clear_area(25)
end

-- Turn the ped density multiplier to 0.0
if disablePeds then
	world.disable_peds()
end

-- Turn the vehicle density multiplier to 0.0
if disableVehicles then
	world.disable_vehicles()
end

-- Fixes below here, if game is reloaded with F5 these never get disabled.
-- So this just always disables them if they aren't toggled.
-- Although these have a cheat activated message, I'll deal with this later.
-- For now they can manually be disabled with the keybind events or something.
if enableNeverWanted then
	player.enable_never_wanted()
else
--     player.disable_never_wanted()
end

if enableInfiniteHealth then
	player.enable_infinite_health()
else
--     player.disable_infinite_health()
end

-----------
-- End Toggles
-----------

-- TODO Implement these in this freeroam-game.lua script.

-- Create some vehicles

-- Currently this can be called by adding it into the kcnet-keybind-events.lua file and pressing 'F9'.
-- Vehicle ID, posX, posY, posZ, Delete last vehicle, Warp into vehicle.
-- create_vehicle(145, spawnX + 10, spawnY + 10, spawnZ + 2, false, false)
-- TODO Fix this to work in the freeroam-game.lua script.
-- create_vehicle(145, airportX + 10.0, airportY + 10.0, airportZ + 2.0, false, false)

-- Spawn some peds

