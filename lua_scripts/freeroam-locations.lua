-----------
-- Locations
-----------

-- To use this in another script:

--[[

dofile("ViceExtended/lua_scripts/freeroam-locations.lua")

local construction_site = GameLocations.constructionSiteVehicle

create_player(0, construction_site.pos.x, construction_site.pos.y, construction_site.pos.z)

vehicle_util.create_vehicle(145, construction_site.pos.x, construction_site.pos.y, construction_site.pos.z, false, false)
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
        },
        heading = 0.0
    },

    ------
    -- Values below are from the main.scm.
    ------

    -- Hospitals
    -- Island 1
    hospital1 = {
        pos = {
            x = 493.5,
            y = 703.1,
            z = 11.1
        },
        heading = 90.0
    },

    hospital2 = {
        pos = {
            x = -108.3,
            y = -974.4,
            z = 9.4
        },
        heading = 283.9
    },

    -- Island 2
    hospital3 = {
        pos = {
            x = -822.7,
            y = 1157.9,
            z = 10.1
        },
        heading = 4.0
    },

    hospital4 = {
        pos = {
            x = -885.2,
            y = -470.4,
            z = 12.1
        },
        heading = 276.0
    },

    -- Police stations
    -- Island 1
    policeSt1 = {
        pos = {
            x = 508.9,
            y = 506.8,
            z = 10.3
        },
        heading = 174.0
    },

    policeSt2 = {
        pos = {
            x = 398.8,
            y = -469.7,
            z = 10.7
        },
        heading = 323.0
    },

    -- Island 2
    policeSt3 = {
        pos = {
            x = -659.5,
            y = 760.4,
            z = 10.5
        },
        heading = 133.0
    },

    policeSt4 = {
        pos = {
            x = -871.9,
            y = -682.3,
            z = 10.2
        },
        heading = 328.1
    },
}

-- -- Set the area to place the player with the 'F9' keybind here.
-- mainSpawnX = constructionSiteVehiclePos.x

-- mainSpawnY = constructionSiteVehiclePos.y
-- mainSpawnZ = constructionSiteVehiclePos.z
