
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

return {
  
  group = 'bomb',
  
  animation = 'bomb',
  
  radius = 15fx,
  
  proto = {
    state = s_spawn,
    timer = spawn_time,
  },
  
  constructor = function(entity, x, y, ...)
    local args = {...}
    local variation = args[1]
    entity.variation = variation
    entity.color = variation == BOMB_TYPES.force and force_bomb_color or destruction_bomb_color
    entity.id = pewpew.new_customizable_entity(x, y)
    local angle = __DEF_FMATH_RANDOM_FX(0fx, TAU_FX)
    local dy, dx = __DEF_FMATH_SINCOS(angle)
    entity.dx = dx * speed
    entity.dy = dy * speed
    entity.rx = __DEF_FMATH_RANDOM_FX(0fx, TAU_FX)
    entity.ry = __DEF_FMATH_RANDOM_FX(0fx, TAU_FX)
    entity.rz = __DEF_FMATH_RANDOM_FX(0fx, TAU_FX)
    
    entity.arrow_id = pewpew.add_arrow_to_player_ship(PLAYER.id, entity.id, entity.color)
    entity:set_mesh(mesh_path, entity.animation.variation_offset)
    entity:set_mesh_color(entity.color)
    entity:start_spawning(spawn_time)
    configure_wall_bounce(entity)
  end,
  
  destructor = function(entity, ...)
    local x, y = entity:get_position()
    square_animation:create(x, y, entity.color)
    circle_explosion:create(x, y, entity.variation)
    pewpew.remove_arrow_from_player_ship(PLAYER.id, entity.arrow_id)
    pewpew.play_sound(SOUNDS_PATH, 0, x, y)
    entity:start_exploding(30)
  end,
  
  ai = function(entity)
    if entity.state == s_spawn then
      entity.timer = entity.timer - 1
      if entity.timer == 0 then
        entity.state = s_alive
      end
    elseif entity.state == s_alive then
      local x, y = entity:get_position()
      entity:set_position(x + entity.dx, y + entity.dy)
      entity:add_rotation_to_mesh(rotation_speed, entity.rx, entity.ry, entity.rz)
      
      if check_collision_with_player(entity) then
        if entity.variation == BOMB_TYPES.force then
          for _, projectile in pairs(pplaf.entity.get_group'enemy_bullet') do
            if projectile:get_is_alive() then
              local px, py = projectile:get_position()
              local dx = px - x
              local dy = py - y
              local l = __DEF_FMATH_SQRT(dx * dx + dy * dy)
              local speed = projectile.type.speed
              if l > speed then
                dx = dx / l * speed
                dy = dy / l * speed
              end
              projectile.dx = dx
              projectile.dy = dy
              if projectile.max_speed then
                projectile.max_speed = projectile.max_speed / 4fx
                projectile.max_acceleration = projectile.max_acceleration / 4fx
              end
            end
          end
          for _, sentry in pairs(pplaf.entity.get_group'enemy') do
            if sentry.type.name == 'sentry' and sentry:get_is_alive() and not sentry:get_is_started_to_be_destroyed() then
              sentry.recharge = sentry.recharge + bomb_recharge_increase
            end
          end
          for _, star in pairs(pplaf.entity.get_group'enemy') do
            if star.type.name == 'star' then
              star.dx = 0fx
              star.dy = 0fx
              star.max_acceleration = star.max_acceleration / 4fx
            end
          end
        elseif entity.variation == BOMB_TYPES.destruction then
          for _, enemy in pairs(pplaf.entity.get_group('enemy')) do
            if enemy.type.name ~= 'cube' then
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
