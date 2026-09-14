-- For loading locations
dofile("ViceExtended/lua_scripts/freeroam-locations.lua")

local airport = GameLocations.airport

-----------------------
--- KCNet Freeroam - Blips
-----------------------

-- Moved out of freeroam-game.lua, originally in kcnet-keybind-events.lua.

-- Well being in this file seems to work, although I cannot get the blip afterwards or remove it.
-- This says it's nil in kcnet-keybind-events.lua.

-- At least I know I can load them up now though.
-- I'll have to load a list of locations from my json files for this.

local blipPos = { x = airport.pos.x, y = airport.pos.y, z = airport.pos.z }

map_blips = {}

map_blips.currentBlip1 = nil
map_blips.currentBlip1Set = false

--- This sets up the blips on the map.
--- It should only ever be run in freeroam-game.lua in the OnInit function.
function map_blips.setup()
	if map_blips.currentBlip1 == nil and not map_blips.currentBlip1Set then
		map_blips.currentBlip1 = game.add_blip_for_coord(blipPos, radar_enums.eRadarSprite.RADAR_SPRITE_SAVE, false)
		print("Blip 1 set at position.")
		map_blips.currentBlip1Set = true
	end
end
