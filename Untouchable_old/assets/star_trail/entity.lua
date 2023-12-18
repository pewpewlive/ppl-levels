
return {
  
  group = 'animation',
  
  animation = 'star_trail',
  
  proto = {
    
  },
  
  constructor = function(entity, x, y, ...)
    local args = {...}
    local angle = args[1]
    
    entity.id = pewpew.new_customizable_entity(x, y)
    
    entity:start_spawning(0)
    entity:set_mesh_angle(angle, 0fx, 0fx, 1fx)
  end,
  
  destructor = function(entity, ...)
    entity:destroy()
  end,
  
  ai = function(entity)
    if entity.animation.frame == entity.animation.type.frame_amount then
      entity:destroyA()
    end
  end,
  
}
