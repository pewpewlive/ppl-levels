
local mesh_path = current_folder_path .. 'mesh.lua'

local s_spawn = 1
local s_alive = 2

local spawn_time = 30
local force_bomb_color = 0x80d0d0a0
local destruction_bomb_color = 0xff9030a0
local speed = 0.2048fx
local rotation_speed = 0.32fx
local bomb_recharge_increase = 240
local destruction_radius = 250fx

function destroy_in_radius(bomb, entity)
  local bx, by = bomb:get_position()
  local ex, ey = entity:get_position()
  local dx = bx - ex
  local dy = by - ey
  if __DEF_FMATH_SQRT(dx * dx + dy * dy) < destruction_radius then
    entity:destroyA()
  end
end

local _p = {}
_p[i_state] = s_spawn
_p[i_timer] = spawn_time

return {
  
  group = 'bomb',
  
  animation = 'bomb',
  
  radius = 15fx,
  
  proto = _p,
  
  constructor = function(entity, x, y, ...)
    local args = {...}
    local variation = args[1]
    entity[i_variation] = variation
    entity[i_color] = variation == BOMB_TYPES.force and force_bomb_color or destruction_bomb_color
    entity[i_id] = pewpew.new_customizable_entity(x, y)
    local angle = __DEF_FMATH_RANDOM_FX(0fx, TAU_FX)
    local dy, dx = __DEF_FMATH_SINCOS(angle)
    entity[i_dx] = dx * speed
    entity[i_dy] = dy * speed
    entity[i_rx] = __DEF_FMATH_RANDOM_FX(0fx, TAU_FX)
    entity[i_ry] = __DEF_FMATH_RANDOM_FX(0fx, TAU_FX)
    entity[i_rz] = __DEF_FMATH_RANDOM_FX(0fx, TAU_FX)
    
    entity[i_arrow_id] = pewpew.add_arrow_to_player_ship(PLAYER[i_id], entity[i_id], entity[i_color])
    entity:set_mesh(mesh_path, entity[i_animation][i_variation_offset])
    entity:set_mesh_color(entity[i_color])
    entity:start_spawning(spawn_time)
    configure_wall_bounce(entity)
  end,
  
  destructor = function(entity, ...)
    local x, y = entity:get_position()
    square_animation:create(x, y, entity[i_color])
    circle_explosion:create(x, y, entity[i_variation])
    pewpew.remove_arrow_from_player_ship(PLAYER[i_id], entity[i_arrow_id])
    pewpew.play_sound(SOUNDS_PATH, 0, x, y)
    entity:start_exploding(30)
  end,
  
  ai = function(entity)
    if entity[i_state] == s_spawn then
      entity[i_timer] = entity[i_timer] - 1
      if entity[i_timer] == 0 then
        entity[i_state] = s_alive
      end
    elseif entity[i_state] == s_alive then
      local x, y = entity:get_position()
      entity:set_position(x + entity[i_dx], y + entity[i_dy])
      entity:add_rotation_to_mesh(rotation_speed, entity[i_rx], entity[i_ry], entity[i_rz])
      
      if check_collision_with_player(entity) then
        if entity[i_variation] == BOMB_TYPES.force then
          for _, projectile in pairs(pplaf.entity.get_group'enemy_bullet') do
            if projectile:get_is_alive() then
              local px, py = projectile:get_position()
              local dx = px - x
              local dy = py - y
              local l = __DEF_FMATH_SQRT(dx * dx + dy * dy)
              local speed = projectile[i_type].speed
              if l > speed then
                dx = dx / l * speed
                dy = dy / l * speed
              end
              projectile[i_dx] = dx
              projectile[i_dy] = dy
              if projectile[i_max_speed] then
                projectile[i_max_speed] = projectile[i_max_speed] / 4fx
                projectile[i_max_acceleration] = projectile[i_max_acceleration] / 4fx
              end
            end
          end
          for _, sentry in pairs(pplaf.entity.get_group'enemy') do
            if sentry[i_type].name == 'sentry' and sentry:get_is_alive() and not sentry:get_is_started_to_be_destroyed() then
              sentry[i_recharge] = sentry[i_recharge] + bomb_recharge_increase
            end
          end
          for _, star in pairs(pplaf.entity.get_group'enemy') do
            if star[i_type].name == 'star' then
              star[i_dx] = 0fx
              star[i_dy] = 0fx
              star[i_max_acceleration] = star[i_max_acceleration] / 4fx
            end
          end
        elseif entity[i_variation] == BOMB_TYPES.destruction then
          for _, enemy in pairs(pplaf.entity.get_group('enemy')) do
            if enemy[i_type].name ~= 'cube' then
              destroy_in_radius(entity, enemy)
            end
          end
          for _, enemy in pairs(pplaf.entity.get_group('enemy_bullet')) do
            destroy_in_radius(entity, enemy)
          end
        end
        entity:destroyA()
      end
    end
  end,
  
}
