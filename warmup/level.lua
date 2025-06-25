local player_helper = require("/dynamic/helpers/player_helpers.lua")

local height = 480fx
local width = 480fx
pewpew.set_level_size(width, height)

local bg_inside = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(bg_inside, "/dynamic/background_mesh.lua", 6)
pewpew.customizable_entity_set_mesh_color(bg_inside, 0xffff0055)

local bg_outline = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(bg_outline, "/dynamic/background_mesh.lua", 0)
pewpew.customizable_entity_set_mesh_color(bg_outline, 0xffff0066)
pewpew.customizable_entity_configure_music_response(bg_outline, { color_start = 0xffffff66, color_end = 0xffffffff })

local triangle1 = pewpew.new_customizable_entity(width / 2fx, 225fx)
pewpew.customizable_entity_set_mesh(triangle1, "/dynamic/background_mesh.lua", 7)
pewpew.customizable_entity_set_mesh_color(triangle1, 0xffff0055)

local triangle2 = pewpew.new_customizable_entity(width / 2fx + 5fx, 255fx)
pewpew.customizable_entity_set_mesh(triangle2, "/dynamic/background_mesh.lua", 7)
pewpew.customizable_entity_set_mesh_color(triangle2, 0xffff0055)
pewpew.customizable_entity_set_mesh_angle(triangle2, fmath.tau() / 2fx, 0fx, 0fx, 1fx)
local circle_array = {}

for i = 1, 5 do
  table.insert(circle_array, pewpew.new_customizable_entity(width / 2fx, height / 2fx))
  pewpew.customizable_entity_set_mesh(circle_array[i], "/dynamic/background_mesh.lua", i)
  pewpew.customizable_entity_set_mesh_color(circle_array[i], 0xffff0055)
  pewpew.customizable_entity_configure_music_response(circle_array[i],
    { scale_x_start = 1fx, scale_x_end = 1.163fx, scale_y_start = 1fx, scale_y_end = 1.163fx })
end

local weapon_config = { frequency = pewpew.CannonFrequency.FREQ_30, cannon = pewpew.CannonType.TRIPLE }
local omited_weapon_config = { frequency = pewpew.CannonFrequency.FREQ_7_5 }
local player = player_helper.new_player_ship(width / 2fx, height / 2fx, 0)
pewpew.configure_player(0,
  { camera_distance = -50fx, shield = 0, move_joystick_color = 0xffff00ff, shoot_joystick_color = 0xff0000ff })
pewpew.configure_player_ship_weapon(player, omited_weapon_config)

local angleLeft = 0fx
local angleRight = 0fx
reverse = false

local goalLeft = fmath.tau() / -1fx
local goalRight = fmath.tau() / 1fx

-- Turning circles
pewpew.entity_set_update_callback(bg_outline, function()
  angleLeft = angleLeft + (goalLeft - angleLeft) / (420fx)
  pewpew.customizable_entity_set_mesh_angle(circle_array[2], angleLeft, 0fx, 0fx, 1fx)
  pewpew.customizable_entity_set_mesh_angle(circle_array[4], angleLeft, 0fx, 0fx, 1fx)
  if not reverse then
    goalLeft = goalLeft - fmath.tau() / 10fx
  else
    goalLeft = goalLeft + fmath.tau() / 10fx
  end
  angleRight = angleRight + (goalRight - angleRight) / (420fx)
  pewpew.customizable_entity_set_mesh_angle(circle_array[1], angleRight, 0fx, 0fx, 1fx)
  pewpew.customizable_entity_set_mesh_angle(circle_array[3], angleRight, 0fx, 0fx, 1fx)
  pewpew.customizable_entity_set_mesh_angle(circle_array[5], angleRight, 0fx, 0fx, 1fx)
  if not reverse then
    goalRight = goalRight + fmath.tau() / 10fx
  else
    goalRight = goalRight - fmath.tau() / 10fx
  end
  if goalRight > 30fx and goalLeft < -30fx then
    reverse = true
  elseif goalRight < -30fx and goalLeft > 30fx then
    reverse = false
  end
end)

function create_mothership_angle(x, y)
  local px, py = pewpew.entity_get_position(player)
  local dx = px - x
  local dy = py - y
  return fmath.atan2(dy, dx)
end

local round_lock = false
local round = 1
local time = 0
pewpew.add_update_callback(function()
  if pewpew.get_player_configuration(0).has_lost then
    pewpew.stop_game()
  else
    time = time + 1
    if time == 40 then
      pewpew.new_floating_message(width / 2fx, height / 2fx - 10fx, "#00ffffffRound 1",
        { scale = 1fx, ticks_before_fade = 30 })
    end
    if round == 1 and time < 400 and time % 15 == 0 then
      pewpew.new_rolling_cube(450fx, 450fx)
    end
    if time == 400 then
      pewpew.new_bonus(width / 2fx, height / 2fx, pewpew.BonusType.WEAPON,
        { frequency = pewpew.CannonFrequency.FREQ_7_5, cannon = pewpew.CannonType.HEMISPHERE, weapon_duration = 120 })
    end
    if round == 1 and time >= 400 and pewpew.get_entity_count(pewpew.EntityType.ROLLING_CUBE) == 0 then
      pewpew.new_bonus(width / 2fx, (height / 2fx) + 50fx, pewpew.BonusType.WEAPON,
        { frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.TRIPLE })
      pewpew.new_bonus(width / 2fx, (height / 2fx) - 50fx, pewpew.BonusType.SHIELD, { number_of_shields = 5 })
      round = round + 1
      round_lock = true
    end
    if round >= 2 and round_lock then
      pewpew.new_floating_message(width / 2fx, height / 2fx - 10fx, "#00ffffffRound " .. round,
        { scale = 1fx, ticks_before_fade = 30 })
      for i = 1, round // 3 do
        pewpew.new_mothership(25fx, 25fx, round % 5, create_mothership_angle(25fx, 25fx))
        pewpew.new_mothership(450fx, 25fx, round % 5, create_mothership_angle(450fx, 25fx))
        pewpew.new_mothership(25fx, 450fx, round % 5, create_mothership_angle(25fx, 450fx))
        pewpew.new_mothership(450fx, 450fx, round % 5, create_mothership_angle(450fx, 450fx))
      end
      round_lock = false
    end
    if round >= 2 and round_lock == false and pewpew.get_entity_count(pewpew.EntityType.MOTHERSHIP) == 0 then
      round = round + 1
      round_lock = true
    end
  end
end)
