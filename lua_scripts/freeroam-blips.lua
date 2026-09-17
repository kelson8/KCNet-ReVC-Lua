-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 kelson8

-- For loading locations
dofile("ViceExtended/lua_scripts/freeroam-locations.lua")

-- Base folder for the Lua scripts in ReVC.
local base_folder = "ViceExtended/lua_scripts/"

-- Obtained from freeroam-locations.lua
local oldSpawn = GameLocations.oldSpawn
local airport = GameLocations.airport
local policeStation = GameLocations.policeStation
local construction_site = GameLocations.constructionSiteVehicle
local payNSpray1 = GameLocations.payNSpray1

-----------------------
--- KCNet Freeroam - Blips
-----------------------

-- Moved out of freeroam-game.lua, originally in kcnet-keybind-events.lua.

-- Well being in this file seems to work, although I cannot get the blip afterwards or remove it.
-- This says it's nil in kcnet-keybind-events.lua.

-- At least I know I can load them up now though.
-- I'll have to load a list of locations from my json files for this.

local blipPos = { x = airport.pos.x, y = airport.pos.y, z = airport.pos.z }
local blipPos2 = { x = payNSpray1.pos.x - 25, y = payNSpray1.pos.y, z = payNSpray1.pos.z }

local respray1Blip = { x = -3.8, y = -1265.8, z = 12.0 }
local respray2Blip = { x = 319.0, y = 441.3, z = 12.0 }
local respray3Blip = { x = -903.0, y = -1261.1, z = 12.0 }
local respray4Blip = { x = -876.2, y = -105.5, z = 12.0 }

map_blips = {}

local blip_ids = {}

-- local blip_file = "ViceExtended/lua_scripts/current_blip.txt"
local blip_file = base_folder .. "current_blip.txt"

--- This stores the blip to the file
--- The problem with this is it was putting the file in the game folder.
--- I couldn't see it in this lua scripts directory anyways.
--- This is mostly a temporary solution until I fully figure this out.
---@param blip_id any
local function store_blip(blip_id)
-- local function store_blip(blip_id, blip_id2)
    -- function store_blip(blip_id)

    -- local file_mode = nil

    -- if file_util.does_file_exist(blip_file) then
        -- file_mode = "a"
    -- else
        -- file_mode = "w"
    -- end

    local file, err = io.open(blip_file, "w")
    -- local file, err = io.open(blip_file, file_mode)

    if not file then
        return nil, "Could not open file: " .. tostring(err)
    end

    file:write(blip_id .. "\n")
    file:close()
end

--- Get the current blip created by this script.
--- TODO Make this support more then one later.
---@return nil
---@return string
function map_blips.get_current_blip()
    local file, err = io.open(blip_file, "r")

    if not file then
        return nil, "Could not open file: " .. tostring(err)
    end

    local contents = file:read("*a")
    file:close()

    return contents
end

--- This sets up the blips on the map.
--- It should only ever be run in freeroam-game.lua in the OnInit function.
function map_blips.setup()
    -- map_blips.currentBlip1 = game.add_blip_for_coord(blipPos, radar_enums.eRadarSprite.RADAR_SPRITE_SAVE, false)
    local currentBlip1 = game.add_blip_for_coord(blipPos, radar_enums.eRadarSprite.RADAR_SPRITE_SAVE, false)
    -- local currentBlip2 = game.add_blip_for_coord(blipPos1, radar_enums.eRadarSprite.RADAR_SPRITE_HARDWARE, false)
    -- local currentBlip2 = game.add_blip_for_coord(blipPos2, radar_enums.eRadarSprite.RADAR_SPRITE_SPRAY, false)

    -- Add the respray blips
    -- TODO Make these short range blips, that is what the game normally does.
    -- For now it's fine.
    game.add_blip_for_coord(respray1Blip, radar_enums.eRadarSprite.RADAR_SPRITE_SPRAY, false)
    game.add_blip_for_coord(respray2Blip, radar_enums.eRadarSprite.RADAR_SPRITE_SPRAY, false)
    game.add_blip_for_coord(respray3Blip, radar_enums.eRadarSprite.RADAR_SPRITE_SPRAY, false)
    game.add_blip_for_coord(respray4Blip, radar_enums.eRadarSprite.RADAR_SPRITE_SPRAY, false)

    -- Log the current blip id into the file.
    -- This currently works for one value.
    -- store_blip(currentBlip1, currentBlip2)
    store_blip(currentBlip1)

    -- TODO Try to add a table list of blips to store into the json file.
    -- This should make the file have a json format like this:
    ---
    --- {
    ---     blip1_id: 1,
    ---     blip2_id: 2,
    ---     blip3_id: 3
    --- }
    ---
    ---
    ---

    -- I can store only one of these in the file below.
    -- If I do more then one it'll either overwrite the file or append too many values to it.
    -- table.insert(blip_ids, currentBlip1)
    -- table.insert(blip_ids, currentBlip2)

    -- for i = 1, #blip_ids do
    --     store_blip(blip_ids[i])
    -- end

    -- print("Blip IDs: " .. blip_ids[1])
end

-- function map_blips.get_blip()
--     if map_blips.currentBlip1 ~= nil then
--         print("Blip is active. ")
--     end
-- end
