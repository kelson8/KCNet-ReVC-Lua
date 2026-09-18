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

----------
--- For object spawning flags.
----------

-- If the save pickup has spawned.
map_pickups.savePickup1Spawned = false
-- Storage for the save pickup.
map_pickups.savePickup1 = nil
-- Has the player been teleported away from the save pickup?
map_pickups.playerTeleported = false

--- Create some save markers on the map
function map_pickups.create_save_markers()
    -- This should do nothing if the pickup is already spawned.
    if map_pickups.savePickup1Spawned then return end

    -- At the bridge for my current spawn.
    map_pickups.savePickup1 = game.create_pickup({ x = -13, y = 133, z = 28 }, map_pickups.saveGamePickup,
        pickup_enums.ePickupType.PICKUP_ONCE)
    -- print(savePickup1)
    map_pickups.savePickup1Spawned = true
end

--- Create some money pickups on the map
function map_pickups.money_pickups()
    game.create_money_pickup({ x = -13, y = 137, z = 28 }, 2000)
end

--- Create some hidden package pickups on the map
function map_pickups.hidden_package_pickups()
    game.create_hidden_package({ x = -13, y = 137, z = 28 })
end

--- Runs the loop for saving the game.
function map_pickups.save_loop()
    -----------------------
    --- Save pickup testing
    -----------------------
    ---
    -- TODO Try to replicate this below.
    -- Original script replication
    -- Clear area
    -- Set players heading

    -- I didn't expect game.wait to work in here like this.
    ---------------
    --- When the save pickups have been collected
    ---------------
    -- TODO Make this check if save pickup has been picked up and if so, save the game
    -- if savePickup1 and game.has_pickup_been_colleted(savePickup1) then
    if map_pickups.savePickup1 and map_pickups.savePickup1Spawned and game.has_pickup_been_colleted(map_pickups.savePickup1) then
        -- hud.print_msg("Game saved")
        map_pickups.savePickup1Spawned = false
        game.remove_pickup(map_pickups.savePickup1)
        map_pickups.savePickup1 = nil

        local newPlayerPos = { x = -18, y = 138, z = 27 }


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

        -- This sometimes sets the position twice, I think it's the flag I'm using here.
        -- if not map_pickups.playerTeleported then
            player.set_position(newPlayerPos)
            -- map_pickups.playerTeleported = true
        -- end

        -- This just breaks it here..
        -- Oh, I was trying to print a boolean directly, I have to use tostring on this
        -- if world.get_fading_status() then
        --     log_util.print_msg("Camera is fading")
        -- end

        game.wait(500)

        -- Fade the camera back in
        world.fade_camera(2.0, camera_enums.eFadeDirection.FADE_IN)
        -- log_util.print_msg("Attempting to fade in...")
        -- Re-enable player movement.
        player.set_control(true)

        -- The player was teleported.
        -- If this isn't changed it'll keep spawning them on the save pickup.
        -- map_pickups.playerTeleported = false

        -- log_util.print_msg("Has camera faded: " .. tostring(world.get_fading_status()))

        -- if not world.get_fading_status() then
        --     log_util.print_msg("Camera is not fading")
        -- end

    end

    ---------------
    --- Respawn the save pickups
    ---------------
    -- This should respawn the save pickup if it is used.
    if map_pickups.savePickup1 == nil and not map_pickups.savePickup1Spawned and not map_pickups.playerTeleported then
        -- This works for respawning the pickup!
        map_pickups.savePickup1 = game.create_pickup({ x = -13, y = 133, z = 28 }, map_pickups.saveGamePickup,
            pickup_enums.ePickupType.PICKUP_ONCE)
        -- hud.print_msg("Respawn pickup")

        map_pickups.savePickup1Spawned = true

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
