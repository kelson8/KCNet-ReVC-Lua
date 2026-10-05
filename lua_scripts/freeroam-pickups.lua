-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 kelson8

-- Main enums
dofile("ViceExtended/lua_scripts/freeroam-enums.lua")

-----------------------
--- KCNet Freeroam - Pickups on map
--- Added in v1.2.14-8a
-----------------------

map_pickups = {}

----------
--- Pickup ids to spawn in.
--- Pickup IDs can be obtained from here
--- https://gtastuff.com/models/?game=vc&q=save
----------

map_pickups.saveGamePickup = 411

-- The position of the save pickup that respawns.
map_pickups.saveGamePickup1Pos = { x = 3, y = 148, z = 19 }

-- The position to spawn at after saving
map_pickups.saveGamePickup1TeleportPos = { x = 10, y = 155, z = 19 }

map_pickups.saveGamePickup2Pos = { x = -1274.571, y = -840.917, z = 14.868 }
map_pickups.saveGamePickup2TeleportPos = { x = -1268.571, y = -840.917, z = 14.868 }
map_pickups.saveGamePickup2Heading = 187.11

----------
--- For object spawning flags.
----------

-- If the save pickup has spawned.
map_pickups.savePickup1Spawned = false
-- Storage for the save pickup.
map_pickups.savePickup1 = nil
-- Has the player been teleported away from the save pickup?
map_pickups.playerTeleported = false

map_pickups.savePickup2Spawned = false
map_pickups.savePickup2 = nil

-- If this should remove the items nearby such as peds, and vehicles.
map_pickups.removeNearbyItems = false
-- The radius near the player to remove items from if enabled above.
map_pickups.removeItemsRadius = 25

--- Create some save markers on the map
function map_pickups.create_save_markers()
    -- This should do nothing if the pickup is already spawned.
    if map_pickups.savePickup1Spawned or map_pickups.savePickup2Spawned then return end

    -- At the bridge for my current spawn.
    -- map_pickups.savePickup1 = game.create_pickup({ x = -13, y = 133, z = 28 }, map_pickups.saveGamePickup,
    map_pickups.savePickup1 = game.create_pickup(map_pickups.saveGamePickup1Pos, map_pickups.saveGamePickup,
        pickup_enums.ePickupType.PICKUP_ONCE)
    -- print(savePickup1)
    map_pickups.savePickup1Spawned = true

    map_pickups.savePickup2 = game.create_pickup(map_pickups.saveGamePickup2Pos, map_pickups.saveGamePickup,
        pickup_enums.ePickupType.PICKUP_ONCE)
    map_pickups.savePickup2Spawned = true
end

--- Create some money pickups on the map
function map_pickups.money_pickups()
    game.create_money_pickup({ x = -13, y = 137, z = 28 }, 2000)
end

--- Create some hidden package pickups on the map
function map_pickups.hidden_package_pickups()
    game.create_hidden_package({ x = -13, y = 137, z = 28 })
end

--- Save the game for my pickups.
--- Moved into a function to make this re-useable.
---@param position_to_respawn CVector The position to respawn at.
---@param heading number The heading to set the player to.
local function save_game_teleport(position_to_respawn, heading)
    -- I got the fading to work in here!
    -- Although I think adding these additional wait statements will break the other parts of the loop.
    -- At least while this is running, it should be fine though.

    -- Disable player movement.
    player.set_control(false)
    -- Fade the camera out for the save.
    -- world.fade_camera(1.0, camera_enums.eFadeDirection.FADE_OUT)
    world.fade_camera(2.0, camera_enums.eFadeDirection.FADE_OUT)

    -- log_util.print_msg("Attempting to fade out...")

    -- I don't know if this is working like the original scripts.
    -- while world.get_fading_status() do
    --     game.wait(0)
    -- end
    -- game.wait(1500)
    game.wait(2000)

    player.set_position(position_to_respawn)
    player.set_heading(heading)

    -- Clear the area near the player
    -- I may enable this later, it will remove the cars I have nearby.
    if map_pickups.removeNearbyItems then
        world.clear_area(map_pickups.removeItemsRadius)
    end

    game.wait(500)

    -- Fade the camera back in
    world.fade_camera(2.0, camera_enums.eFadeDirection.FADE_IN)
    -- log_util.print_msg("Attempting to fade in...")
    -- Re-enable player movement.
    player.set_control(true)

    -- Save the game
    -- This works!
    game.save()

    -- log_util.print_msg("Has camera faded: " .. tostring(world.get_fading_status()))

    -- if not world.get_fading_status() then
    --     log_util.print_msg("Camera is not fading")
    -- end
end

--- Runs the loop for saving the game.
function map_pickups.save_loop()
    -----------------------
    --- Save pickups
    -----------------------

    -- I didn't expect game.wait to work in here like this.
    -- This is required to be run in the OnTick in freeroam-game.lua to work.
    ---------------
    --- When the save pickups have been collected
    ---------------
    if map_pickups.savePickup1 and map_pickups.savePickup1Spawned and game.has_pickup_been_colleted(map_pickups.savePickup1) then
        -- Reset save pickup values back so it shows back up.
        map_pickups.savePickup1Spawned = false
        game.remove_pickup(map_pickups.savePickup1)
        map_pickups.savePickup1 = nil

        -- Save the game and teleport the player near the save pickup.
        save_game_teleport(map_pickups.saveGamePickup1TeleportPos, 0.0)

        -- Optional save message
        -- hud.print_msg("Game saved")
    end

    if map_pickups.savePickup2 and map_pickups.savePickup2Spawned and game.has_pickup_been_colleted(map_pickups.savePickup2) then
        -- Reset save pickup values back so it shows back up.
        map_pickups.savePickup2Spawned = false
        game.remove_pickup(map_pickups.savePickup2)
        map_pickups.savePickup2 = nil

        -- Save the game and teleport the player near the save pickup.
        save_game_teleport(map_pickups.saveGamePickup2TeleportPos, map_pickups.saveGamePickup2Heading)

        -- Optional save message
        -- hud.print_msg("Game saved")
    end

    ---------------
    --- Respawn the save pickups
    ---------------
    -- This should respawn the save pickup if it is used.
    if map_pickups.savePickup1 == nil and not map_pickups.savePickup1Spawned and not map_pickups.playerTeleported then
        -- This works for respawning the pickup!
        map_pickups.savePickup1 = game.create_pickup(map_pickups.saveGamePickup1Pos, map_pickups.saveGamePickup,
            pickup_enums.ePickupType.PICKUP_ONCE)
        -- hud.print_msg("Respawn pickup")

        map_pickups.savePickup1Spawned = true
    end

    if map_pickups.savePickup2 == nil and not map_pickups.savePickup2Spawned and not map_pickups.playerTeleported then
        -- This works for respawning the pickup!
        map_pickups.savePickup2 = game.create_pickup(map_pickups.saveGamePickup2Pos, map_pickups.saveGamePickup,
            pickup_enums.ePickupType.PICKUP_ONCE)

        map_pickups.savePickup2Spawned = true
    end
end

--- Run the save loop every tick
--- Well I don't think this works in other files like this..
-- function OnTick()
--     while true do
--         game.wait(0)
--         map_pickups.save_loop()
--     end
-- end
