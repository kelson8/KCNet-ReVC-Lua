# KCNet-ReVC-Lua

This is the custom lua scripts for my modified build of ReVC.

These will be a full replacement for the `main.scm` game script and will allow anyone to make a freeroam type game much easier then using the `.scm` language, and it can be easily reloaded by pressing `F5` in the game.

This has no game code at all and just has a couple of lua scripts for when am ready to and when I do publish my ReVC build.

I won't always keep this up to date with my internal tests since I am changing quite a bit on how these lua scripts work sometimes and the designs to them aren't final.

Eventually I would like to try and publish my modified ReVC build somewhere which will require a copy of GTA Vice City for the assets, you will be required to own GTA Vice City to be able to get the assets, this release will only provide an executable and a couple of extra assets required for my ReVC build.

## About ReVC build

**List of changes**

Here is a list of some changes for this ReVC build below, this is not a full and complete list I will have to make a list of what all I have changed in this ReVC build later.

Any folders listed below are going to be located in the ReVC directory.

* Add an ImGui mod menu to be used with `F8`.
* Setup lua script loading for replacing the game scripts.

* Makes some files get loaded from the `ViceExtended` folder.

* Make `Save stats` output read from custom base html and css, instead of hardcoding the values for it.

* Make `Save stats` option in pause menu save stats to `ViceExtended/stats`

* Add a lot of functions for my lua scripts, mod menu and call a lot of in game functions.

* Setup logs that go into `ViceExtended/logs` for logging errors, info and lua messages.

* Setup fonts for mod menu in `ViceExtended/fonts`, which are from the [Cheat Menu](https://github.com/user-grinch/Cheat-Menu) by user-grinch on GitHub, I am also using the style from their mod menu.

## About

I started working on this project on 9-4-2026 and have made some progress in replacing the game scripts.

This is not and never will be a full game script replacement, since I have to recreate and replicate a lot of the script functions I will only be working on the more important ones like MTA SA would do.

This has been tested and fully works even if I remove the `main.scm`, `main_d.scm` and `freeroam_miami.scm` out of data, since my ReVC build with the modified option in the `config.h` just disables the `.scm` language entirely and switches to my Lua script replacement.

When I have the game mission scripts disabled, I also have saving/loading of the normal game save files completely disabled so it won't load any game saves, and most of the script init and start functions have been patched out but I can toggle it in my code.

This is done to prevent save games being loaded or attempting to save with invalid data and corrupting a save.

Also, the load and delete game options are still in the menu, but they are blank for now until I figure out how to remove them without breaking the game.

**Keybinds**

| Keybind | Description |
| ------ | ------|
| F5 | If `gbReloadLuaScriptWithKeybind` is set to true in `freeroam-game.lua`, this will reload the `freeroam-game.lua` script, so it'll respawn the player and is required when you update values in the `OnTick` function. |
| F8 | You can open my custom ImGui mod menu to mess around with using this keybind. |
| F9 | This runs the `kcnet-keybind-events.lua` script, mostly for spawning vehicles and teleporting the player quickly. |

**Files**

Here is a list of files and what they are for.

Not all of these are in use just yet for my freeroam scripts, some are required for other parts of my ReVC code.

| File | Description |
| ----- | --------- |
| freeroam-game.lua | This spawns the player and does other game init functions that the `main.scm` normally would take care of. |
| freeroam-locations.lua | This is a list of locations that can be used in all of the scripts, currently used for spawning the player and spawning vehicles in `kcnet-keybind-events.lua`. |
| kcnet-busted.lua | Events that run when you get busted. |
| kcnet-wasted.lua | Events that run when you get wasted. |
| kcnet-keybind-events.lua | Events in this file will run when the F9 key is pressed, I may make this keybind configurable later. |

**Tick function**

My Lua code has an `OnTick` function that runs every game tick, you can put functions like `player.kill_wanted_player()` in there to run which will kill the player if they get cops.

I don't have too much that is safe to run in the tick functions just yet, and the tick function will run anything placed in it so it might crash easily especially if a vehicle is spawned every tick.

There needs to be some crash protection implemented with the tick function.

**Globals**

There are some global values that get read from the `freeroam-game.lua` script like in the original scripts.

These values get read in the game code, and will be reloaded when `F5` is pressed to reload, or a new game is started.

| Global Toggle | Description |
| ------ | ------ |
| gbVehiclesDontCatchFireWhenTurningOver | If this is enabled, vehicles won't catch fire when turning upside down. |
| gbReloadLuaScriptWithKeybind  | If this is enabled you can press `F5` to reload the game, if it isn't you can still press `New Game` in the pause menu. |

## Future plans

If I ever get enough experience with it, and can do it I might make a multiplayer for ReVC using lua as the scripting like what [MTA San Andreas](https://multitheftauto.com/) does, but that will be a long way off I still have to make some of the scripts work and fix the bugs I have currently.

I plan on making most of the game functions along with my custom functions able to be called in the lua scripts, and to be able to easily modify functions already in the game such as what weapons the police spawn with, and other stuff to mess aroudn with.

There may be a basic json save/load system in the future that saves a very small set of stats to a `revc-freeroam-save.json` file using the [nlohmann json](https://github.com/nlohmann/json) library, this would mostly be for keeping like a high score system or something I'm not really sure yet.

Since I can modify just about everything in ReVC, I may try to implement chaos mod features that can activate random actions also.

I will be adding a `Lua-Documentation.md` file in the future that will contain info about the Lua functions that can be called, the parameters they take and other useful lua features for this ReVC build.

# License

These scripts are licensed under the MIT license.
