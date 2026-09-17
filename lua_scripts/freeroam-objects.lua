-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 kelson8

-----------------------
--- KCNet Freeroam - Objects setup.
-----------------------

object_util = {}

-------------------------
--- Object spawning/testing
--- Object IDs can be found on this website
--- https://gtastuff.com/models/?game=vc
--- These objects can now return the object handle, so they can be removed later on.
-------------------------

-- 9-16-2026 @ 1:20PM
-- This works now!
-- Spawn an object on the map.
-- I disabled the has model loaded check and now this spawns in, although that doesn't make much sense.
-- TODO Make this not crash on invalid models.
-- For now, this will crash if the model is invalid, I'm not sure of what model IDs are valid.

-- Road block 1, porn studio
local nt_roadblock_ci = 590

-- Road block 2, golf course
local nt_roadblock_gf = 2141

-- One of the gates for the islands.
local com_gate1_open = 2444
local com_gate1_base = 2445
local com_gate1_closed = 2446

local com_gate2_open = 2443
local com_gate2_base = 2442
local com_gate2_closed = 2447

-- Trash bin
-- local object_id = 352

--- Setup all the objects on the map.
--- This will be used for custom objects that I add.
--- TODO Make it to where I can remove these objects.
--- I'll need to store the game ID of the ones that I have spawned.
function object_util.setup_objects()

end

--- Setup all the road blocks on the map
--- TODO Make this also disable the roads like the game normally would.
--- Otherwise, the peds will drive to walk and drive through this.
function object_util.setup_road_blocks()
    -- Test for creating the gates for the bridges
    -- Starfish island gates
    world.create_object_no_offset({ x = -715.082, y = -489.689, z = 12.549 }, com_gate1_closed)
    world.create_object_no_offset({ x = -181.451, y = -472.61, z = 11.353 }, com_gate2_closed)

    -- Porn studio roadblock
    world.create_object_no_offset({ x = -97.3, y = 1061.8, z = 11.6 }, nt_roadblock_ci)

    -- Golf course roadblock
    world.create_object_no_offset({ x = -81.46, y = 81.358, z = 21.04 }, nt_roadblock_gf)
    
    -- These can be used like this for returning the handle.
    -- I may store a list of all object handles, blip handles and everything into a JSON file on startup.
    -- So they can easily be modified while the game is running.
    -- local golfCouseRdHandle = world.create_object_no_offset({ x = -81.46, y = 81.358, z = 21.04 }, nt_roadblock_gf)

    -- print("Gold course road block handle: " .. golfCouseRdHandle)

    -- South roadblock, TODO There are a few objects for this.
end
