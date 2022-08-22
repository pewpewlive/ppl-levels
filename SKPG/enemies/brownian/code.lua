local eh = require("/dynamic/helpers/enemy_helpers.lua")

local Brownian = {}

function Explode(r,entity_id, wait_for_explode)
  local ex, ey = pewpew.entity_get_position(entity_id)
  if r == 0 then
   pewpew.create_explosion(ex, ey, 0xff0000ff, 1fx/(10fx/9fx), 20)
  else
   pewpew.create_explosion(ex, ey, 0x0000ffff, 1fx/(10fx/9fx), 20)
  end
  pewpew.customizable_entity_start_exploding(entity_id, 30)
  wait_for_explode = true
end

function UpdateMovement(dex, dey, rendering_delta_angle, refresh_movement_time, time, player_id, brownian_id)
  if player_id == nil then
    dex, dey = fmath.random_fixedpoint(-3fx, 3fx), fmath.random_fixedpoint(-5fx, 5fx)
    rendering_delta_angle = fmath.from_fraction(3, 100) + fmath.sqrt(dex*dex + dey*dey) * fmath.from_fraction(3, 100)
    refresh_movement_time = time + fmath.to_int(fmath.random_fixedpoint(5fx, 40fx))
    return dex, dey, rendering_delta_angle, refresh_movement_time, time
  else
    if pewpew.entity_get_is_alive(player_id) then
      local px, py = pewpew.entity_get_position(player_id)
      local tx, ty = pewpew.entity_get_position(brownian_id)
      local dx = px - tx
      local dy = py - ty
      local angle_to_move = fmath.atan2(dy, dx)
      local fdy, fdx = fmath.sincos(angle_to_move)
      dex, dey = fdx * 3fx, fdy * 3fx
      rendering_delta_angle = fmath.from_fraction(3, 100) + fmath.sqrt(dex*dex + dey*dey) * fmath.from_fraction(3, 100)
      refresh_movement_time = time + fmath.to_int(fmath.random_fixedpoint(5fx, 40fx))
    end
    return dex, dey, rendering_delta_angle, refresh_movement_time, time
  end
end

function Brownian.new(x, y, player_id,r)
  local kDefaultRadius = 25fx
  local dex, dey = 0fx, 0fx
  local refresh_movement_time = 0
  local rendering_angle = 0fx
  local rendering_delta_angle = 0fx
  local time = 0
  local time2 = 0
  local wait_for_explode = false
  local until_follow = 2
  local dead = false

  local brownian_id = pewpew.new_customizable_entity(x, y)

  eh.add_entity_to_type(eh.types.BROWNIAN, brownian_id)

  pewpew.customizable_entity_set_mesh(brownian_id, "/dynamic/enemies/brownian/mesh.lua", r)
  pewpew.customizable_entity_start_spawning(brownian_id, 60)
  pewpew.customizable_entity_set_visibility_radius(brownian_id, 7fx)
  pewpew.entity_set_radius(brownian_id, (kDefaultRadius / 2fx) / (3fx / 2fx))
  pewpew.customizable_entity_set_position_interpolation(brownian_id, true)

  local axis = {fmath.random_fixedpoint(-1fx, 1fx), 
                fmath.random_fixedpoint(-1fx, 1fx),
                fmath.random_fixedpoint(-1fx, 1fx)} 
    
  dex, dey, rendering_delta_angle, refresh_movement_time, time = UpdateMovement(dex, dey, rendering_delta_angle, refresh_movement_time, time)

  local function ReactToCollisionWithShip(entity_id, player_index, ship_entity_id)
    --pewpew.increase_score_of_player(0, 20)
    pewpew.increase_score_of_player(0, 2)
    pewpew.add_damage_to_player_ship(ship_entity_id, 1)
    Explode(r,brownian_id)
  end
  pewpew.customizable_entity_set_player_collision_callback(brownian_id, ReactToCollisionWithShip)
    
  local function ReactToWeapon(entity_id, player_index, weapon_type)
    --pewpew.increase_score_of_player(0, 20)
    if not dead then
        pewpew.increase_score_of_player(0, 2)
        Explode(r,brownian_id)
        dead=true
        return true
    end
  end
  pewpew.customizable_entity_set_weapon_collision_callback(brownian_id, ReactToWeapon)

  local function wall_collision_callback(entity_id, wall_normal_x, wall_normal_y)
    pewpew.entity_set_position(brownian_id, wall_normal_x, wall_normal_y)
  end
  pewpew.customizable_entity_configure_wall_collision(brownian_id, wall_collision_callback)

  local function update_callback(entity_id)
    time = time + 1
    local ex, ey = pewpew.entity_get_position(brownian_id)
    ex, ey = ex + dex, ey + dey
    rendering_angle = rendering_angle + rendering_delta_angle
    pewpew.entity_set_position(brownian_id, ex, ey)
    pewpew.customizable_entity_set_mesh_angle(brownian_id, rendering_angle, axis[1], axis[2], axis[3])

    if refresh_movement_time < time then
      if until_follow == 0 then
        until_follow = 2
        dex, dey, rendering_delta_angle, refresh_movement_time, time = UpdateMovement(dex, dey, rendering_delta_angle, refresh_movement_time, time, player_id, brownian_id)
      else
        dex, dey, rendering_delta_angle, refresh_movement_time, time = UpdateMovement(dex, dey, rendering_delta_angle, refresh_movement_time, time, nil, brownian_id)
      end
      until_follow = until_follow - 1
    end
    if wait_for_explode then
      time2 = time2 + 1
      if time2 > 30 then pewpew.entity_destroy(brownian_id) end
    end
  end
  pewpew.entity_set_update_callback(brownian_id, update_callback)

  return brownian_id
end

return Brownian