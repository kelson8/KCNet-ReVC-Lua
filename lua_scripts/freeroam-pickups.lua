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
    game.create_money_pickup({x = -13, y = 137, z = 28}, 2000)
end

--- Create some hidden package pickups on the map
function map_pickups.hidden_package_pickups()
    game.create_hidden_package({x = -13, y = 137, z = 28})
end

--- Runs the loop for saving the game.
function map_pickups.save_loop()
    -----------------------
    --- Save pickup testing
    -----------------------

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

        local newPlayerPos = { x = player.get_position().x, y = player.get_position().y + 2, z = player.get_position().z }

        -- TODO Try to fix the fading in here, it doesn't work.
        -- world.fade_camera(2000.0, camera_enums.eFadeDirection.FADE_OUT)
        player.set_position(newPlayerPos)
        -- world.fade_camera(2000.0, camera_enums.eFadeDirection.FADE_IN)


        -- TODO Try to replicate this below.
        -- Original script replication
        -- Fade the camera in
        -- Clear area
        -- Set player near the save point
        -- Set players heading
        --

        -- Place player elsewhere
        -- Respawn save pickup

        -- Fade the camera back out
    end

    ---------------
    --- Respawn the save pickups
    ---------------
    -- This should respawn the save pickup if it is used.
    if map_pickups.savePickup1 == nil and not map_pickups.savePickup1Spawned then
        -- This works for respawning the pickup!
        map_pickups.savePickup1 = game.create_pickup({ x = -13, y = 133, z = 28 }, map_pickups.saveGamePickup,
            pickup_enums.ePickupType.PICKUP_ONCE)
        -- hud.print_msg("Respawn pickup")

        map_pickups.savePickup1Spawned = true
    end
end
