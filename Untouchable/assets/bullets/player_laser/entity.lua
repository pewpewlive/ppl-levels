
local mesh_path = current_folder_path .. 'mesh.lua'

local lifetime = 30

local _p = {}
_p[i_timer] = 2
_p[i_laser_state] = 1
_p[i_lifetime] = lifetime

return {
  
  group = 'player_laser',
  
  damage = 3.3073fx,
  
  proto = _p,
  
  constructor = function(entity, x, y, ...)
    entity[i_id] = pewpew.new_customizable_entity(x, y)
    
    local args = {...}
    local angle = args[1]
    
    entity[i_color] = args[2]
    entity[i_angle] = angle
    entity[i_dy], entity[i_dx] = __DEF_FMATH_SINCOS(angle)
    
    entity:start_spawning(0)
    entity:set_mesh_angle(angle, 0fx, 0fx, 1fx)
  end,
  
  destructor = function(entity, ...)
    entity:destroy()
  end,
  
  ai = function(entity)
    if entity[i_timer] > 0 then
      entity[i_timer] = entity[i_timer] - 1
    elseif entity[i_timer] == 0 then
      entity:set_mesh(mesh_path, 0)
      entity[i_timer] = -1
    end
    if entity[i_laser_state] > 0 then
      entity[i_laser_state] = entity[i_laser_state] - 1
    elseif entity[i_laser_state] == 0 then
      entity[i_laser_state] = -1
    end
    if entity[i_lifetime] > 0 then
      entity:set_mesh_color(entity[i_color] + 255 * entity[i_lifetime] // lifetime)
      entity[i_lifetime] = entity[i_lifetime] - 1
    else
      entity:destroyA()
    end
  end,
  
}
