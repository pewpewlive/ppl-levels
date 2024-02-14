
local mesh_path = current_folder_path .. 'mesh.lua'

local lifetime = 30

return {
  
  group = 'player_laser',
  
  damage = 4fx,
  
  proto = {
    timer = 2,
    laser_state = 1,
    lifetime = lifetime,
  },
  
  constructor = function(entity, x, y, ...)
    entity.id = pewpew.new_customizable_entity(x, y)
    
    local args = {...}
    local angle = args[1]
    
    entity.color = args[2]
    entity.angle = angle
    entity.dy, entity.dx = __DEF_FMATH_SINCOS(angle)
    
    entity:start_spawning(0)
    entity:set_mesh_angle(angle, 0fx, 0fx, 1fx)
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
    if entity.laser_state > 0 then
      entity.laser_state = entity.laser_state - 1
    elseif entity.laser_state == 0 then
      entity.laser_state = -1
    end
    if entity.lifetime > 0 then
      entity:set_mesh_color(entity.color + 255 * entity.lifetime // lifetime)
      entity.lifetime = entity.lifetime - 1
    else
      entity:destroyA()
    end
  end,
  
}
