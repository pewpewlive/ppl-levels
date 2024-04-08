
local mesh_path = current_folder_path .. 'mesh.lua'

local s_spawn = 1
local s_alive = 2

local color = 0xf08040ff
local hp = 16fx
local score = 12000
local score_per_hit = 100
local trail_recharge = 11
local spawn_time = 30
local max_acceleration_start = 0.1024fx
local max_acceleration_end = 1.3072fx
local max_acceleration_d = 0.8fx
local max_speed = 13fx
local speed_angle_ratio = 0.64fx
local on_hit_ratio = 0.3096fx

local function on_hit(entity, hit_x, hit_y)
  entity[i_dx] = entity[i_dx] * on_hit_ratio
  entity[i_dy] = entity[i_dy] * on_hit_ratio
  pewpew.play_sound(SOUNDS_PATH, 5, hit_x, hit_y)
  pewpew.create_explosion(hit_x, hit_y, color, 0.2048fx, 6)
  square_animation:create(hit_x, hit_y, color)
  entity[i_is_damaged] = 2
  entity:set_mesh(mesh_path, 1)
end

local _p = {}
_p[i_is_damaged] = -1
_p[i_timer] = spawn_time
_p[i_state] = s_spawn
_p[i_dx] = 0fx
_p[i_dy] = 0fx
_p[i_angle] = 0fx
_p[i_trail_recharge] = trail_recharge
_p[i_max_acceleration] = max_acceleration_start

return {
  
  group = 'enemy',
  
  radius = 25fx,
  hp = hp,
  
  proto = _p,
  
  constructor = function(entity, x, y, ...)
    entity[i_id] = pewpew.new_customizable_entity(x, y)
    entity[i_hp] = entity[i_type].hp
    
    entity:set_mesh(mesh_path, 0)
    entity:start_spawning(spawn_time)
    entity:set_position_interpolation(true)
    
    configure_wall_bounce(entity)
  end,
  
  destructor = function(entity, ...)
    local x, y = entity:get_position()
    pewpew.increase_score_of_player(0, score)
    pewpew.play_sound(SOUNDS_PATH, 6, x, y)
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
        entity:set_mesh(mesh_path, 0)
      else
        entity[i_is_damaged] = entity[i_is_damaged] - 1
      end
      local ex, ey = entity:get_position()
      local dx = PLAYER_X - ex
      local dy = PLAYER_Y - ey
      local l = __DEF_FMATH_SQRT(dx * dx + dy * dy)
      if l > entity[i_max_acceleration] then
        dx = dx / l * entity[i_max_acceleration]
        dy = dy / l * entity[i_max_acceleration]
      end
      dx = entity[i_dx] + dx
      dy = entity[i_dy] + dy
      local dl = __DEF_FMATH_SQRT(dx * dx + dy * dy)
      if dl > max_speed then
        dx = dx / dl * max_speed
        dy = dy / dl * max_speed
      end
      entity[i_dx] = dx
      entity[i_dy] = dy
      entity:set_position(ex + dx, ey + dy)
      
      local angle = dl * speed_angle_ratio
      entity[i_angle] = entity[i_angle] + angle
      entity:set_mesh_angle(entity[i_angle], 0fx, 0fx, 1fx)
      
      if entity[i_max_acceleration] < max_acceleration_end then
        entity[i_max_acceleration] = entity[i_max_acceleration] + max_acceleration_d
      end
      
      entity[i_trail_recharge] = entity[i_trail_recharge] - 1
      if entity[i_trail_recharge] < 1 then
        star_trail:create(ex, ey, entity[i_angle])
        entity[i_trail_recharge] = trail_recharge
      end
      
      local bullet = check_collision_with_group(entity, 'player_bullet')
      if bullet then
        local bx, by = bullet:get_position()
        on_hit(entity, bx, by)
        entity[i_hp] = entity[i_hp] - bullet[i_type].damage
        pewpew.increase_score_of_player(0, score_per_hit * __DEF_FMATH_TO_INT(bullet[i_type].damage))
        bullet:destroyA()
        if entity[i_hp] <= 0fx then
          entity:destroyA()
          return nil
        end
      end
      if check_collision_with_player_lasers(entity) then
        local random_r = __DEF_FMATH_RANDOM_FX(0fx, entity[i_type].radius)
        local dy, dx = __DEF_FMATH_SINCOS(__DEF_FMATH_RANDOM_FX(0fx, TAU_FX))
        on_hit(entity, ex + random_r * dx, ey + random_r * dy)
        entity[i_hp] = entity[i_hp] - player_laser.damage
        pewpew.increase_score_of_player(0, score_per_hit * __DEF_FMATH_TO_INT(player_laser.damage))
        if entity[i_hp] <= 0fx then
          entity:destroyA()
          return nil
        end
      end
      if check_collision_with_player(entity) then
        pewpew.add_damage_to_player_ship(PLAYER[i_id], 1)
        entity:destroyA()
      end
    end
  end,
  
}
