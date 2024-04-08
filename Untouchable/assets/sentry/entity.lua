
local mesh_path = current_folder_path .. 'mesh.lua'
local variations = require(current_folder_path .. 'variations.lua')

local vl = {}
local variation_list = {}
for key, value in pairs(variations) do
  table.insert(variation_list, value)
  vl[key] = #variation_list
end
SENTRY_VARIATIONS = vl
SENTRY_TYPES = variations

local s_spawn = 1
local s_alive = 2

local spawn_time = 60
local lifetime = 900
local on_explosion_amount = 15fx

local v = 0
local vt = 0
local ex = 0fx
local ey = 0fx

function variations.constant.shoot(entity)
  for i = 0fx, 3fx, 1fx do
    enemy_projectile:create(ex, ey, 1, v.color, entity[i_angle] + i * TAU_FX / 4fx)
  end
end

function variations.rotating.shoot(entity)
  for i = 0fx, 3fx, 1fx do
    enemy_projectile:create(ex, ey, 1, v.color, entity[i_angle] + i * TAU_FX / 4fx + v.rotation_speed * 15fx)
  end
end

function variations.homing.shoot(entity)
  for i = 0fx, 3fx, 1fx do
    enemy_projectile:create(ex, ey, 2, v.color, entity[i_angle] + i * TAU_FX / 4fx)
  end
end

function variations.shotgun.shoot(entity)
  for i = 0fx, 3fx, 1fx do
    for n = 1fx, v.projectile_amount, 1fx do
      local angle = entity[i_angle] + i * TAU_FX / 4fx + v.angle_offset * (n - 1fx - v.projectile_amount / 2fx)
      local dy, dx = __DEF_FMATH_SINCOS(angle)
      enemy_projectile:create(ex + dx * 20fx, ey + dy * 20fx, 1, v.color, angle)
    end
  end
end

function variations.stalker.shoot(entity)
  for i = 0fx, 3fx, 1fx do
    enemy_projectile:create(ex, ey, 3, v.color, entity[i_angle] + i * TAU_FX / 4fx)
  end
end

function variations.chain.shoot(entity)
  for i = 0fx, 3fx, 1fx do
    enemy_projectile:create(ex, ey, 1, v.color, entity[i_angle] + i * TAU_FX / 4fx)
  end
end

function variations.rotating_chain.shoot(entity)
  for i = 0fx, 3fx, 1fx do
    enemy_projectile:create(ex, ey, 1, v.color, entity[i_angle] + i * TAU_FX / 4fx)
  end
end

function variations.face.shoot(entity)
  local dx = PLAYER_X - ex
  local dy = PLAYER_Y - ey
  local angle = __DEF_FMATH_ATAN2(dy, dx)
  local _dy, _dx = __DEF_FMATH_SINCOS(angle)
  for i = 0fx, v.projectile_amount, 1fx do
    enemy_projectile:create(ex + entity[i_type].radius * _dx, ey + entity[i_type].radius * _dy, 1, v.color, angle - v.angle_offset + v.angle_offset * i / v.projectile_amount * 2fx)
  end
end

--[[
function variations.constant.shoot(entity)
  
end
]]--

local function maintain_weapon(entity)
  v = entity[i_variation]
  vt = entity[i_variation_type]
  ex, ey = entity:get_position()
  if entity[i_recharge] < 1 and mem < 460 then
    v.shoot(entity)
    entity[i_recharge] = v.recharge
  else
    entity[i_recharge] = entity[i_recharge] - 1
  end
  if vt == vl.rotating then
    entity[i_angle] = entity[i_angle] + v.rotation_speed
    entity:set_mesh_angle(entity[i_angle], 0fx, 0fx, 1fx)
  elseif vt == vl.stalker then
    local dx = PLAYER_X - ex
    local dy = PLAYER_Y - ey
    local angle_offset = __DEF_FMATH_ATAN2(dy, dx) - entity[i_angle]
    local sign = angle_offset > 0fx and 1fx or -1fx
    local abs_angle_offset = sign * angle_offset
    abs_angle_offset = abs_angle_offset % (PI_FX / 2fx)
    if abs_angle_offset > (PI_FX / 4fx) then
      abs_angle_offset = PI_FX / 2fx - abs_angle_offset
      sign = -sign
    end
    entity[i_angle] = entity[i_angle] + sign * (abs_angle_offset > v.rotation_speed and v.rotation_speed or abs_angle_offset)
    entity:set_mesh_angle(entity[i_angle], 0fx, 0fx, 1fx)
  elseif vt == vl.chain then
    if entity[i_recharge] <= v.min_recharge_shot and entity[i_recharge] % v.recharge_shot_delay == 0 and entity[i_recharge] ~= 0 then
      v.shoot(entity)
    end
  elseif vt == vl.rotating_chain then
    if entity[i_recharge] <= v.min_recharge_shot and entity[i_recharge] % v.recharge_shot_delay == 0 and entity[i_recharge] ~= 0 then
      v.shoot(entity)
    end
    entity[i_angle] = entity[i_angle] + v.rotation_speed
    entity:set_mesh_angle(entity[i_angle], 0fx, 0fx, 1fx)
  end
end

local function on_hit(entity, hit_x, hit_y)
  entity[i_is_damaged] = 2
  pewpew.play_sound(SOUNDS_PATH, 7, hit_x, hit_y)
  pewpew.create_explosion(hit_x, hit_y, entity[i_variation].color, 0.2048fx, 6)
  square_animation:create(hit_x, hit_y, entity[i_variation].color)
  entity:set_mesh_color(0xd0d0d0ff)
end

local _p = {}
_p[i_state] = s_spawn
_p[i_timer] = spawn_time
_p[i_is_damaged] = -1
_p[i_lifetime] = lifetime

return {
  
  group = 'enemy',
  
  animation = 'sentry',
  
  radius = 36fx,
  
  proto = _p,
  
  constructor = function(entity, x, y, ...)
    local args = {...}
    entity[i_variation_type] = args[1]
    
    entity[i_id] = pewpew.new_customizable_entity(x, y)
    local angle = __DEF_FMATH_RANDOM_FX(0fx, TAU_FX)
    entity[i_angle] = angle
    entity[i_variation] = variation_list[entity[i_variation_type]]
    entity[i_hp] = entity[i_variation].hp
    entity[i_recharge] = entity[i_variation].recharge // 3
    
    entity:set_mesh(mesh_path, 0)
    entity:set_mesh_color(entity[i_variation].color)
    entity:set_mesh_angle(angle, 0fx, 0fx, 1fx)
    entity:start_spawning(spawn_time)
    entity:set_position_interpolation(true)
    
    sentry_counter = sentry_counter + 1
  end,
  
  destructor = function(entity, ...)
    local x, y = entity:get_position()
    circle_animation:create(x, y, entity[i_variation].color, 0.2048fx)
    pewpew.increase_score_of_player(0, entity[i_variation].score)
    pewpew.play_sound(SOUNDS_PATH, 8, x, y)
    entity:start_exploding(30)
    sentry_counter = sentry_counter - 1
  end,
  
  ai = function(entity)
    if entity[i_state] == s_spawn then
      entity[i_timer] = entity[i_timer] - 1
      if entity[i_timer] == 0 then
        entity[i_state] = s_alive
      end
    elseif entity[i_state] == s_alive then
      entity[i_lifetime] = entity[i_lifetime] - 1
      if entity[i_lifetime] == 0 then
        ex, ey = entity:get_position()
        vt = entity[i_variation_type]
        local projectile_type = 1
        if vt == vl.homing then
          projectile_type = 2
        elseif vt == vl.stalker then
          projectile_type = 3
        end
        local angle = __DEF_FMATH_RANDOM_FX(0fx, TAU_FX)
        if mem < 460 then
          for i = 0fx, on_explosion_amount, 1fx do
            enemy_projectile:create(ex, ey, projectile_type, entity[i_variation].color, angle + i / on_explosion_amount * TAU_FX)
          end
        end
        entity:destroyA()
        return nil
      end
      maintain_weapon(entity)
      if entity[i_is_damaged] == 0 then
        entity[i_is_damaged] = -1
        entity:set_mesh_color(entity[i_variation].color)
      else
        entity[i_is_damaged] = entity[i_is_damaged] - 1
      end
      local bullet = check_collision_with_group(entity, 'player_bullet')
      if bullet then
        local bx, by = bullet:get_position()
        on_hit(entity, bx, by)
        entity[i_hp] = entity[i_hp] - bullet[i_type].damage
        pewpew.increase_score_of_player(0, entity[i_variation].score_per_hit * __DEF_FMATH_TO_INT(bullet[i_type].damage))
        bullet:destroyA()
        if entity[i_hp] <= 0fx then
          entity:destroyA()
          return nil
        end
      end
      ex, ey = entity:get_position()
      if check_collision_with_player_lasers(entity) then
        local random_r = __DEF_FMATH_RANDOM_FX(0fx, entity[i_type].radius)
        local dy, dx = __DEF_FMATH_SINCOS(__DEF_FMATH_RANDOM_FX(0fx, TAU_FX))
        on_hit(entity, ex + random_r * dx, ey + random_r * dy)
        entity[i_hp] = entity[i_hp] - player_laser.damage
        pewpew.increase_score_of_player(0, entity[i_variation].score_per_hit * __DEF_FMATH_TO_INT(player_laser.damage))
        if entity[i_hp] <= 0fx then
          entity:destroyA()
          return nil
        end
      end
      if check_collision_with_player(entity) then
        pewpew.add_damage_to_player_ship(PLAYER[i_id], 1)
        entity:destroyA()
      end
    end
  end,
  
}
