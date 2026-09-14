#!/usr/bin/env lua

-- #!/bin/sh

-- _=[[
-- IFS=":"
-- for dir in $PATH; do
--     for lua in "$dir"/lua "$dir"/lua5* "$dir"/luajit*; do
--         if [ -x "$lua" ]; then
--             exec "$lua" "$0" "$@"
--         fi
--     done
-- done
-- printf '%s: no lua found\n' "$0" >&2
-- exit 1
-- ]]
-- _ = nil


-- TODO Use the above for other things.
-- I am now able to execute this script directly.
-- So if it has 755 permissions, you can run './convert-locations.lua' in the console.
-- Although I won't keep this in game scripts, just development ones.

-- I can also just use this lua hashbang '#!/usr/bin/env lua',
-- but it only works with regular lua and not luajit or the other lua versions.
-- 

-- https://artemis.sh/2021/04/25/lua-hashbang-executable-lua-script.html

-- New for reading from my save format and other json files like lists of locations.
-- local json = dofile("ViceExtended/lua_scripts/lib/dkjson.lua")
local json = dofile("../lib/dkjson.lua")

-- This converts a list of locations from freeroam-locations.lua to my new json format.
-- I can easily adapt locations like the ones from the Cheat Menu here
-- The assets for the user-grinch Cheat Menu can be found below
-- https://github.com/user-grinch/Cheat-Menu/releases/tag/3.52

local input_path = "freeroam-locations.lua"
local output_path = "freeroam-locations.json"

-- Load the Lua table.
local locations, load_error = dofile(input_path)

if not locations then
    error("Could not load " .. input_path .. ": " .. tostring(load_error))
end

if type(locations) ~= "table" then
    error(input_path .. " must return a Lua table")
end

-- Encode the table as formatted JSON.
local json_text, encode_error = json.encode(
    locations,
    {
        indent = true,

        -- This will make sure it is in the same order each time
        -- Sometimes this would print in the wrong order like z, y, x, instead of like it should.
        keyorder = {
            "pos",
            "heading",
            "x",
            "y",
            "z"
        }
    }
    --

)

if not json_text then
    error("Could not encode locations as JSON: " .. tostring(encode_error))
end

-- Add a space after the JSON object-key colons.
-- json_text = json_text:gsub("(\"([^\"]-)\"):", "%1: ")

-- This will also work for adding spaces after the object-keys.
-- It only works since the JSON object keys are always quoted.
json_text = json_text:gsub("\":", "\": ")

-- Open the output file.
local output_file, open_error = io.open(output_path, "w")

if not output_file then
    error("Could not open " .. output_path .. ": " .. tostring(open_error))
end

-- Write the formatted JSON.
output_file:write(json_text)
output_file:write("\n")
output_file:close()

print("Converted " .. input_path .. " to " .. output_path)
