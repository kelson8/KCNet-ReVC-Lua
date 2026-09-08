-- Events to run when the player is wasted

-- The game time to pass when wasted, this is the default in game.
local time_to_pass = 720

-- print("KCNet -- Player wasted")

game.pass_time(time_to_pass)


-- TODO Get time in here from C++ code.
-- print("Advancing time to " .. )

-- Quick test for this here:
-- Log the player coordinates and heading when respawning.
local log_coords = false
local log_heading = false

if log_coords then
	log_player_coords()
end

if log_heading then
	log_player_heading()
end
