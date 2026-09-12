
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

--------------------------------
-- Complete save file
--------------------------------

---@class RevcSave
---@field format string
---@field game SaveGame
---@field player SavePlayer
---@field stats SaveStats
---@field version integer