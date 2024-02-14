
local mesh_path = current_folder_path .. 'mesh.lua'

local lifetime = 15fx

return {
  
  group = 'animation',
  
  proto = {
    lifetime = lifetime,
    timer = 2,
  },
  
  constructor = function(entity, x, y, ...)
    entity.id = pewpew.new_customizable_entity(x, y)
    
    local args = {...}
    local color = args[1]
    entity.size_mod = args[2]
    
    entity:set_position_interpolation(true)
    entity:set_mesh_color(color)
    entity:start_spawning(0)
  end,
  
  destructor = function(entity, ...)
    entity:destroy()
  end,
  
  ai = function(entity)
    if entity.timer > 0 then
      entity.timer = entity.timer - 1
    elseif entity.timer == 0 then
      entity:set_mesh(mesh_path, 0)
      entity.timer = -1
    end
    entity.lifetime = entity.lifetime - 1fx
    entity:set_mesh_scale(entity.size_mod * __DEF_FMATH_SINCOS((1fx - entity.lifetime / lifetime) * PI_FX))
    if entity.lifetime == 0fx then
      entity:destroyA()
    end
  end,
  
}
