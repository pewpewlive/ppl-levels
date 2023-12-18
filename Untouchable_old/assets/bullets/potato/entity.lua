
local mesh_path = current_folder_path .. 'mesh.lua'

local lifetime = 36
local speed = 18fx
local small_potato_amount = 5fx
local angle_d = TAU_FX / small_potato_amount
local color = 0xff8020ff

return {
  
  group = 'player_bullet',
  
  radius = 12fx,
  damage = 10fx,
  
  proto = {
    lifetime = lifetime,
    timer = 2,
  },
  
  constructor = function(entity, x, y, ...)
    entity.id = pewpew.new_customizable_entity(x, y)
    
    local args = {...}
    local angle = args[1]
    
    local dy, dx = __DEF_FMATH_SINCOS(angle)
    entity.dx = dx * speed
    entity.dy = dy * speed
    entity.angle = angle
    
    entity:start_spawning(0)
    entity:set_mesh_angle(angle, 0fx, 0fx, 1fx)
    entity:set_position_interpolation(true)
    configure_wall_destruction(entity)
    
    function entity:create_explosion_effect()
      local x, y = self:get_position()
      pewpew.create_explosion(x, y, color, 0.2048fx, 6)
      square_animation:create(x, y, color)
    end
  end,
  
  destructor = function(entity, ...)
    local x, y = entity:get_position()
    for i = 1fx, small_potato_amount, 1fx do
      small_potato:create(x, y, entity.angle + angle_d * i)
    end
    entity:destroy()
  end,
  
  ai = function(entity)
    if entity.timer > 0 then
      entity.timer = entity.timer - 1
    elseif entity.timer == 0 then
      entity:set_mesh(mesh_path, 0)
      entity.timer = -1
    end
    
    local x, y = entity:get_position()
    entity:set_position(x + entity.dx, y + entity.dy)
    
    entity.lifetime = entity.lifetime - 1
    if entity.lifetime == 0 then
      entity:create_explosion_effect()
      entity:destroyA()
    end
  end,
  
}
