
local mesh_path = current_folder_path .. 'mesh.lua'

local s_spawn = 1
local s_alive = 2

local spawn_time = 30
local lifetime = 1800
local rotation = 0.64fx
local weapon_box_color = 0x40f0a0ff
local shield_box_color = 0xd0ff40ff
local weapon_timer = 120

local _p = {}
_p[i_state] = s_spawn
_p[i_timer] = spawn_time
_p[i_lifetime] = lifetime

return {
  
  group = 'bonus_box',
  
  animation = 'bonus',
  
  radius = 16fx,
  
  proto = _p,
  
  constructor = function(entity, x, y, ...)
    entity[i_id] = pewpew.new_customizable_entity(x, y)
    
    local args = {...}
    local variation = args[1]
    entity[i_variation] = variation
    entity[i_animation][i_variation_index] = variation
    entity[i_animation][i_variation_offset] = variation * entity[i_animation][i_type].frame_amount
    entity[i_color] = variation == BONUS_TYPES.shield and shield_box_color or weapon_box_color
    
    entity[i_angle] = __DEF_FMATH_RANDOM_FX(0fx, TAU_FX)
    entity[i_arrow_id] = pewpew.add_arrow_to_player_ship(PLAYER[i_id], entity[i_id], entity[i_color])
    entity:set_mesh(mesh_path, entity[i_animation][i_variation_offset])
    entity:set_mesh_angle(entity[i_angle], 0fx, 0fx, 1fx)
    entity:start_spawning(spawn_time)
    entity:set_position_interpolation(true)
  end,
  
  destructor = function(entity, ...)
    local x, y = entity:get_position()
    circle_animation:create(x, y, entity[i_color], 1fx)
    if PLAYER:get_is_alive() then
      pewpew.remove_arrow_from_player_ship(PLAYER[i_id], entity[i_arrow_id])
    end
    pewpew.play_sound(SOUNDS_PATH, 0, x, y)
    entity:start_exploding(30)
  end,
  
  ai = function(entity)
    if entity[i_state] == s_spawn then
      entity[i_timer] = entity[i_timer] - 1
      if entity[i_timer] == 0 then
        entity[i_state] = s_alive
      end
    elseif entity[i_state] == s_alive then
      entity[i_angle] = entity[i_angle] + rotation
      local angle = __DEF_FMATH_SINCOS(entity[i_angle] * TAU_FX)
      angle = angle * 0.512fx
      entity:add_rotation_to_mesh(angle, 0fx, 0fx, 1fx)
      
      if check_collision_with_player(entity) then
        if entity[i_variation] == BONUS_TYPES.shield then
          pewpew.configure_player(0, {shield = pewpew.get_player_configuration(0).shield + 1})
        else
          if entity[i_variation] == BONUS_TYPES.pinky then
            PLAYER[i_weapon_state] = PLAYER_WEAPON_STATES.pinky
          elseif entity[i_variation] == BONUS_TYPES.candy then
            PLAYER[i_weapon_state] = PLAYER_WEAPON_STATES.candy
          elseif entity[i_variation] == BONUS_TYPES.potato then
            PLAYER[i_weapon_state] = PLAYER_WEAPON_STATES.potato
          elseif entity[i_variation] == BONUS_TYPES.player_laser then
            PLAYER[i_weapon_state] = PLAYER_WEAPON_STATES.player_laser
            CURRENT_PLAYER_LASER_COLOR = LASER_COLORS[fmath.random_int(1, #LASER_COLORS)]
          end
          PLAYER[i_weapon_timer] = weapon_timer
        end
        entity:destroyA()
        return nil
      end
      
      entity[i_lifetime] = entity[i_lifetime] - 1
      if entity[i_lifetime] == 0 then
        entity:destroyA()
      end
    end
  end,
  
}
