
local mesh_path = current_folder_path .. 'mesh.lua'

local s_happy = 1
local s_sad = 2

local lifetime = 90
local speed_start = 18fx
local speed_min = 6fx
local speed_d = 0.1024fx
local speed_max = 48fx
local max_d_mod = 0.1536fx
local color = 0xff30a0ff

return {
  
  group = 'player_bullet',
  
  radius = 10fx,
  damage = 4fx,
  
  proto = {
    lifetime = lifetime,
    timer = 2,
    speed = speed_min,
  },
  
  constructor = function(entity, x, y, ...)
    entity.id = pewpew.new_customizable_entity(x, y)
    
    local group = pplaf.entity.get_group'enemy'
    if #group == 0 then
      entity.state = s_sad
    else
      entity.state = s_happy
      entity.following_entity = group[pplaf.math.random(1, #group)]
    end
    
    local args = {...}
    local angle = args[1]
    
    local dy, dx = __DEF_FMATH_SINCOS(angle)
    entity.dx = dx * speed_start
    entity.dy = dy * speed_start
    
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
    entity:destroy()
  end,
  
  ai = function(entity)
    if entity.timer > 0 then
      entity.timer = entity.timer - 1
    elseif entity.timer == 0 then
      entity:set_mesh(mesh_path, 0)
      entity.timer = -1
    end
    
    if entity.speed < speed_max then
      local new_speed = entity.speed + speed_d
      entity.dx = entity.dx / entity.speed * new_speed
      entity.dy = entity.dy / entity.speed * new_speed
      entity.speed = new_speed
      entity.speed_max_d = new_speed * max_d_mod
    end
    
    local following_entity = entity.following_entity
    if entity.state == s_happy and (not following_entity:get_is_alive() or following_entity:get_is_started_to_be_destroyed()) then
      entity.state = s_sad
    end
    
    local x, y = entity:get_position()
    if entity.state == s_happy then
      local ex, ey = entity.following_entity:get_position()
      local dx = ex - x
      local dy = ey - y
      local l = __DEF_FMATH_SQRT(dx * dx + dy * dy)
      if l > entity.speed_max_d then
        dx = dx / l * entity.speed_max_d
        dy = dy / l * entity.speed_max_d
      end
      local edx = entity.dx
      local edy = entity.dy
      edx = edx + dx
      edy = edy + dy
      l = __DEF_FMATH_SQRT(edx * edx + edy * edy)
      if l > speed_max then
        edx = edx / l * entity.speed
        edy = edy / l * entity.speed
      end
      entity.dx = edx
      entity.dy = edy
    elseif entity.state == s_sad then
      for _, enemy in pairs(pplaf.entity.get_group'enemy') do
        if enemy:get_is_alive() and not enemy:get_is_started_to_be_destroyed() then
          entity.state = s_happy
          entity.following_entity = enemy
        end
      end
    end
    entity:set_position(x + entity.dx, y + entity.dy)
    entity:set_mesh_angle(__DEF_FMATH_ATAN2(entity.dy, entity.dx), 0fx, 0fx, 1fx)
    
    entity.lifetime = entity.lifetime - 1
    if entity.lifetime == 0 then
      entity:create_explosion_effect()
      entity:destroyA()
    end
  end,
  
}
