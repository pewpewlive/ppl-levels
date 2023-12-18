
local mesh_path = current_folder_path .. 'mesh.lua'

local lifetime = 60fx

return {
  
  group = 'animation',
  
  proto = {
    lifetime = lifetime,
    timer = 2,
  },
  
  constructor = function(entity, x, y, ...)
    entity.id = pewpew.new_customizable_entity(x, y)
    
    local args = {...}
    entity.variation = args[1]
    
    entity:set_position_interpolation(true)
    entity:start_spawning(0)
  end,
  
  destructor = function(entity, ...)
    entity:destroy()
  end,
  
  ai = function(entity)
    if entity.timer > 0 then
      entity.timer = entity.timer - 1
    elseif entity.timer == 0 then
      entity:set_mesh(mesh_path, entity.variation)
      entity.timer = -1
    end
    entity:set_mesh_scale(__DEF_FMATH_SINCOS((1fx - entity.lifetime / lifetime) * PI_FX / 8fx))
    entity.lifetime = entity.lifetime - 1fx
    if entity.lifetime == 0fx then
      entity:destroyA()
    end
  end,
  
}
