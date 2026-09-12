
-- Custom types for the lua scripts.
-- Mostly things like CVector and other functions/variables that is useful to have here.

---@meta

--------------------------------
--- Vectors
--------------------------------

--------------------------------
-- CVector2D
--------------------------------

---@class CVector2D
---@field x number
---@field y number

--------------------------------
-- CVector
--------------------------------

---@class CVector
---@field x number
---@field y number
---@field z number

--------------------------------
--- Save file
--------------------------------


--------------------------------
-- Game time
--------------------------------

---@class SaveTime
---@field hours integer
---@field minutes integer
---@field millisecondsPerMinute integer

--------------------------------
-- Weather
--------------------------------

---@class SaveWeather
---@field forced integer
---@field interpolation number
---@field list integer
---@field new integer
---@field old integer

--------------------------------
-- Game data
--------------------------------

---@class SaveGame
---@field area integer
---@field level integer
---@field time SaveTime
---@field weather SaveWeather

--------------------------------
-- Player data
--------------------------------

---@class SavePlayer
---@field position CVector

--------------------------------
-- Player stats
--------------------------------

---@class SaveStats
---@field armor number
---@field health number
---@field money integer
---@field peds_killed_by_player number
---@field peds_killed_by_others number
---@field kills_since_last_checkpoint number
---@field kgs_of_explosives_used number
---------------------------------
---@field boats_exploded number
---@field helis_destroyed number
---@field vehicles_exploded number
---------------------------------
---@field bullets_that_hit number
---@field rounds_fired_by_player number
---@field days_passed number
---------------------------------
---@field distance_traveled_by_bike number
---@field distance_traveled_by_boat number
---@field distance_traveled_by_car number
---@field distance_traveled_by_golf_cart number
---@field distance_traveled_by_helicopter number
---@field distance_traveled_by_plane number
---@field distance_traveled_on_foot number
---------------------------------
---@field wanted_stars_evaded number
---@field wanted_stars_attained number
---------------------------------
---@field tires_popped number
---@field total_kills number
---@field times_arrested number
---@field times_died number
---@field times_drowned number
---@field seagulls_killed number
---------------------------------
---@field longest_stoppie_time number
---@field longest_stoppie_distance number
---@field longest_2_wheel_time number
---@field longest_2_wheel_distance number
---@field longest_wheelie_time number
---@field longest_wheelie_distance number
---------------------------------
---@field fires_extinguished number
---@field heads_popped number


--------------------------------
-- Complete save file
--------------------------------

---@class RevcSave
---@field format string
---@field game SaveGame
---@field player SavePlayer
---@field stats SaveStats
---@field version integer