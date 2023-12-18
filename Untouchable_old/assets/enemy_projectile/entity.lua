
local mesh_path = current_folder_path .. 'mesh.lua'

local v_basic = 1
local v_homing = 2
local v_short_homing = 3

local spread = 0.64fx
local rotation = 0.512fx
local speed_rotation_mod = 0.96fx
local max_speed = 2fx
local max_acceleration = 0.32fx
local max_speed_homing = 1.2048fx
local max_acceleration_d = 0.3fx
local max_speed_homing_d = 0.80fx
local max_short_homing_angle_d = 0.16fx
local lifetime = 900

local function movement_ai_basic(entity)
  local ex, ey = entity:get_position()
  entity:set_position(ex + entity.dx, ey + entity.dy)
  entity:add_rotation_to_mesh(rotation, entity.rx, entity.ry, entity.rz)
end

local function movement_ai_homing(entity)
  entity.lifetime = entity.lifetime - 1
  if entity.lifetime == 0 then
    entity:destroyA()
    return nil
  end
  local ex, ey = entity:get_position()
  local ax = PLAYER_X - ex
  local ay = PLAYER_Y - ey
  local l = __DEF_FMATH_SQRT(ax * ax + ay * ay)
  if l > entity.max_acceleration then
    ax = ax / l * entity.max_acceleration
    ay = ay / l * entity.max_acceleration
  end
  local dx = entity.dx + ax
  local dy = entity.dy + ay
  l = __DEF_FMATH_SQRT(dx * dx + dy * dy)
  if l > entity.max_speed then
    dx = dx / l * entity.max_speed
    dy = dy / l * entity.max_speed
  end
  entity.dx = dx
  entity.dy = dy
  entity:set_position(ex + dx, ey + dy)
  entity.max_acceleration = entity.max_acceleration + max_acceleration_d
  entity.max_speed = entity.max_speed + max_speed_homing_d
  entity:add_rotation_to_mesh(l * speed_rotation_mod, entity.rx, entity.ry, entity.rz)
end

local function movement_ai_short_homing(entity)
  local ex, ey = entity:get_position()
  local dx = PLAYER_X - ex
  local dy = PLAYER_Y - ey
  local angle = __DEF_FMATH_ATAN2(entity.dy, entity.dx)
  local angle_offset = __DEF_FMATH_ATAN2(dy, dx) - angle
  local sign = angle_offset > 0fx and 1fx or -1fx
  local abs_angle_offset = angle_offset * sign
  if abs_angle_offset > PI_FX then
    abs_angle_offset = TAU_FX - abs_angle_offset
    sign = -sign
  end
  dy, dx = __DEF_FMATH_SINCOS(angle + sign * (abs_angle_offset > max_short_homing_angle_d and max_short_homing_angle_d or abs_angle_offset))
  entity.dx = dx * entity.type.speed
  entity.dy = dy * entity.type.speed
  entity:set_position(ex + entity.dx, ey + entity.dy)
  entity:add_rotation_to_mesh(rotation, entity.rx, entity.ry, entity.rz)
end

return {
  
  group = 'enemy_bullet',
  
  radius = 0fx,
  speed = max_speed,
  
  proto = {
    
  },
  
  constructor = function(entity, x, y, ...)
    entity.id = pewpew.new_customizable_entity(x, y)
    
    local args = {...}
    local variation = args[1]
    local color = args[2]
    local angle = args[3] + __DEF_FMATH_RANDOM_FX(-1fx, 1fx) * spread
    local dy, dx = __DEF_FMATH_SINCOS(angle)
    if variation == v_basic then
      entity.dx = dx * entity.type.speed
      entity.dy = dy * entity.type.speed
      function entity:movement_ai()
        return movement_ai_basic(self)
      end
    elseif variation == v_homing then
      entity.max_acceleration = max_acceleration
      entity.max_speed = max_speed_homing
      entity.dx = dx * max_speed_homing
      entity.dy = dy * max_speed_homing
      entity.lifetime = lifetime
      function entity:movement_ai()
        return movement_ai_homing(self)
      end
    elseif variation == v_short_homing then
      entity.dx = dx * entity.type.speed
      entity.dy = dy * entity.type.speed
      function entity:movement_ai()
        return movement_ai_short_homing(self)
      end
    end
    entity.rx = __DEF_FMATH_RANDOM_FX(0fx, 1fx)
    entity.ry = __DEF_FMATH_RANDOM_FX(0fx, 1fx)
    entity.rz = __DEF_FMATH_RANDOM_FX(0fx, 1fx)
    entity.color = color
    
    entity:set_mesh(mesh_path, 0)
    entity:set_mesh_color(color)
    entity:start_spawning(0)
    entity:set_position_interpolation(true)
    
    configure_wall_destruction(entity)
  end,
  
  destructor = function(entity, ...)
    local x, y = entity:get_position()
    square_animation:create(x, y, entity.color)
    entity:destroy()
  end,
  
  ai = function(entity)
    if check_collision_with_player(entity) then
      pewpew.add_damage_to_player_ship(PLAYER.id, 1)
      entity:destroyA()
      return nil
    end
    entity:movement_ai()
  end,
  
}
