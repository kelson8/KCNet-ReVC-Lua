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

--- Setup the bomb shop garages on the map.
function garage_util.setup_bomb_garages()
    local bombShop1 = BombGarages.docks_bomb1

    -- Internally this is normally bomb shop 3, so I'll use that for the enum.
    garage.set(bombShop1.leftBottom.x, bombShop1.leftBottom.y, bombShop1.leftBottom.z,
        bombShop1.front.x, bombShop1.front.y,
        bombShop1.rightTop.x, bombShop1.rightTop.y, bombShop1.rightTop.z,
        garage_enums.eGarageType.GARAGE_BOMBSHOP3)
end

--- Setup a few of the safe house garages.
--- TODO Fix these to work for saving vehices into.
--- I will eventually setup a garage save test in the future.
function garage_util.setup_safehouse_garages()
    local mansionGarage1 = SafehouseGarages.mansion1

    -- These safe house garages seem to use the GARAGE_HIDEOUT types.
    garage.set(mansionGarage1.leftBottom.x, mansionGarage1.leftBottom.y, mansionGarage1.leftBottom.z,
        mansionGarage1.front.x, mansionGarage1.front.y,
        mansionGarage1.rightTop.x, mansionGarage1.rightTop.y, mansionGarage1.rightTop.z,
        garage_enums.eGarageType.GARAGE_HIDEOUT_ELEVEN)

    -- TODO Implement these later
    -- garage.set_rotating_garage_door
    -- garage.no_special_camera_for_this_garage
    -- garage.set_maxiumum_number_of_cars_in_garage

    -- garage.set_maxiumum_number_of_cars_in_garage garage11 2
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
