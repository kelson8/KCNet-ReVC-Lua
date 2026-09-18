-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 kelson8

-----------------------
--- KCNet Freeroam - Markers.
-----------------------


-- These markers work, although I forgot the kcnet-keybind-events cannot toggle this in the loop.

markers = {}
markers.test_marker1_active = false


--- Draw a test marker in a loop near the player.
--- This is currently broken and needs worked on.
function markers.test_loop1()
    -- game.wait(0)
    -- -- TODO Test this, sphere testing
    -- if markers.test_marker1_active then
    --     world.draw_sphere(1,
    --         { x = player.get_position().x + 3, y = player.get_position().y + 3, z = player.get_position().z + 5 }, 5.0)
    -- end
end
