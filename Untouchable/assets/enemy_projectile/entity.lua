
local mesh_path = current_folder_path .. 'mesh.lua'

local v_basic = 1
local v_homing = 2
local v_short_homing = 3

local spread = 0.64fx
local rotation = 0.512fx
local speed_rotation_mod = 0.128fx
local max_speed = 2fx
local max_acceleration = 0.28fx
local max_speed_homing = 1.3072fx
local max_acceleration_d = 0.2fx
local max_speed_homing_d = 0.72fx
local max_short_homing_angle_d = 0.16fx
local lifetime = 900

local function movement_ai_basic(entity)
  local ex, ey = entity:get_position()
  entity:set_position(ex + entity[i_dx], ey + entity[i_dy])
  entity:add_rotation_to_mesh(rotation, entity[i_rx], entity[i_ry], entity[i_rz])
end

local function movement_ai_homing(entity)
  entity[i_lifetime] = entity[i_lifetime] - 1
  if entity[i_lifetime] == 0 then
    entity:destroyA()
    return nil
  end
  local ex, ey = entity:get_position()
  local ax = PLAYER_X - ex
  local ay = PLAYER_Y - ey
  local l = __DEF_FMATH_SQRT(ax * ax + ay * ay)
  if l > entity[i_max_acceleration] then
    ax = ax / l * entity[i_max_acceleration]
    ay = ay / l * entity[i_max_acceleration]
  end
  local dx = entity[i_dx] + ax
  local dy = entity[i_dy] + ay
  l = __DEF_FMATH_SQRT(dx * dx + dy * dy)
  if l > entity[i_max_speed] then
    dx = dx / l * entity[i_max_speed]
    dy = dy / l * entity[i_max_speed]
  end
  entity[i_dx] = dx
  entity[i_dy] = dy
  entity:set_position(ex + dx, ey + dy)
  entity[i_max_acceleration] = entity[i_max_acceleration] + max_acceleration_d
  entity[i_max_speed] = entity[i_max_speed] + max_speed_homing_d
  entity:add_rotation_to_mesh(l * speed_rotation_mod, entity[i_rx], entity[i_ry], entity[i_rz])
end

local function movement_ai_short_homing(entity)
  local ex, ey = entity:get_position()
  local dx = PLAYER_X - ex
  local dy = PLAYER_Y - ey
  local angle = __DEF_FMATH_ATAN2(entity[i_dy], entity[i_dx])
  local angle_offset = __DEF_FMATH_ATAN2(dy, dx) - angle
  local sign = angle_offset > 0fx and 1fx or -1fx
  local abs_angle_offset = angle_offset * sign
  if abs_angle_offset > PI_FX then
    abs_angle_offset = TAU_FX - abs_angle_offset
    sign = -sign
  end
  dy, dx = __DEF_FMATH_SINCOS(angle + sign * (abs_angle_offset > max_short_homing_angle_d and max_short_homing_angle_d or abs_angle_offset))
  entity[i_dx] = dx * entity[i_type].speed
  entity[i_dy] = dy * entity[i_type].speed
  entity:set_position(ex + entity[i_dx], ey + entity[i_dy])
  entity:add_rotation_to_mesh(rotation, entity[i_rx], entity[i_ry], entity[i_rz])
end

local function movement_ai(entity)
  if entity[i_variation] == v_basic then
    return movement_ai_basic(entity)
  elseif entity[i_variation] == v_homing then
    return movement_ai_homing(entity)
  elseif entity[i_variation] == v_short_homing then
    return movement_ai_short_homing(entity)
  end
end

return {
  
  group = 'enemy_bullet',
  
  radius = 0fx,
  speed = max_speed,
  
  constructor = function(entity, x, y, ...)
    entity[i_id] = pewpew.new_customizable_entity(x, y)
    
    local args = {...}
    local variation = args[1]
    local color = args[2]
    local angle = args[3] + __DEF_FMATH_RANDOM_FX(-1fx, 1fx) * spread
    local dy, dx = __DEF_FMATH_SINCOS(angle)
    if variation == v_basic then
      entity[i_dx] = dx * entity[i_type].speed
      entity[i_dy] = dy * entity[i_type].speed
    elseif variation == v_homing then
      entity[i_max_acceleration] = max_acceleration
      entity[i_max_speed] = max_speed_homing
      entity[i_dx] = dx * max_speed_homing
      entity[i_dy] = dy * max_speed_homing
      entity[i_lifetime] = lifetime
    elseif variation == v_short_homing then
      entity[i_dx] = dx * entity[i_type].speed
      entity[i_dy] = dy * entity[i_type].speed
    end
    entity[i_rx] = __DEF_FMATH_RANDOM_FX(0fx, 1fx)
    entity[i_ry] = __DEF_FMATH_RANDOM_FX(0fx, 1fx)
    entity[i_rz] = __DEF_FMATH_RANDOM_FX(0fx, 1fx)
    entity[i_color] = color
    entity[i_variation] = variation
    
    entity:set_mesh(mesh_path, 0)
    entity:set_mesh_color(color)
    entity:start_spawning(0)
    entity:set_position_interpolation(true)
    
    configure_wall_destruction(entity)
  end,
  
  destructor = function(entity, ...)
    local x, y = entity:get_position()
    square_animation:create(x, y, entity[i_color])
    entity:destroy()
  end,
  
  ai = function(entity)
    if check_collision_with_player(entity) then
      pewpew.add_damage_to_player_ship(PLAYER[i_id], 1)
      entity:destroyA()
      return nil
    end
    movement_ai(entity)
  end,
  
}
