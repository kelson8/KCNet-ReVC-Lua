
-- Custom types for the lua scripts.
-- Mostly things like CVector and other functions/variables that is useful to have here.

---@meta



--------------------------------
-- Functions
--------------------------------


---@meta

---@alias number_or_integer number
---@alias WeatherType integer
---@alias RadarSprite integer
---@alias WeaponType integer
---@alias StatType integer
---@alias FadeDirection integer
---@alias PhoneType integer
---@alias GarageType integer
---@alias ObjectId integer
---@alias ObjectHandle integer

---@class GameAPI
---@field add_blip_for_coord fun(position: CVector, sprite: RadarSprite, set_route: boolean)
---@field cheat fun(code: string)
---@field get_minute fun(): integer
---@field get_hour fun(): integer
---@field set_hospital_respawn fun(position: CVector, heading: number)
---@field set_police_respawn fun(position: CVector, heading: number)
---@field start_fire fun(position: CVector)
---@field pass_time fun(minutes: integer)
---@field force_weather fun(weather: WeatherType)
---@field force_weather_now fun(weather: WeatherType)
---@field release_weather fun()
---@field get_weather fun(): WeatherType
---@field set_allow_hurricanes fun(enabled: boolean)
---@field set_time fun(hour: integer, minute: integer)
---@field set_time_scale fun(scale: number)
---@field add_explosion fun(position: CVector, play_sound: boolean)
---@field override_next_restart fun(position: CVector, heading: number)
---@field cancel_override_restart fun()
---@field turn_phone_off fun(type: PhoneType)

---@class GarageAPI
---@field set fun(leftBottomX: number, leftBottomY: number, leftBottomZ: number, frontX: number, frontY: number, rightTopX: number, rightTopY: number, rightTopZ: number, type: GarageType): number
---@field close fun(garageId: number)
---@field open fun(garageId: number)
---@field is_open fun(garageId: number)
---@field is_closed fun(garageId: number)

---@class HudAPI
---@field print_msg fun(message: string)

---@class LogAPI
---@field info fun(message: string)
---@field warning fun(message: string)
---@field error fun(message: string)
---@field current_directory fun(): string

---@class PlayerAPI
---@field create fun(player_id: integer, position: CVector)
---@field set_position fun(position: CVector)
---@field get_health fun(): number
---@field set_health fun(health: number)
---@field get_armor fun(): number
---@field set_armor fun(armor: number)
---@field get_money fun(): integer
---@field get_position fun(): CVector
---@field heal fun()
---@field set_never_wanted fun(enabled: boolean)
---@field set_infinite_sprint fun(enabled: boolean)
---@field set_infinite_health fun(enabled: boolean)
---@field set_money fun(amount: integer)
---@field set_respawn_point fun(position: CVector)
---@field set_stat fun(stat: StatType, value: number)
---@field cancel_override_restart fun()
---@field lose_weapons_on_death fun(enabled: boolean)
---@field disable_lose_weapons_on_death fun()
---@field log_coords fun()
---@field log_heading fun()
---@field kill_wanted fun()
---@field kill fun()
---@field is_alive fun(): boolean
---@field change_clothes fun(clothes?: string)
---@field get_wanted_level fun(): integer
---@field tp_to_marker fun()
---@field give_weapon fun(weapon: WeaponType, ammo: integer)
---@field remove_weapon fun(slot: integer)
---@field give_rc_car fun()
---@field blow_up_vehicle fun()
---@field is_in_vehicle fun(): boolean

---@class VehicleAPI
---@field create fun(vehicle_id: integer, position: CVector, delete_last_vehicle: boolean, warp_into_vehicle: boolean)
---@field freeze_position fun(enabled: boolean)

---@class WorldAPI
---@field blow_up_all_vehicles fun()
---@field switch_roads_off fun(minimum: CVector, maximum: CVector)
---@field switch_roads_on fun(minimum: CVector, maximum: CVector)
---@field switch_ped_roads_off fun(minimum: CVector, maximum: CVector)
---@field switch_ped_roads_on fun(minimum: CVector, maximum: CVector)
---@field set_ped_density fun(density: number)
---@field set_vehicle_density fun(density: number)
---@field set_ped_objectives fun(
---    give_ped_weapons: boolean,
---    attack_player: boolean,
---    should_exit_vehicle: boolean,
---    kill_peds: boolean)
---)
---@field fade_camera fun(duration: number, direction: FadeDirection)
---@field set_marker fun(position: CVector)
---@field set_car_generator fun(...)
---@field toggle_car_generator fun(generator_id: integer, state: integer)
---@field create_object_no_offset fun(position: CVector, object: ObjectId): ObjectHandle
---@field does_object_exist fun(object_handle: ObjectHandle): boolean
---@field dont_remove_object fun(object_handle: ObjectHandle)
---@field remove_object fun(object_handle: ObjectHandle)
---@field set_object_collision fun(object_handle: ObjectHandle, state: boolean)

---@type GameAPI
game = {}

---@type HudAPI
hud = {}

---@type LogAPI
log = {}

---@type PlayerAPI
player = {}

---@type VehicleAPI
vehicle = {}

---@type WorldAPI
world = {}


---




--------------------------------
--- Vectors
--------------------------------

--------------------------------
-- CVector2D
--------------------------------

---@class CVector2D
---@field x number
---@field y number

--------------------------------
-- CVector
--------------------------------

---@class CVector
---@field x number
---@field y number
---@field z number

--------------------------------
--- Save file
--------------------------------


--------------------------------
-- Game time
--------------------------------

---@class SaveTime
---@field hours integer
---@field minutes integer
---@field millisecondsPerMinute integer

--------------------------------
-- Weather
--------------------------------

---@class SaveWeather
---@field forced integer
---@field interpolation number
---@field list integer
---@field new integer
---@field old integer

--------------------------------
-- Game data
--------------------------------

---@class SaveGame
---@field area integer
---@field level integer
---@field time SaveTime
---@field weather SaveWeather

--------------------------------
-- Player data
--------------------------------

---@class SavePlayer
---@field position CVector


--------------------------------
-- Map data
--------------------------------

---@class MapBlip
---@field target_marker CVector2D

--------------------------------
-- Player stats
--------------------------------

---@class SaveStats
---@field armor number
---@field health number
---@field money integer
---@field peds_killed_by_player number
---@field peds_killed_by_others number
---@field kills_since_last_checkpoint number
---@field kgs_of_explosives_used number
---------------------------------
---@field boats_exploded number
---@field helis_destroyed number
---@field vehicles_exploded number
---------------------------------
---@field bullets_that_hit number
---@field rounds_fired_by_player number
---@field days_passed number
---------------------------------
---@field distance_traveled_by_bike number
---@field distance_traveled_by_boat number
---@field distance_traveled_by_car number
---@field distance_traveled_by_golf_cart number
---@field distance_traveled_by_helicopter number
---@field distance_traveled_by_plane number
---@field distance_traveled_on_foot number
---------------------------------
---@field wanted_stars_evaded number
---@field wanted_stars_attained number
---------------------------------
---@field tires_popped number
---@field total_kills number
---@field times_arrested number
---@field times_died number
---@field times_drowned number
---@field seagulls_killed number
---------------------------------
---@field longest_stoppie_time number
---@field longest_stoppie_distance number
---@field longest_2_wheel_time number
---@field longest_2_wheel_distance number
---@field longest_wheelie_time number
---@field longest_wheelie_distance number
---------------------------------
---@field fires_extinguished number
---@field heads_popped number


--------------------------------
-- Complete save file
--------------------------------

---@class RevcSave
---@field format string
---@field game SaveGame
---@field player SavePlayer
---@field stats SaveStats
---@field version integer
---@field map MapBlip
