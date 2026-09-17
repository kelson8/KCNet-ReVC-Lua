-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 kelson8

-- For locations
dofile("ViceExtended/lua_scripts/freeroam-locations.lua")

-- For functions such as spawning vehicles, lua helper functions.
dofile("ViceExtended/lua_scripts/freeroam-functions.lua")

garage_util = {}

-----------------------
--- KCNet Freeroam - Garages init script
--- This should only ever be called in freeroam-game.
--- Otherwise it may create more then one garage.
-----------------------


--- Setup all of the garages for the game.
--- TODO Make this store in a temporary text/json file.
--- Until I can get this storing the list of set garages in the C++ code, so I can manually open/close them.
function garage_util.setup_garages()
    for garageName, garageData in pairs(GameGarages) do
        -- Debug for printing the garages.
        -- print("Garage: ", garageName)

        -- print("Left bottom: X: " .. garageData.leftBottom.x ..
        --     " Y: " .. garageData.leftBottom.y ..
        --     " Z: " .. garageData.leftBottom.z)

        -- print("Front: X: " .. garageData.front.x ..
        --     " Y: " .. garageData.front.y)

        -- print("Right Top: X: " .. garageData.rightTop.x ..
        --     " Y: " .. garageData.rightTop.y ..
        --     " Z: " .. garageData.rightTop.z)
        --

        -- Set all the garages.
        garage.set(garageData.leftBottom.x, garageData.leftBottom.y, garageData.leftBottom.z,
            garageData.front.x, garageData.front.y,
            garageData.rightTop.x, garageData.rightTop.y, garageData.rightTop.z,
            garage_enums.eGarageType.GARAGE_RESPRAY)
    end

    log_util.print_msg("All garages have been setup")
end

--- Toggle a garage
--- TODO Make this check if the player is in a garage.
--- If this is toggled while I am inside of a garage, I am softlocked until I use the suicide cheat.
---@param garage_id GarageType
function garage_util.toggle_garage(garage_id)
    -- This says the garage is open? this part is working now.
    -- TODO Add a check if the player is in the garage, if this is toggled while they are in it, the game locks up.
    -- Hmm, there is a player check, maybe I'll expose this in my lua scripts
    -- m_bPlayerIsInGarage
    if garage.is_open(garage_id) then
        -- print("Garage with id " .. garage_id .. " is open")
        garage.close()
    elseif garage.is_closed(garage_id) then
        garage.open()
        -- print("Garage with id " .. garage_id .. " is closed")
    else
        -- This prints if the garage is invalid.
        print("Garage is possibly invalid, could not be opened or closed.")
    end
end
