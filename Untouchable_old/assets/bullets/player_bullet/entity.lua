
local mesh_path = current_folder_path .. 'mesh.lua'

local lifetime = 60

return {
  
  group = 'player_bullet',
  
  radius = 4fx,
  speed = 16fx,
  damage = 2fx,
  
  proto = {
    lifetime = lifetime,
  },
  
  constructor = function(entity, x, y, ...)
    local args = {...}
    local angle = args[1]
    
    entity.id = pewpew.new_player_bullet(x, y, angle, 0)
  end,
  
  destructor = function(entity, ...)
    entity:destroy()
  end,
  
  ai = function(entity)
    entity.lifetime = entity.lifetime - 1
    if entity.lifetime == 0 then
      entity:destroyA()
    end
  end,
  
}
