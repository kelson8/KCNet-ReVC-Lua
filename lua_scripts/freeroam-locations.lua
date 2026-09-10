-----------
-- Locations
-----------

-- To use this in another script:

--[[

dofile("ViceExtended/lua_scripts/freeroam-locations.lua")

local construction_site = GameLocations.constructionSiteVehicle

create_player(0, construction_site.pos.x, construction_site.pos.y, construction_site.pos.z)

create_vehicle(145, construction_site.pos.x, construction_site.pos.y, construction_site.pos.z, false, false)
]]

GameLocations = {
    -- Spawn in the middle of the map.
    oldSpawn = {
        pos = {
            x = -258.1,
            y = -453.1,
            z = 13.5
        },
        heading = 0.0
    },

    airport = {
        pos = {
            x = -1515.1,
            y = -1182.1,
            z = 16.5
        },
        heading = 0.0
    },

    policeStation = {
        pos = {
            x = 402.371,
            y = -463.671,
            z = 10.1132
        },
        heading = 0.0

    },

    -- local airportHeading = 0.0

    constructionSiteVehicle = {
        pos = {
            x = 252.169,
            y = -232.353,
            z = 10.901
        },
        heading = 0.0
    },

    -- Pay N Spray garages
    payNSpray1 = {
        pos = {
            x = -863.353,
            y = -125.406,
            z = 11.078
        }
    }
}

-- -- Set the area to place the player with the 'F9' keybind here.
-- mainSpawnX = constructionSiteVehiclePos.x

-- mainSpawnY = constructionSiteVehiclePos.y
-- mainSpawnZ = constructionSiteVehiclePos.z
