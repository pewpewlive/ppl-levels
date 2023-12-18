
require'/dynamic/pplaf/main.lua'
pplaf.init'/dynamic/pplaf/'

require'/dynamic/init.lua'

local function camera_ease_function_end(v)
  return __DEF_FMATH_SINCOS(v * PI_FX)
end

local dbg_color_green = '#00ff00ff'
local dbg_color_white = '#ffffffff'
local dbg_color_red = '#ff0000ff'

pewpew.add_update_callback(function()
  
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
  
  if GAME_STATE then
    TIME = TIME + 1
    wave_generator()
  end
  
  pplaf.entity.main()
  pplaf.camera.main()
  
  -- local lua_player_bullet_counter = #pplaf.entity.get_group'player_bullet'
  -- local real_player_bullet_counter = 0
  -- for _, bullet in pairs(pplaf.entity.get_group'player_bullet') do
    -- real_player_bullet_counter = real_player_bullet_counter + 1
  -- end
  
  -- local dbg_log = {
    -- dbg_color_green,
    -- 'DEBUG',
    -- dbg_color_white,
    -- ' LuaBulletCount:',
    -- dbg_color_green,
    -- lua_player_bullet_counter,
    -- dbg_color_white,
    -- ' RealBulletCount:',
    -- dbg_color_green,
    -- real_player_bullet_counter,
    -- lua_player_bullet_counter == real_player_bullet_counter and dbg_color_green or dbg_color_red,
    -- ' SizeMatch',
  -- }
  -- pewpew.configure_player_hud(0, {top_left_line = table.concat(dbg_log, ' ')})
  
end)
