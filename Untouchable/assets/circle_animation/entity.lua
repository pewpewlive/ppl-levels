
local mesh_path = current_folder_path .. 'mesh.lua'

local lifetime = 15fx

local _p = {}
_p[i_lifetime] = lifetime
_p[i_timer] = 2

return {
  
  group = 'animation',
  
  proto = _p,
  
  constructor = function(entity, x, y, ...)
    entity[i_id] = pewpew.new_customizable_entity(x, y)
    
    local args = {...}
    local color = args[1]
    entity[i_size_mod] = args[2]
    
    entity:set_position_interpolation(true)
    entity:set_mesh_color(color)
    entity:start_spawning(0)
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
    entity[i_lifetime] = entity[i_lifetime] - 1fx
    entity:set_mesh_scale(entity[i_size_mod] * __DEF_FMATH_SINCOS((1fx - entity[i_lifetime] / lifetime) * PI_FX))
    if entity[i_lifetime] == 0fx then
      entity:destroyA()
    end
  end,
  
}
