
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
