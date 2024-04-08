
local mesh_path = current_folder_path .. 'mesh.lua'

local lifetime = 60

local _p = {}
_p[i_lifetime] = lifetime

return {
  
  group = 'player_bullet',
  
  radius = 4fx,
  speed = 16fx,
  damage = 2fx,
  
  proto = _p,
  
  constructor = function(entity, x, y, ...)
    local args = {...}
    local angle = args[1]
    
    entity[i_id] = pewpew.new_player_bullet(x, y, angle, 0)
  end,
  
  destructor = function(entity, ...)
    entity:destroy()
  end,
  
  ai = function(entity)
    entity[i_lifetime] = entity[i_lifetime] - 1
    if entity[i_lifetime] == 0 then
      entity:destroyA()
    end
  end,
  
}
