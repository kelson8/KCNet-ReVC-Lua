-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 kelson8

-----------------------
--- KCNet Freeroam - Interiors.
-----------------------

interiors = {}

-- I probably won't implement all of these.
-- Or I might, especially if they arent too hard to do.

interiors.isInStripClub = false
interiors.isInMall = false
interiors.isInHotel = false

interiors.isInShootingRange = false
interiors.isInCopShop = false

interiors.isInCafe = false
interiors.isInMansion = false

interiors.isInMalibuClub = false
interiors.isInbank = false
interiors.isInapartment3c = false

-- Run the interior for the hotel.
-- TODO Fix this to work right.
-- I will need to replicate most of these functions for this, but it shouldn't be too hard.
-- Most of the original scripts were checking quite a bit so I can strip most of it out.
function interiors.hotel_loop()
    -- if player.is_in_zone("BEACH1")
    --     and player.is_in_area_3d(222.0, -1274.0, 11.0, 229.0, -1280.7, 14.0, false)
    -- then
    --     world.set_area_visible("VIS_HOTEL")
    --     world.switch_rubbish(false)
    --     player.set_position(225.0, -1277.3, 11.5)
    --     player.set_heading(80.0)
    --     world.set_extra_colors(3, false)
    -- end
end
