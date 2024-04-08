
local folder_path = current_folder_path
PLAYER_WEAPON_STATES = require(folder_path .. 'weapons.lua')

local _p = {}
_p[i_weapon_state] = PLAYER_WEAPON_STATES.player_bullet
_p[i_weapon_timer] = -1

return {
  
  group = 'player',
  
  radius = 15fx,
  
  proto = _p,
  
  constructor = function(entity, x, y, ...)
    entity[i_id] = pewpew.new_player_ship(x, y, 0)
  end,
  
  destructor = function(entity, ...)
    
  end,
  
  ai = function(entity)
    PLAYER_X, PLAYER_Y = entity:get_position()
    maintain_player_weapon(entity)
    if entity[i_weapon_timer] > 0 then
      entity[i_weapon_timer] = entity[i_weapon_timer] - 1
    elseif entity[i_weapon_timer] == 0 then
      entity[i_weapon_state] = PLAYER_WEAPON_STATES.player_bullet
      entity[i_weapon_timer] = -1
    end
  end,
  
}
