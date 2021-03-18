-- Set how large the level will be.
local width = 600fx
local height = 600fx
pewpew.set_level_size(width, height)

-- Create an entity at position (0,0) that will hold the background mesh.
local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/rectangles_graphic.lua", 0)

-- Create background from tutorial.
local bg = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(bg, "/dynamic/level_graphics.lua", 0)

-- Create cage.
local dots_background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(dots_background, "/dynamic/cage_graphics.lua", 0)

-- Create hoverable text
local counter = pewpew.new_customizable_entity(width / 2fx, height / 2fx + 100fx)
local wave_counter = pewpew.new_customizable_entity(width / 2fx, height / 2fx + 150fx)

-- Configure the player, with 3 shields.
pewpew.configure_player(0, {shield = 3, camera_rotation_x_axis = fmath.tau() / -48fx})

-- Create the player's ship at the center of the map.
local ship = pewpew.new_player_ship(width / 2fx, height / 2fx, 0)
pewpew.configure_player_ship_weapon(ship, { frequency = pewpew.CannonFrequency.FREQ_6, cannon = pewpew.CannonType.SINGLE})

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
local radius = 33fx
local enemy_amount
local seconds
local timer
local blockloop
local rols = {}
local rol_hitboxes = {}
local waves = 0
local bonus = -150
local shield_bonus = 2

pewpew.add_update_callback(
  function()
    if pewpew.entity_get_is_alive(ship) == false then
      pewpew.stop_game()
    else
      -- Create rolling spheres and their hitboxes, when there are 0 of them.
      if pewpew.get_entity_count(pewpew.EntityType.ROLLING_SPHERE) == 0 then
      rols = {}
      rol_hitboxes = {}
      waves = waves + 1
      enemy_amount = 20 + waves
      for i = 1, enemy_amount do
        table.insert(rols, pewpew.new_rolling_sphere(fmath.random_fixedpoint(0fx, width), fmath.random_fixedpoint(0fx, height), fmath.tau() / fmath.random_fixedpoint(1fx, 6fx), 5fx))
      end
      for i = 1, enemy_amount do
        table.insert(rol_hitboxes, pewpew.new_customizable_entity(pewpew.entity_get_position(rols[i])))
        pewpew.entity_set_radius(rol_hitboxes[i], radius)
        pewpew.customizable_entity_set_position_interpolation(rol_hitboxes[i], true)
      end
        bonus = bonus + 150
        pewpew.customizable_entity_set_string(wave_counter, "Wave " .. waves .. " (Survival bonus: " .. bonus .. ")")
        -- Bonus thingies.
        if bonus > 0 then pewpew.increase_score_of_player(0, 150) end
        if shield_bonus == 2 then
          pewpew.configure_player(0, {shield = pewpew.get_player_configuration(0).shield + 1})
          shield_bonus = 1
        elseif shield_bonus == 1 then
          shield_bonus = 2
        end
        -- Reset some variables.
        seconds = 25
        timer = 0
        blockloop = false
      end
      timer = timer + 1
      -- Use clamp function to contain a player in a cage.
      local x,y = pewpew.entity_get_position(ship)
      x = clamp(x, (width / 2fx) - 40fx, (width / 2fx) + 40fx)
      y = clamp(y, (height / 2fx) - 40fx, (height / 2fx) + 40fx)
      pewpew.entity_set_position(ship, x, y)
      if timer == 30 and blockloop == false then
        seconds = seconds - 1
        timer = 0
      end
      -- Change timer text
      if blockloop == false then pewpew.customizable_entity_set_string(counter, "Time left: " .. seconds) end
      if seconds == 0 then
        blockloop = true
        pewpew.customizable_entity_set_string(counter, "Now DESTROY them all!")
        -- Make hitboxes register bullets.
        for i = 1, enemy_amount do
          if pewpew.entity_get_is_alive(rols[i]) and pewpew.entity_get_is_alive(rol_hitboxes[i]) then
            local temp_x, temp_y = pewpew.entity_get_position(rols[i])
            pewpew.entity_set_position(rol_hitboxes[i], temp_x, temp_y)
            pewpew.customizable_entity_set_weapon_collision_callback(rol_hitboxes[i], function(entity_id, player_index, weapon_type)
              if weapon_type == pewpew.WeaponType.BULLET and pewpew.entity_get_is_alive(rols[i]) then
                pewpew.entity_destroy(rols[i])
                pewpew.create_explosion(temp_x, temp_y, 0xff0000ff, 1fx, 40)
                pewpew.increase_score_of_player(0, 10)
                pewpew.entity_destroy(entity_id)
              end
              return true
            end)
            -- Clean those ghost hitboxes!
          elseif pewpew.entity_get_is_alive(rols[i]) == false and pewpew.entity_get_is_alive(rol_hitboxes[i]) then
            pewpew.entity_destroy(rol_hitboxes[i])
          end
        end
      end
    end
  end)