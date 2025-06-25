-- Cage Theory v2 by Tasty Kiwi
-- Licensed under MIT license.

blockloop = false

---@module "sphere"
require("/dynamic/shootable_spheres/sphere.lua")

---@module "disappearing_message"
local disappearing_message = require("/dynamic/disappearing_message.lua")

-- Set how large the level will be.
local width                = 550fx
local height               = 550fx
pewpew.set_level_size(width, height)

-- Create an entity at position (0,0) that will hold the background mesh.
local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/rectangles_graphic.lua", 0)
pewpew.customizable_entity_configure_music_response(background,
  { color_start = 0xffffff77, color_end = 0xffffff88, scale_z_end = 1fx, scale_z_start = 15fx / 20fx })

-- Create background from tutorial.
local dots = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(dots, "/dynamic/level_graphics.lua", 0)
pewpew.customizable_entity_configure_music_response(dots, { color_start = 0xffffff11, color_end = 0xffffffff })

-- Create cage.
local cage = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(cage, "/dynamic/cage_graphics.lua", 0)
pewpew.customizable_entity_configure_music_response(cage,
  { color_start = 0xffffff77, color_end = 0xffffffff, scale_z_end = 1fx, scale_z_start = 15fx / 20fx })

-- Create hoverable text
local counter = pewpew.new_customizable_entity(width / 2fx, height / 2fx + 100fx)
local wave_counter = pewpew.new_customizable_entity(width / 2fx, height / 2fx + 150fx)

-- Create the player's ship at the center of the map.
local ship = pewpew.new_player_ship(width / 2fx, height / 2fx, 0)

-- shields: 7
pewpew.configure_player(0, { shield = 7, camera_rotation_x_axis = fmath.tau() / -44fx })
-- Use clamp function for a cage (You can't use walls for this).
function clamp(v, min, max)
  if v < min then
    return min
  elseif v > max then
    return max
  end
  return v
end

-- Initialize some variables.
local enemy_amount
local seconds = 0
local timer = 0

local waves = 0
local rol_speed = 4fx + 2fx * (1fx / 3fx)

function random_pos_cage()
  return fmath.random_fixedpoint((width / 2fx) - 60fx, (width / 2fx) + 60fx),
      fmath.random_fixedpoint((width / 2fx) - 60fx, (width / 2fx) + 60fx)
end

function create_target_angle(msx, msy, px, py)
  local dx = px - msx
  local dy = py - msy
  return fmath.atan2(dy, dx)
end

function spawn_rollling_spheres_circular(radius, amount, speed, center_x, center_y)
  for i = 0, amount + 1 do
    local angle = (6.1159fx / fmath.to_fixedpoint(amount + 1)) * fmath.to_fixedpoint(i)
    local y, x = fmath.sincos(angle)
    y = y * radius
    x = x * radius
    if i > 0 then
      sphere_new(center_x + x, center_y + y, fmath.random_fixedpoint(0fx, fmath.tau()), speed)
    end
  end
end

pewpew.add_update_callback(function()
  if pewpew.get_player_configuration(0).has_lost then
    pewpew.customizable_entity_set_string(counter,
      "#444444ffSurvived up to #ffffffffwave " .. waves)
    pewpew.customizable_entity_set_mesh_scale(counter, 0.3189fx)
    pewpew.customizable_entity_set_string(wave_counter, "#ff0000ffYou died!")
    pewpew.stop_game()
  else
    if pewpew.get_entity_count(pewpew.EntityType.ROLLING_SPHERE) == 0 and seconds == 0 then
      spheres = {}
      waves = waves + 1
      if waves <= 4 then
        rol_speed = rol_speed + (1fx / 3fx)
        enemy_amount = 19 + waves
      else
        rol_speed = rol_speed + (1fx / 12fx)
        enemy_amount = 23 + (waves // 4)
      end
      pewpew.configure_player_ship_weapon(ship, {})
      pewpew.configure_player(0, { move_joystick_color = 0xffffff77, shoot_joystick_color = 0xffffff15 })
      -- for i = 1, enemy_amount do
      --   sphere_new(fmath.random_fixedpoint(0fx, width), fmath.random_fixedpoint(0fx, height), fmath.random_fixedpoint(0fx, fmath.tau()), rol_speed)
      -- end
      spawn_rollling_spheres_circular(255fx, enemy_amount, rol_speed, width / 2fx, height / 2fx)
      if waves > 2 then
        -- Bonuses
        if waves % 8 == 0 then
          disappearing_message.new(width / 2fx, (height / 2fx) - 85fx, "Keep it up! Here's 2 * 256 pointonium for you!",
            0.3072fx, 0x00ff00ff, 2)

          local rx, ry = random_pos_cage()
          pewpew.new_pointonium(rx, ry, 256)
          local rx, ry = random_pos_cage()
          pewpew.new_pointonium(rx, ry, 256)
        elseif waves % 4 == 0 then
          local rx, ry = random_pos_cage()
          pewpew.new_pointonium(rx, ry, 256)
        elseif waves % 2 == 0 then
          local rx, ry = random_pos_cage()
          pewpew.new_pointonium(rx, ry, 128)
        else
          local rx, ry = random_pos_cage()
          pewpew.new_pointonium(rx, ry, 64)
        end
      elseif waves == 2 then
        local rx, ry = random_pos_cage()
        pewpew.new_pointonium(rx, ry, 64)
      end
      pewpew.customizable_entity_set_string(wave_counter, "Wave: " .. waves)
      -- Bonus thingies.
      if waves > 1 then
        pewpew.new_bonus(width / 2fx, height / 2fx, pewpew.BonusType.SHIELD, { number_of_shields = 1 })
      end

      --! ALWAYS CHANGE THIS BACK! [Old value: 15]
      seconds = 15

      -- reset vars
      timer = 0
      blockloop = false
    end

    if seconds == 0 and blockloop == false then
      blockloop = true
      pewpew.customizable_entity_set_string(counter, "#ffff00ffDESTROY #444444ffall #c20100ffspheres!")
      pewpew.configure_player(0, { move_joystick_color = 0xffffff77, shoot_joystick_color = 0xffffff77 })
      pewpew.configure_player_ship_weapon(ship,
        { frequency = pewpew.CannonFrequency.FREQ_7_5, cannon = pewpew.CannonType.TIC_TOC })
      pewpew.play_ambient_sound("/dynamic/sfx.lua", 0)
    end

    timer = timer + 1

    if timer == 30 and blockloop == false then
      seconds = seconds - 1
      timer = 0
    end

    local x, y = pewpew.entity_get_position(ship)
    x = clamp(x, (width / 2fx) - 65fx, (width / 2fx) + 65fx)
    y = clamp(y, (height / 2fx) - 65fx, (height / 2fx) + 65fx)
    pewpew.entity_set_position(ship, x, y)

    if blockloop == false then
      pewpew.customizable_entity_set_string(counter, "#444444ffWait for " .. seconds .. " seconds")
    end
  end
end)
