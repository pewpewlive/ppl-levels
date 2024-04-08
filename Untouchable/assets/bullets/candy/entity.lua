
local mesh_path = current_folder_path .. 'mesh.lua'

local lifetime = 100
local speed = 24fx
local color = 0xffff20ff

local _p = {}
_p[i_lifetime] = lifetime
_p[i_timer] = 2

function _p:create_explosion_effect()
  local x, y = self:get_position()
  pewpew.create_explosion(x, y, color, 0.2048fx, 6)
  square_animation:create(x, y, color)
end

return {
  
  group = 'player_bullet',
  
  radius = 12fx,
  damage = 3fx,
  
  proto = _p,
  
  constructor = function(entity, x, y, ...)
    entity[i_id] = pewpew.new_customizable_entity(x, y)
    
    local args = {...}
    local angle = args[1]
    
    local dy, dx = __DEF_FMATH_SINCOS(angle)
    entity[i_dx] = dx * speed
    entity[i_dy] = dy * speed
    
    entity:start_spawning(0)
    entity:set_mesh_angle(angle, 0fx, 0fx, 1fx)
    entity:set_position_interpolation(true)
    configure_wall_bounce(entity)
  end,
  
  destructor = function(entity, ...)
    local x, y = entity:get_position()
    entity:destroy()
  end,
  
  ai = function(entity)
    if entity[i_timer] > 0 then
      entity[i_timer] = entity[i_timer] - 1
    elseif entity[i_timer] == 0 then
      entity:set_mesh(mesh_path, 0)
      entity[i_timer] = -1
    end
    local x, y = entity:get_position()
    entity:set_position(x + entity[i_dx], y + entity[i_dy])
    entity:set_mesh_angle(__DEF_FMATH_ATAN2(entity[i_dy], entity[i_dx]), 0fx, 0fx, 1fx)
    
    entity[i_lifetime] = entity[i_lifetime] - 1
    if entity[i_lifetime] == 0 then
      entity:create_explosion_effect()
      entity:destroyA()
    end
  end,
  
}
