-- ---------------------------------- --
-- Rolling Cubes vs Spinning Hexagons --
-- --------- by: Tasty Kiwi --------- --
-- ---------------------------------- --

-- Set level size
local width = 500fx
local height = 300fx
pewpew.set_level_size(width, height)

-- Make fury-like background

local map_color = 0xffffffff
local rng_number = fmath.random_int(1, 6)
if rng_number == 1 then
  -- Yellow (rolling cube)
  map_color = 0xffff00ff
elseif rng_number == 2 then
  -- Blue (wary)
  map_color = 0x2020ffff
elseif rng_number == 3 then
  -- Green (rolling cube)
  map_color = 0x80ff00ff
elseif rng_number == 4 then
  -- Orange (rolling cube)
  map_color = 0xff8000ff
elseif rng_number == 5 then
  -- Beige (rolling cube)
  map_color = 0xb6b060ff
elseif rng_number == 6 then
  -- Purple (wary)
  map_color = 0xaa10ffff
end

local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/assets/background.lua", 0)
pewpew.customizable_entity_set_mesh_color(background, map_color)
pewpew.customizable_entity_start_spawning(background, 120)
pewpew.customizable_entity_configure_music_response(background, {color_start = 0xffffff66, color_end = 0xffffffff, scale_z_start = 1fx, scale_z_end = 2fx})

-- Create player
local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_7_5, cannon = pewpew.CannonType.TRIPLE}
local ship = pewpew.new_player_ship(width / 2fx, height / 2fx, 0)
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
      pewpew.new_bonus(x, y, pewpew.BonusType.SHIELD, { number_of_shields = 1 })
    end
    if modulo2 == 999 or modulo2 == 333 then
      local type = fmath.random_int(0, 3)
      local frequency
      local cannon_type
      if type == 0 then
        frequency = pewpew.CannonFrequency.FREQ_30
        cannon_type = pewpew.CannonType.DOUBLE_SWIPE
      elseif type == 1 then
        frequency = pewpew.CannonFrequency.FREQ_3
        cannon_type = pewpew.CannonType.HEMISPHERE
      elseif type == 2 then
        frequency = pewpew.CannonFrequency.FREQ_15
        cannon_type = pewpew.CannonType.DOUBLE
      elseif type == 3 then
        frequency = pewpew.CannonFrequency.FREQ_15
        cannon_type = pewpew.CannonType.TIC_TOC
      elseif type == 4 then
        frequency = pewpew.CannonFrequency.FREQ_15
        cannon_type = pewpew.CannonType.SINGLE
      elseif type == 5 then
        frequency = pewpew.CannonFrequency.FREQ_15
        cannon_type = pewpew.CannonType.FOUR_DIRECTIONS
      end
      local x,y = random_position_rewards()
      pewpew.new_bonus(x, y, pewpew.BonusType.WEAPON, {frequency = frequency, cannon = cannon_type, weapon_duration = 100})
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
      pewpew.new_rolling_cube(25fx, height - 25fx)
      pewpew.new_rolling_cube(width - 25fx, 25fx)
      pewpew.new_rolling_cube(width - 25fx, height - 25fx)
    end
    if modulo == 77 then
      pewpew.new_wary((width / 2) - 75fx, height / 2)
      pewpew.new_wary((width / 2) + 75fx, height / 2)
    end
    if modulo2 == 555 then
      local x,y = random_position_enemies()
      pewpew.new_inertiac(x, y, 1fx, fmath.tau() / 4fx)
    end
    if pewpew.get_player_configuration(0)["has_lost"] == true then
      pewpew.stop_game()
    end
  end)
