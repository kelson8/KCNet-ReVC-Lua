-- Events to run when the player is busted

-- The game time to pass when busted, this is the default in game.
local time_to_pass = 720

-- print("KCNet -- Player busted")

game.pass_time(time_to_pass)


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
