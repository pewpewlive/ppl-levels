local random_bonus = require("/dynamic/random_bonus.lua")
local sino_enemy = require("/dynamic/sino.lua")

local snowflake = require("/dynamic/snowflake.lua")

-- Set how large the level will be.
local w = 900fx
local h = 700fx
pewpew.set_level_size(w, h)

function random_position()
  return fmath.random_fixedpoint(50fx, w-50fx), fmath.random_fixedpoint(50fx, h-50fx)
end

-- Create an entity at position (0,0) that will hold the background mesh.
local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/level_graphics.lua", 0)

-- Create the player's ship.
local player_x = 250fx
local player_y = 100fx
local player_index = 0 -- there is only one player
local ship_id = pewpew.new_player_ship(player_x, player_y, player_index)
pewpew.configure_player_ship_weapon(ship_id, { frequency = pewpew.CannonFrequency.FREQ_6, cannon = pewpew.CannonType.DOUBLE})
local camera_distance = 50fx
pewpew.configure_player(0, {camera_distance = camera_distance, shield = 3})

local time = 0
local snowflakes_per_minute = 20
local next_snowflake_time = 10

-- New enemy
sino_enemy.new(300fx, 300fx, 1fx, 0fx, ship_id)


-- A function that will get called every game tick, which is 30 times per seconds.
function level_tick()
  -- Stop the game if the player is dead.
  local conf = pewpew.get_player_configuration(player_index)
  if conf["has_lost"] == true then
    pewpew.stop_game()
    return
  end

  time = time + 1
  if time % 80 == 0 then
    local x,y = random_position()
    local bonus = random_bonus.new(x, y, ship_id)
  end
  -- Increase the frequency of snowflakes every 20s
  if time % 600 == 0 then
    snowflakes_per_minute = snowflakes_per_minute + 20
  end
  if time >= next_snowflake_time then
    next_snowflake_time = time + 1 + (1800 // snowflakes_per_minute)
    local x,y = random_position()
    snowflake.new(x, y, ship_id)
  end
  local modulo_minute = time % 1800
  if modulo_minute > 1765 then
    local x,y = random_position()
    snowflake.new(x, y, ship_id)
  end

end

-- Register the `level_tick` function to be called at every game tick.
pewpew.add_update_callback(level_tick)

