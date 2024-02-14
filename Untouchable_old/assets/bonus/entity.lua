
local mesh_path = current_folder_path .. 'mesh.lua'

local s_spawn = 1
local s_alive = 2

local spawn_time = 30
local lifetime = 1800
local rotation = 0.64fx
local weapon_box_color = 0x40f0a0ff
local shield_box_color = 0xd0ff40ff
local weapon_timer = 120

return {
  
  group = 'bonus_box',
  
  animation = 'bonus',
  
  radius = 16fx,
  
  proto = {
    state = s_spawn,
    timer = spawn_time,
    lifetime = lifetime,
  },
  
  constructor = function(entity, x, y, ...)
    entity.id = pewpew.new_customizable_entity(x, y)
    
    local args = {...}
    local variation = args[1]
    entity.variation = variation
    entity:set_animation_variation(variation)
    entity.color = variation == BONUS_TYPES.shield and shield_box_color or weapon_box_color
    
    entity.angle = __DEF_FMATH_RANDOM_FX(0fx, TAU_FX)
    entity.arrow_id = pewpew.add_arrow_to_player_ship(PLAYER.id, entity.id, entity.color)
    entity:set_mesh(mesh_path, entity.animation.variation_offset)
    entity:set_mesh_angle(entity.angle, 0fx, 0fx, 1fx)
    entity:start_spawning(spawn_time)
    entity:set_position_interpolation(true)
  end,
  
  destructor = function(entity, ...)
    local x, y = entity:get_position()
    circle_animation:create(x, y, entity.color, 1fx)
    if PLAYER:get_is_alive() then
      pewpew.remove_arrow_from_player_ship(PLAYER.id, entity.arrow_id)
    end
    pewpew.play_sound(SOUNDS_PATH, 0, x, y)
    entity:start_exploding(30)
  end,
  
  ai = function(entity)
    if entity.state == s_spawn then
      entity.timer = entity.timer - 1
      if entity.timer == 0 then
        entity.state = s_alive
      end
    elseif entity.state == s_alive then
      entity.angle = entity.angle + rotation
      local angle = __DEF_FMATH_SINCOS(entity.angle * TAU_FX)
      angle = angle * 0.512fx
      entity:add_rotation_to_mesh(angle, 0fx, 0fx, 1fx)
      
      if check_collision_with_player(entity) then
        if entity.variation == BONUS_TYPES.shield then
          pewpew.configure_player(0, {shield = pewpew.get_player_configuration(0).shield + 1})
        else
          if entity.variation == BONUS_TYPES.pinky then
            PLAYER.weapon_state = PLAYER_WEAPON_STATES.pinky
          elseif entity.variation == BONUS_TYPES.candy then
            PLAYER.weapon_state = PLAYER_WEAPON_STATES.candy
          elseif entity.variation == BONUS_TYPES.potato then
            PLAYER.weapon_state = PLAYER_WEAPON_STATES.potato
          elseif entity.variation == BONUS_TYPES.player_laser then
            PLAYER.weapon_state = PLAYER_WEAPON_STATES.player_laser
            CURRENT_PLAYER_LASER_COLOR = LASER_COLORS[fmath.random_int(1, #LASER_COLORS)]
          end
          PLAYER.weapon_timer = weapon_timer
        end
        entity:destroyA()
        return nil
      end
      
      entity.lifetime = entity.lifetime - 1
      if entity.lifetime == 0 then
        entity:destroyA()
      end
    end
  end,
  
}
