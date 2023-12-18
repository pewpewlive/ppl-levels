
local mesh_path = current_folder_path .. 'mesh.lua'

local s_spawn = 1
local s_alive = 2

local hp = 300fx
local spawn_time = 180
local color = 0xffa040ff
local size = 100fx
local score = 8000
local score_per_hit = 100

local function on_hit(entity, hit_x, hit_y)
  entity.is_damaged = 2
  pewpew.play_sound(SOUNDS_PATH, 9, hit_x, hit_y)
  pewpew.create_explosion(hit_x, hit_y, color, 0.2048fx, 6)
  square_animation:create(hit_x, hit_y, color)
  entity:set_mesh_color(0xd0d0d0ff)
end

return {
  
  group = 'enemy',
  
  animation = 'cube',
  
  hp = hp,
  
  proto = {
    timer = spawn_time,
    state = s_spawn,
    is_damaged = -1,
  },
  
  constructor = function(entity, x, y, ...)
    local args = {...}
    entity.dx = args[1]
    entity.dy = args[2]
    entity.id = pewpew.new_customizable_entity(x, y)
    entity.hp = entity.type.hp
    
    entity:set_position_interpolation(true)
    entity:set_mesh(mesh_path, 0)
    entity:set_mesh_color(color)
    entity:start_spawning(spawn_time)
  end,
  
  destructor = function(entity, ...)
    local x, y = entity:get_position()
    pewpew.increase_score_of_player(0, score)
    pewpew.play_sound(SOUNDS_PATH, 10, x, y)
    entity:start_exploding(30)
  end,
  
  ai = function(entity)
    if entity.state == s_spawn then
      entity.timer = entity.timer - 1
      if entity.timer == 0 then
        entity.state = s_alive
      end
    elseif entity.state == s_alive then
      if entity.is_damaged == 0 then
        entity.is_damaged = -1
        entity:set_mesh_color(color)
      else
        entity.is_damaged = entity.is_damaged - 1
      end
      local x, y = entity:get_position()
      if entity.dx ~= 0fx then
        x = x + entity.dx
        if x <= size or x >= LEVEL_SIZE_X - size then
          entity.dx = -entity.dx
        end
      end
      if entity.dy ~= 0fx then
        y = y + entity.dy
        if y <= size or y >= LEVEL_SIZE_Y - size then
          entity.dy = -entity.dy
        end
      end
      entity:set_position(x, y)
      for _, bullet in pairs(pplaf.entity.get_group'player_bullet') do
        if bullet:get_is_alive() and not bullet:get_is_started_to_be_destroyed() then
          local bx, by = bullet:get_position()
          local dx = bx - x
          local dy = by - y
          dx = dx > 0fx and dx or -dx
          dy = dy > 0fx and dy or -dy
          local collision_size = size + bullet.type.radius
          if dx < collision_size and dy < collision_size then
            on_hit(entity, bx, by)
            entity.hp = entity.hp - bullet.type.damage
            pewpew.increase_score_of_player(0, score_per_hit * __DEF_FMATH_TO_INT(bullet.type.damage))
            bullet:destroyA()
            if entity.hp <= 0fx then
              entity:destroyA()
              return nil
            end
          end
        end
      end
      for _, laser in pairs(pplaf.entity.get_group'player_laser') do
        if laser.laser_state > -1 and laser:get_is_alive() then
          local lx, ly = laser:get_position()
          local a = {
            __DEF_FMATH_ATAN2(y + size - ly, x + size - lx),
            __DEF_FMATH_ATAN2(y - size - ly, x + size - lx),
            __DEF_FMATH_ATAN2(y + size - ly, x - size - lx),
            __DEF_FMATH_ATAN2(y - size - ly, x - size - lx),
          }
          local min = a[1]
          local max = a[2]
          for i = 1, 4 do
            if a[i] < min then
              min = a[i]
            end
            if a[i] > max then
              max = a[i]
            end
          end
          if laser.angle >= min and laser.angle <= max then
            local random_r = __DEF_FMATH_RANDOM_FX(0fx, size / 2fx)
            local dy, dx = __DEF_FMATH_SINCOS(__DEF_FMATH_RANDOM_FX(min, max))
            on_hit(entity, x + dx, x + dy)
            entity.hp = entity.hp - player_laser.damage
            pewpew.increase_score_of_player(0, score_per_hit * __DEF_FMATH_TO_INT(player_laser.damage))
            if entity.hp <= 0fx then
              entity:destroyA()
              return nil
            end
          end
        end
      end
      if not PLAYER:get_is_alive() then
        return nil
      end
      local px = PLAYER_X - x
      local py = PLAYER_Y - y
      px = px > 0fx and px or -px
      py = py > 0fx and py or -py
      local collision_size = size + PLAYER.type.radius
      if px < collision_size and py < collision_size then
        pewpew.add_damage_to_player_ship(PLAYER.id, 2)
        entity:destroyA()
      end
    end
  end,
  
}
