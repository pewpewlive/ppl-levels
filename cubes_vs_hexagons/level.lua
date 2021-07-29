-- ---------------------------------- --
-- Rolling Cubes vs Spinning Hexagons --
-- --------- by: Tasty Kiwi --------- --
-- ---------------------------------- --

-- Import helpers
local angle_helpers = require("/dynamic/helpers/angle_helpers.lua")
local player_helpers = require("/dynamic/helpers/player_helpers.lua")
local floating_message = require("/dynamic/helpers/floating_message.lua")
local shield_box = require("/dynamic/helpers/boxes/shield_box.lua")
local cannon_box = require("/dynamic/helpers/boxes/cannon_box.lua")

-- Set level size
local width = 500fx
local height = 300fx
pewpew.set_level_size(width, height)

-- Make fury-like background
local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/assets/background.lua", 0)
pewpew.customizable_entity_start_spawning(background, 120)
pewpew.customizable_entity_configure_music_response(background, {color_start = 0xffffff66, color_end = 0xffffffff, scale_z_start = 1fx, scale_z_end = 2fx})

-- Create player
local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_7_5, cannon = pewpew.CannonType.TRIPLE, duration=999999999}
local ship = player_helpers.new_player_ship(width / 2fx, height / 2fx, 0)
pewpew.configure_player(0, {camera_distance = 50fx, shield = 6})
pewpew.configure_player_ship_weapon(ship, weapon_config)

-- Functions for making random positions
local function random_position_rewards()
  return fmath.random_fixedpoint(50fx, width-50fx), fmath.random_fixedpoint(50fx, height-50fx)
end

local function random_position_enemies()
  return fmath.random_fixedpoint(25fx, width-25fx), fmath.random_fixedpoint(25fx, height-25fx)
end


local time = 0
pewpew.add_update_callback(
  function()
    time = time + 1
    -- Make cycle for enemies and powerups
    local modulo = time % 100
    local modulo2 = time % 1100
    if modulo2 == 111 or modulo2 == 666 then
      local x,y = random_position_rewards()
      shield_box.new(x, y, weapon_config)
    end
    if modulo2 == 999 or modulo2 == 333 then
      local x,y = random_position_rewards()
      cannon_box.new(x, y, fmath.random_int(0, 3))
    end
    if modulo2 == 777 then
      local x,y = random_position_rewards()
      pewpew.new_bomb(x, y, pewpew.BombType.SMALL_ATOMIZE)
    end
    if modulo2 == 444 then
      local x,y = random_position_rewards()
      pewpew.new_bomb(x, y, pewpew.BombType.FREEZE)
    end
    if modulo2 == 1099 then
      local x,y = random_position_rewards()
      pewpew.new_bomb(x, y, pewpew.BombType.REPULSIVE)
    end
    if modulo == 66 then
      pewpew.new_rolling_cube(25fx, 25fx)
      pewpew.new_rolling_cube(25fx, 275fx)
      pewpew.new_rolling_cube(475fx, 25fx)
      pewpew.new_rolling_cube(475fx, 275fx)
    end
    if modulo == 77 then
      pewpew.new_wary(125fx, 150fx)
      pewpew.new_wary(375fx, 150fx)
    end
    if modulo2 == 555 then
      local x,y = random_position_enemies()
      pewpew.new_inertiac(x, y, 1fx, fmath.tau() / 4fx)
    end
    if pewpew.get_player_configuration(0)["has_lost"] == true then
      pewpew.stop_game()
    end
  end)
