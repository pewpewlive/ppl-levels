
return {
  
  group = 'animation',
  
  animation = 'star_trail',
  
  constructor = function(entity, x, y, ...)
    local args = {...}
    local angle = args[1]
    
    entity[i_id] = pewpew.new_customizable_entity(x, y)
    
    entity:start_spawning(0)
    entity:set_mesh_angle(angle, 0fx, 0fx, 1fx)
  end,
  
  destructor = function(entity, ...)
    entity:destroy()
  end,
  
  ai = function(entity)
    if entity[i_animation][i_frame] == entity[i_animation][i_type].frame_amount then
      entity:destroyA()
    end
  end,
  
}
