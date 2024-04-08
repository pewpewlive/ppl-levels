
local mesh_path = current_folder_path .. 'mesh.lua'

local lifetime = 15fx

local _p = {}
_p[i_lifetime] = lifetime

return {
  
  group = 'animation',
  
  proto = _p,
  
  constructor = function(entity, x, y, ...)
    entity[i_id] = pewpew.new_customizable_entity(x, y)
    
    local args = {...}
    local color = args[1]
    
    entity:set_mesh(mesh_path, 0)
    entity:set_position_interpolation(true)
    entity:set_mesh_angle(__DEF_FMATH_RANDOM_FX(0fx, TAU_FX), 0fx, 0fx, 1fx)
    entity:set_mesh_color(color)
    entity:start_spawning(0)
  end,
  
  destructor = function(entity, ...)
    entity:destroy()
  end,
  
  ai = function(entity)
    entity:set_mesh_scale(__DEF_FMATH_SINCOS((1fx - entity[i_lifetime] / lifetime) * PI_FX))
    entity[i_lifetime] = entity[i_lifetime] - 1fx
    if entity[i_lifetime] == -2fx then
      entity:destroyA()
    end
  end,
  
}
