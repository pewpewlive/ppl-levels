
local mesh_path = current_folder_path .. 'mesh.lua'

local s_happy = 1
local s_sad = 2

local lifetime = 90
local speed_start = 18fx
local speed_min = 6fx
local speed_d = 0.1024fx
local speed_max = 48fx
local max_d_mod = 0.1536fx
local color = 0xff30a0ff

local _p = {}
_p[i_lifetime] = lifetime
_p[i_timer] = 2
_p[i_speed] = speed_min

function _p:create_explosion_effect()
  local x, y = self:get_position()
  pewpew.create_explosion(x, y, color, 0.2048fx, 6)
  square_animation:create(x, y, color)
end

return {
  
  group = 'player_bullet',
  
  radius = 10fx,
  damage = 3.2049fx,
  
  proto = _p,
  
  constructor = function(entity, x, y, ...)
    entity[i_id] = pewpew.new_customizable_entity(x, y)
    
    local group = pplaf.entity.get_group'enemy'
    if #group == 0 then
      entity[i_state] = s_sad
    else
      entity[i_state] = s_happy
      entity[i_following_entity] = group[pplaf.math.random(1, #group)]
    end
    
    local args = {...}
    local angle = args[1]
    
    local dy, dx = __DEF_FMATH_SINCOS(angle)
    entity[i_dx] = dx * speed_start
    entity[i_dy] = dy * speed_start
    
    entity:start_spawning(0)
    entity:set_mesh_angle(angle, 0fx, 0fx, 1fx)
    entity:set_position_interpolation(true)
    configure_wall_destruction(entity)
  end,
  
  destructor = function(entity, ...)
    local x, y = entity:get_position()
    entity:destroy()
  end,
  
  ai = function(entity)
    if entity[i_timer] > 0 then
      entity[i_timer] = entity[i_timer] - 1
    elseif entity[i_timer] == 0 then
      entity:set_mesh(mesh_path, 0)
      entity[i_timer] = -1
    end
    
    if entity[i_speed] < speed_max then
      local new_speed = entity[i_speed] + speed_d
      entity[i_dx] = entity[i_dx] / entity[i_speed] * new_speed
      entity[i_dy] = entity[i_dy] / entity[i_speed] * new_speed
      entity[i_speed] = new_speed
      entity[i_speed_max_d] = new_speed * max_d_mod
    end
    
    local following_entity = entity[i_following_entity]
    if entity[i_state] == s_happy and (not following_entity:get_is_alive() or following_entity:get_is_started_to_be_destroyed()) then
      entity[i_state] = s_sad
    end
    
    local x, y = entity:get_position()
    if entity[i_state] == s_happy then
      local ex, ey = entity[i_following_entity]:get_position()
      local dx = ex - x
      local dy = ey - y
      local l = __DEF_FMATH_SQRT(dx * dx + dy * dy)
      if l > entity[i_speed_max_d] then
        dx = dx / l * entity[i_speed_max_d]
        dy = dy / l * entity[i_speed_max_d]
      end
      local edx = entity[i_dx]
      local edy = entity[i_dy]
      edx = edx + dx
      edy = edy + dy
      l = __DEF_FMATH_SQRT(edx * edx + edy * edy)
      if l > speed_max then
        edx = edx / l * entity[i_speed]
        edy = edy / l * entity[i_speed]
      end
      entity[i_dx] = edx
      entity[i_dy] = edy
    elseif entity[i_state] == s_sad then
      for _, enemy in pairs(pplaf.entity.get_group'enemy') do
        if enemy:get_is_alive() and not enemy:get_is_started_to_be_destroyed() then
          entity[i_state] = s_happy
          entity[i_following_entity] = enemy
        end
      end
    end
    entity:set_position(x + entity[i_dx], y + entity[i_dy])
    entity:set_mesh_angle(__DEF_FMATH_ATAN2(entity[i_dy], entity[i_dx]), 0fx, 0fx, 1fx)
    
    entity[i_lifetime] = entity[i_lifetime] - 1
    if entity[i_lifetime] == 0 then
      entity:create_explosion_effect()
      entity:destroyA()
    end
  end,
  
}
