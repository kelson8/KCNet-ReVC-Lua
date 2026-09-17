
This is a list of lua changelogs for my KCNet-ReVC-Lua game build.

The below list will be my internal version numbering for ReVC, if there are some version numbers skipped it's because I didn't change very much in the lua scripts or it was mostly just bug fixes or something.

This will be updated when I make a lot of changes to these scripts, add new functions into the ReVC code to be used in the lua scripts, or when I add new globals to toggle specific hard coded features on and off.

# 1.2.11

### 1.2.11-3a

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

### 1.2.12-4a

feat: Move some function toggles and remove enable/disable methods

* Makes functions like 'player.enable_never_wanted', into 'player.set_never_wanted(true)'.

* Add blip testing, this can now set a blip onto the map.

* I changed some of the toggles to just be one function instead of having two for each toggle option.

* Set the players spawn point to one of the pay n spray garages for testing.

* Add garage testing into kcnet-keybind-events.lua.

### 1.2.12-6a

* Add world.switch_roads_on and world.switch_roads_off to lua functions.

* Add custom set ped density and set vehicle density functions for my lua scripts.

* Setup random number generator testing in freeroam-game.lua.

* Add event enums to freeroam-enums.lua.

### 1.2.12-7a

* Add player.get_position, which returns the players position as a CVector.

### 1.2.12-12a

* Add game.add_explosion, I have fixed this to work.

* I setup the ped and vehicle density values to be custom instead of either on or off.

* Fix blow up all vehicles in freeroam-game.lua.

* Setup new player.get_position variable for getting the players position as a vector.

* I removed the playerX, playerY, and playerZ globals from the C++ code, so I removed them in kcnet-keybind-events.lua.

* Add event enums into freeroam-enums.lua.

* Update changelogs and documentation.

# 1.2.13

### 1.2.13-1a

feat: Add give and remove weapon functions

* I added these and now you can give weapons, and remove weapons from a specific slot.

* Setup a random vehicle spawner with the getRandomVehicleId function.

* Add hud namespace and print message to hud function.

* Add log namespace to log to the ReVC lua log files.

* Add blowing up current vehicle, and is in vehicle check to lua.

* Add toggles for everyone ignores player, and police ignore player in kcnet-keybind-events.lua.

* Disable some items in the eWeaponType enum, these are invalid and would probably crash anyways.

* Update changelogs and documentation.

### 1.2.13-3a

feat: Add json loading with dkjson and types.lua

* I added json loading to load from my custom save format.

* Add an example save named 'kcnet-revc-save.json'.

* Add new globals to readme.

* Update changelogs and documentation.

### 1.2.13-5a

feat: Add types for json save format, fix lua scripts

* I had to move the dkjson.lua dofile line into freeroam-functions.

* Add weather options into game namespace.

* Update changelogs and documentation.

### 1.2.13-9a

feat: Add stat load system, and blip testing

* I now have a stat save/load system working, currently you cannot save in lua just yet and only in my mod menu.

* Added most stats to be loaded in lua from the freeroam-game.lua file.

* Added types for the stats in types.lua

* Add test for creating objects, this crashes so it's disabled internally.

* Add set health, set armor, and get armor functions, previously I just had the heal function.

* Add stat enums, audio enums, and radar enums to freeroam-enums.lua.

* Add kcnet-revc-save.json to gitignore, and make kcnet-revc-save-example.json for use with repo.

* Update changelog, and documentation.

### 1.2.13-10a

feat: Add toggle for loading stats

* Now the stats loading from the json file can be turned off.
* Add weapon cheat functions into freeroam-functions.lua

* Update changelog.

### 1.2.13-13a

feat: Update set_ped_objectives function

* Now this can set custom actions on the peds in the area, instead of hardcoding specific ones.

* Make some variables and comments a bit more clear on the save system.

* Update changelog and documentation.

### Latest 1.2.13-14a

feat: Add blips file and set blips on startup

* Now blips work in my freeroam, although currently they cannot be modified or removed.

* Add freeroam-blips.lua for a list of blips.

* Add new tests into freeroam-coroutine-test.lua.

* Add lua_scripts/extra_functions to gitignore for now.

* Update changelog and documentation.

# 1.2.14

### 1.2.14-1a

feat: Make freeroam-blips store created blip ids

* Now freeroam-blips will store each blip ID so I can easily delete it elsewhere in the code.

* Add camera fade command and enums for fading.

* Add file exists check to freeroam-functions.lua.

* Update changelog and documentation.

### 1.2.14-2a

feat: Make save file load target marker position

* I made this to where it can now load the target marker position.

* Added world.set_marker for setting the marker.

* Update changelog and documentation.

### 1.2.14-3a

feat: Add more functions to lua

I added these below to be run in my scripts:

* game.get_minute
* game.get_hour

* player.get_money
* player.set_money

* world.set_car_generator
* world.toggle_car_generator

* Add log util into functions, which can print to the console with my message text.
* Add original wasted and busted locations and add a toggle for turning them on in freeroam-game.lua.

* Update changelog and documentation.

### 1.2.14-4a

feat: Update lua scripts

* Add toggle for setting marker in save.
* Make the save system load the players money.

* Move the save file path into freeroam-functions.

* Add most function types into types.lua for usages, not all of these are fixed in this file yet.

* Add toggle for infinite sprint with 'player.set_infinite_sprint'

* Add MD5 library for later usage in this project.

* Update changelog and documentation.

### 1.2.14-5a

feat: Add all garages from scripts

* I have added all of the garages from the original scripts to be used as pay n sprays.

* Add mostly all garage functions for use in my scripts.

* Add eZoneAttribs enum.

* Set ped and vehicle density back to 1.0 by default.

* Update changelog and documentation.

### 1.2.14-6a

feat: Add object spawning

* Enable island roadblocks for a test with objects spawning, by default this is disabled.

* Remove object spawning in kcnet-keybind-events.lua, move to init scripts.

* Add blips for pay n sprays to the map.

* Update changelog, and documentation.

### 1.2.14-7a

feat: Add wait timers like original scripts

* Now you can use game.wait for functions that require waiting, such as spawning models.

* Remove freeroam-coroutine-test.lua, it wasn't used.

* Add some more functions for testing.

* Update readme.

* Update changelog, and documentation.

### Latest 1.2.14-8a

**Commit 1**

feat: Add pickups to the game

* Now there is a basic save pickup at the bridge where I spawn, it doesn't fade the camera yet but it does get re-created like in the original scripts.

* Add pickup enums.

* Added most of the pickup functions that were in the original scripts.

* Move some config options into freeroam-config.lua.

* Update changelog and documentation.

**Commit 2**

feat: Fix fading with pickups

* Make camera fade in and out on save pickup.
* Make save pickup disable and re-enable players controls.

* Add MIT license header to most scripts.

* Update changelog and documentation.
