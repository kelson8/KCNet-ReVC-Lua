-- SPDX-License-Identifier: MIT
-- Copyright (c) 2026 kelson8

-----------------------
--- KCNet Freeroam - Config script
--- This will mostly be used for config options.
-----------------------

config = {}

-- If this is enabled, my freeroam will spawn you near the hospitals and police stations that are in the scripts.
config.use_original_spawns = false

-- If this is set, the game time is locked.
config.lock_game_time = false
-- The time to lock the game to.
config.locked_hour = 10
config.locked_minute = 55

--------
-- For future use
-- TODO Implement these.
--------

---- Setting window size and height on startup

-- If this is true, the window will be set to a smaller size on the game startup.
-- So I can more easily test scripts and code without having to make the window smaller each time.
config.windowed_set_size_startup = false

-- Supported video modes for vice city
-- This below was on my monitor, could be different for others.
-- 800x600
-- 832x624
-- 1024x768
-- 1280x720 - 720p
-- 1152x864
-- 1280x800
-- 1280x960
-- 1440x900
-- 1280x1024
-- 1680x1050
-- 1920x1080 - 1080p
config.window_height = 1280
config.window_width = 720

--------
-- End for future use
--------

-- If this is set, it will load the custom save file.
-- Which is named 'kcnet-revc-save.json'.
-- Otherwise it just sets a debug position to spawn at.
-- TODO Make this into a global or something for the game init.
-- Since I updated the code to auto load the save on game start, this can no longer turn it off.
-- 
-- This now gets set in the freeroam-game.lua.
-- config.read_save_data = true
