-- Events to run when the player is busted

print("KCNet -- Player busted")

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
