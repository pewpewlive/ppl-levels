
require'/dynamic/predef.lua'

require'/dynamic/pplaf/main.lua'
pplaf.init'/dynamic/pplaf/'

require'/dynamic/init.lua'

local function camera_ease_function_end(v)
  return __DEF_FMATH_SINCOS(v * PI_FX)
end

sentry_counter = 0
mem = 0
local time_left = 9000
local is_end = false
local is_last_scene = false
local is_last_scene_ended = false
local end_time_offset = 0
local end_message1 = pewpew.new_customizable_entity(SPAWN_X - 160fx, SPAWN_Y)
local end_message2 = pewpew.new_customizable_entity(SPAWN_X + 160fx, SPAWN_Y)
local end_stat_survival = pewpew.new_customizable_entity(SPAWN_X, SPAWN_Y - 75fx)
local end_stat_shield = pewpew.new_customizable_entity(SPAWN_X, SPAWN_Y - 125fx)
pewpew.customizable_entity_set_mesh_scale(end_message1, 4fx)
pewpew.customizable_entity_set_mesh_scale(end_message2, 4fx)

local survival_bonus = 1000000
local shield_bonus = 250000

pewpew.add_update_callback(function()
  
  if mem > 400 then
    collectgarbage'collect'
  end
  
  if GAME_STATE and not PLAYER:get_is_alive() then
    GAME_STATE = false
    pplaf.camera.configure{
      static_x = SPAWN_X,
      static_y = SPAWN_Y,
      static_z = -1000fx,
      ease_function = camera_ease_function_end,
      ease_distance = 1000fx,
    }
    pewpew.stop_game()
  end
  
  pplaf.entity.main()
  pplaf.camera.main()
  
  if not GAME_STATE then
    return nil
  end
  
  if is_end then
    TIME = TIME + 1
    for _, _ in pairs(pplaf.entity.get_group'enemy_bullet') do
      return nil
    end
    if not is_last_scene then
      is_last_scene = true
      end_time_offset = TIME
      pewpew.customizable_entity_set_string(end_message1, '#ffff60ffYOU')
    elseif TIME - end_time_offset > 60 and not is_last_scene_ended then
      is_last_scene_ended = true
      pewpew.customizable_entity_set_string(end_message2, '#ffff60ffWON')
    elseif TIME - end_time_offset > 150 and GAME_STATE then
      GAME_STATE = false
      pewpew.increase_score_of_player(0, survival_bonus + pewpew.get_player_configuration(0).shield * shield_bonus)
      pplaf.camera.configure{
        static_x = SPAWN_X,
        static_y = SPAWN_Y + 200fx,
        static_z = -1000fx,
        ease_function = camera_ease_function_end,
        ease_distance = 1000fx,
      }
      pewpew.stop_game()
    else
      if TIME - end_time_offset > 90 then
        pewpew.customizable_entity_set_string(end_stat_survival, string.format('#00ff00ffsurvival bonus: %i', survival_bonus))
      end
      if TIME - end_time_offset > 120 then
        pewpew.customizable_entity_set_string(end_stat_shield, string.format('#00ff00ffshield bonus: %i * %i', pewpew.get_player_configuration(0).shield, shield_bonus))
      end
    end
    return nil
  elseif time_left < 1 then
    is_end = true
    for _, entity in pairs(pplaf.entity.get_group'enemy') do
      entity:destroyA()
    end
  else
    time_left = time_left - 1
  end
  
  TIME = TIME + 1
  if mem < 440 then
    wave_generator()
  end
  
  pewpew.configure_player_hud(0, {top_left_line = string.format('#00ff00ffTime left: %i:%02i', time_left / 30 // 60, time_left // 30 % 60)})
  
  -- pewpew.configure_player_hud(0, {top_left_line = string.format('#00ff00ffTime left: %i:%02i | MEMORY USAGE: %iKB %iB', time_left / 30 // 60, time_left // 30 % 60, mem // 1, mem % 1 * 1024)})
  
end)
