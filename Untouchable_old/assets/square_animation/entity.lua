
local mesh_path = current_folder_path .. 'mesh.lua'

local lifetime = 15fx

return {
  
  group = 'animation',
  
  proto = {
    lifetime = lifetime
  },
  
  constructor = function(entity, x, y, ...)
    entity.id = pewpew.new_customizable_entity(x, y)
    
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
    entity:set_mesh_scale(__DEF_FMATH_SINCOS((1fx - entity.lifetime / lifetime) * PI_FX))
    entity.lifetime = entity.lifetime - 1fx
    if entity.lifetime == -2fx then
      entity:destroyA()
    end
  end,
  
}
