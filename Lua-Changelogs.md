
This is a list of lua changelogs for my KCNet-ReVC-Lua game build.

The below list will be my internal version numbering for ReVC, if there are some version numbers skipped it's because I didn't change very much in the lua scripts or it was mostly just bug fixes or something.

This will be updated when I make a lot of changes to these scripts, add new functions into the ReVC code to be used in the lua scripts, or when I add new globals to toggle specific hard coded features on and off.

# 1.2.11

# 1.2.11-3a

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

# 1.2.12

# 1.2.12-4a

feat: Move some function toggles and remove enable/disable methods

* Makes functions like 'player.enable_never_wanted', into 'player.set_never_wanted(true)'.

* Add blip testing, this can now set a blip onto the map.

* I changed some of the toggles to just be one function instead of having two for each toggle option.

* Set the players spawn point to one of the pay n spray garages for testing.

* Add garage testing into kcnet-keybind-events.lua.

# 1.2.12-6a

* Add world.switch_roads_on and world.switch_roads_off to lua functions.

* Add custom set ped density and set vehicle density functions for my lua scripts.

* Setup random number generator testing in freeroam-game.lua.

* Add event enums to freeroam-enums.lua.

# 1.2.12-7a

* Add player.get_position, which returns the players position as a CVector.

# 1.2.12-12a

* Add game.add_explosion, I have fixed this to work.

* I setup the ped and vehicle density values to be custom instead of either on or off.

* Fix blow up all vehicles in freeroam-game.lua.

* Setup new player.get_position variable for getting the players position as a vector.

* I removed the playerX, playerY, and playerZ globals from the C++ code, so I removed them in kcnet-keybind-events.lua.

* Add event enums into freeroam-enums.lua.

* Update changelogs and documentation.

# 1.2.13

# Latest 1.2.13-1a

feat: Add give and remove weapon functions

* I added these and now you can give weapons, and remove weapons from a specific slot.

* Setup a random vehicle spawner with the getRandomVehicleId function.

* Add hud namespace and print message to hud function.

* Add log namespace to log to the ReVC lua log files.

* Add blowing up current vehicle, and is in vehicle check to lua.

* Add toggles for everyone ignores player, and police ignore player in kcnet-keybind-events.lua.

* Disable some items in the eWeaponType enum, these are invalid and would probably crash anyways.

* Update changelogs and documentation.

# Latest 1.2.13-3a

feat: Add json loading with dkjson and types.lua

* I added json loading to load from my custom save format.

* Add an example save named 'kcnet-revc-save.json'.

* Add new globals to readme.

* Update changelogs and documentation.

### Latest 1.2.13-5a

feat: Add types for json save format, fix lua scripts

* I had to move the dkjson.lua dofile line into freeroam-functions.

* Add weather options into game namespace.

* Update changelogs and documentation.
