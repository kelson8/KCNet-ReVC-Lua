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

-- If this is set, it will load the custom save file.
-- Which is named 'kcnet-revc-save.json'.
-- Otherwise it just sets a debug position to spawn at.
config.read_save_data = true
