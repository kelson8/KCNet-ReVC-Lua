
This below will be my internal version numbering for ReVC.


# Latest - 1.2.11-3a

feat: Change lua scripts a bit and update with new functions

* Add enums with freeroam-enums.lua.

* Move player init function into OnInit in freeroam-game.lua, not implemented and needs fixed.

* Update player.create function to use a vector instead of floats for the values.

* Moved ReVC time to pass variable when wasted and busted into kcnet-wasted.lua and kcnet-busted.lua.

* When I fix it, my OnInit function will only run once on game startup.

* Add lua cheat code testing into kcnet-keybind-events.lua.

* Add cheat codes, starting fires, clearing an area, and unlocking all doors in area to kcnet-keybind-events.lua.

* Add freeroam-functions.lua for helper functions.

* Add Lua-Documentation.md, which is currently incomplete.

* Add vehicle.freeze_position function for freezing the vehicle in place.

* Update readme, add Lua-Changelogs.md, and add gitignore.

# Latest - 1.2.12-4a

feat: Move some function toggles and remove enable/disable methods

* Makes functions like 'player.enable_never_wanted', into 'player.set_never_wanted(true)'.

* Add blip testing, this can now set a blip onto the map.

* I changed some of the toggles to just be one function instead of having two for each toggle option.

* Set the players spawn point to one of the pay n spray garages for testing.

* Add garage testing into kcnet-keybind-events.lua.

# Latest 1.2.12-6a

* Add world.switch_roads_on and world.switch_roads_off to lua functions.

* Add custom set ped density and set vehicle density functions for my lua scripts.

* Setup random number generator testing in freeroam-game.lua.

* Add event enums to freeroam-enums.lua.

# Latest 1.2.12-7a

* Add player.get_position, which returns the players position as a CVector.

# Latest 1.2.12-12a

* Add game.add_explosion, I have fixed this to work.

* I setup the ped and vehicle density values to be custom instead of either on or off.

* Fix blow up all vehicles in freeroam-game.lua.

* Setup new player.get_position variable for getting the players position as a vector.

* I removed the playerX, playerY, and playerZ globals from the C++ code, so I removed them in kcnet-keybind-events.lua.

* Add event enums into freeroam-enums.lua.

* Update changelogs and documentation.
