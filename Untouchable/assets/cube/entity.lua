
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
  entity[i_is_damaged] = 2
  pewpew.play_sound(SOUNDS_PATH, 9, hit_x, hit_y)
  pewpew.create_explosion(hit_x, hit_y, color, 0.2048fx, 6)
  square_animation:create(hit_x, hit_y, color)
  entity:set_mesh_color(0xd0d0d0ff)
end

local _p = {}
_p[i_timer] = spawn_time
_p[i_state] = s_spawn
_p[i_is_damaged] = -1

return {
  
  group = 'enemy',
  
  animation = 'cube',
  
  hp = hp,
  
  proto = _p,
  
  constructor = function(entity, x, y, ...)
    local args = {...}
    entity[i_dx] = args[1]
    entity[i_dy] = args[2]
    entity[i_id] = pewpew.new_customizable_entity(x, y)
    entity[i_hp] = entity[i_type].hp
    
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
    if entity[i_state] == s_spawn then
      entity[i_timer] = entity[i_timer] - 1
      if entity[i_timer] == 0 then
        entity[i_state] = s_alive
      end
    elseif entity[i_state] == s_alive then
      if entity[i_is_damaged] == 0 then
        entity[i_is_damaged] = -1
        entity:set_mesh_color(color)
      else
        entity[i_is_damaged] = entity[i_is_damaged] - 1
      end
      local x, y = entity:get_position()
      if entity[i_dx] ~= 0fx then
        x = x + entity[i_dx]
        if x <= size or x >= LEVEL_SIZE_X - size then
          entity[i_dx] = -entity[i_dx]
        end
      end
      if entity[i_dy] ~= 0fx then
        y = y + entity[i_dy]
        if y <= size or y >= LEVEL_SIZE_Y - size then
          entity[i_dy] = -entity[i_dy]
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
          local collision_size = size + bullet[i_type].radius
          if dx < collision_size and dy < collision_size then
            on_hit(entity, bx, by)
            entity[i_hp] = entity[i_hp] - bullet[i_type].damage
            pewpew.increase_score_of_player(0, score_per_hit * __DEF_FMATH_TO_INT(bullet[i_type].damage))
            bullet:destroyA()
            if entity[i_hp] <= 0fx then
              entity:destroyA()
              return nil
            end
          end
        end
      end
      for _, laser in pairs(pplaf.entity.get_group'player_laser') do
        if laser[i_laser_state] > -1 and laser:get_is_alive() then
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
          if laser[i_angle] >= min and laser[i_angle] <= max then
            local random_r = __DEF_FMATH_RANDOM_FX(0fx, size / 2fx)
            local dy, dx = __DEF_FMATH_SINCOS(__DEF_FMATH_RANDOM_FX(min, max))
            on_hit(entity, x + dx, x + dy)
            entity[i_hp] = entity[i_hp] - player_laser.damage
            pewpew.increase_score_of_player(0, score_per_hit * __DEF_FMATH_TO_INT(player_laser.damage))
            if entity[i_hp] <= 0fx then
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
      local collision_size = size + PLAYER[i_type].radius
      if px < collision_size and py < collision_size then
        pewpew.add_damage_to_player_ship(PLAYER[i_id], 2)
        entity:destroyA()
      end
    end
  end,
  
}
