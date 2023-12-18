
local folder_path = current_folder_path
PLAYER_WEAPON_STATES = require(folder_path .. 'weapons.lua')

return {
  
  group = 'player',
  
  radius = 15fx,
  
  proto = {
    weapon_state = PLAYER_WEAPON_STATES.player_bullet,
    weapon_timer = -1,
  },
  
  constructor = function(entity, x, y, ...)
    entity.id = pewpew.new_player_ship(x, y, 0)
  end,
  
  destructor = function(entity, ...)
    
  end,
  
  ai = function(entity)
    PLAYER_X, PLAYER_Y = entity:get_position()
    maintain_player_weapon(entity)
    if entity.weapon_timer > 0 then
      entity.weapon_timer = entity.weapon_timer - 1
    elseif entity.weapon_timer == 0 then
      entity.weapon_state = PLAYER_WEAPON_STATES.player_bullet
      entity.weapon_timer = -1
    end
  end,
  
}
