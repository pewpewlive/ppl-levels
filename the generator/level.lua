local angle_helpers = require("/dynamic/helpers/angle_helpers.lua")
local player_helpers = require("/dynamic/helpers/player_helpers.lua")
local floating_message = require("/dynamic/helpers/floating_message.lua")
local shield_box = require("/dynamic/helpers/boxes/shield_box.lua")
local cannon_box = require("/dynamic/helpers/boxes/cannon_box.lua")

local width = 1500fx
local height = 1500fx
pewpew.set_level_size(width, height)

local background = pewpew.new_customizable_entity(0fx, 750fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/outline.lua", 0)
pewpew.customizable_entity_configure_music_response(background, {scale_y_start = 1fx, scale_y_end = 11fx/10fx})

local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_30, cannon = pewpew.CannonType.DOUBLE, duration = 65473426}
local spx,spy = width / 2fx - 50fx, 400fx
local player = player_helpers.new_player_ship(spx, spy, 0)
pewpew.configure_player(0, {camera_distance = 0fx, shield = 5})

pewpew.configure_player_ship_weapon(player, weapon_config)

local function random_position()
    return fmath.random_fixedpoint(10fx, width-10fx), fmath.random_fixedpoint(10fx, height-10fx)
end

local dc = false

pewpew.increase_score_of_player(0,1000)

local baf_nr = 10

local rc = 5

local is_powered_on = true

local function power_generator(x,y)
  power_generator = pewpew.new_customizable_entity(x,y)
  pewpew.customizable_entity_set_mesh(power_generator, "/dynamic/ps.lua", 0)
  local power_meter = 15
  local time = 0
  local time1 = 0
  local time2 = 0
  local time3 = 0
  local t = 0
  local power_meter_entity = pewpew.new_customizable_entity(x+200fx,y+200fx)
  pewpew.add_update_callback(
     function()
      if pewpew.entity_get_is_alive(player) == true then
      time = time + 1
     local px,py = pewpew.entity_get_position(player)
       if px > 500fx and px < 900fx and py > 500fx and py < 900fx then
        t = 0
        time3 = time3 + 1
       pewpew.set_player_ship_speed(player,1fx,-3fx,-1)
       local score = pewpew.get_score_of_player(0)
       if time3 == 1 and score < 12500 and is_powered_on == true then
       pewpew.configure_player_ship_weapon(player, {frequency = pewpew.CannonFrequency.FREQ_15, cannon = pewpew.CannonType.SINGLE})
       elseif time3 == 1 and score >= 12500 and is_powered_on == true then
       pewpew.configure_player_ship_weapon(player, {frequency = pewpew.CannonFrequency.FREQ_30, cannon = pewpew.CannonType.DOUBLE})
       end
       if power_meter < 100 and time % 10 == 0 then
         power_meter = power_meter + 1
       end
       local score = pewpew.get_score_of_player(0)
       if power_meter > 60 and score <= 2500 then
          pewpew.increase_score_of_player(0, 2501-score)
       end
       time2 = time2 + 1
       local score = pewpew.get_score_of_player(0)
       if time2 == 150 and score > 2500 then
        local conf = pewpew.get_player_configuration(0)
        pewpew.configure_player(0, {shield = conf.shield + 1})
        for i = 1, 5 do
          local x,y = random_position()
          local random_angle = fmath.random_fixedpoint(0fx,fmath.tau())
          pewpew.new_rolling_sphere(x,y,random_angle,10fx)
        end
       end
      elseif is_powered_on == true then
         time2 = 0
         time3 = 0
         t = t + 1
         if t % 10 == 1 then
         pewpew.configure_player_ship_weapon(player, weapon_config)
         pewpew.print(weapon_config.frequency)
         end
         if t == 1 then
          pewpew.set_player_ship_speed(player,1fx,0fx,-1)
         end
         local score = pewpew.get_score_of_player(0)
         if power_meter > 0 and time % 10 == 0 then
            power_meter = power_meter - 1
         end
       end
      end
        pewpew.customizable_entity_set_string(power_meter_entity,power_meter)
       if power_meter == 0 then
         pewpew.configure_player(0, {camera_distance = 900fx})
         time1 = time1 + 1
         is_powered_on = false
         if time1 == 1 then
          pewpew.configure_player_ship_weapon(player, {frequency = pewpew.CannonFrequency.FREQ_15, cannon = pewpew.CannonType.SINGLE})
          local conf = pewpew.get_player_configuration(0)
          pewpew.configure_player(0, {shield = conf.shield - conf.shield})
         end
        end
        pewpew.customizable_entity_configure_music_response(power_generator, {scale_z_start = 1fx, scale_z_end = 2fx})
      end)
    player_helpers.add_arrow(power_meter_entity, 0xffffffff)
end
power_generator(500fx,500fx)
local time = 0
local time1 = 0
local time2 = 0
local time3 = 0
local timeidk = 0
local t = 0
pewpew.add_update_callback(
    function()
      time = time + 1
      player_helpers.stop_level_if_players_lost()
      if pewpew.entity_get_is_alive(player) == true then
        if time == 37 then
          local x,y = pewpew.entity_get_position(player)
          local new_message = floating_message.new(x, y + 90fx, "Power the generator", 1fx, 0xff0000ff, 2)
          local new_message2 = floating_message.new(x, y - 90fx, "or it will explode.", 1fx, 0xff0000ff, 2)
        end
      local score = pewpew.get_score_of_player(0)
      if time % 30 == 0 then
         local iw = fmath.random_int(1,22)
         if iw ~= 10 or score < 1000 then
           for i = 1, baf_nr do
             x,y = random_position()
             local random_angle = fmath.random_fixedpoint(0fx,fmath.tau())
              local rand_speed = fmath.random_fixedpoint(5fx,7fx)
             pewpew.new_baf_blue(x,y,random_angle,rand_speed,-1)
           end
          elseif iw == 10 then
            local score = pewpew.get_score_of_player(0)
            pewpew.increase_score_of_player(0, -1000)
            local ws = fmath.random_int(1,4)
            if ws == 1 then
              local x, y = 0fx, 5fx
              for i = 1, fmath.to_int(height / 30fx) do
              local baf = pewpew.new_baf(x,y,angle_helpers.rad(90fx),8fx,-1)
              x = x + (height / 50fx)
              end
            elseif ws == 2 then
              local x, y = 5fx, 1fx
              for i = 1, fmath.to_int(width / 30fx) do
              local baf = pewpew.new_baf(x,y,angle_helpers.rad(0fx),8fx,-1)
              y = y + (width / 50fx)
              end
            elseif ws == 3 then
              local x, y = 0fx, 1495fx
              for i = 1, fmath.to_int(height / 30fx) do
              local baf = pewpew.new_baf(x,y,angle_helpers.rad(270fx),8fx,-1)
              x = x + (height / 50fx)
              end
            elseif ws == 4 then
             local x, y = 1495fx, 1fx
              for i = 1, fmath.to_int(width / 30fx) do
              local baf = pewpew.new_baf(x,y,angle_helpers.rad(180fx),8fx,-1)
              y = y + (width / 50fx)
              end
            end
          end    
      end
      local score = pewpew.get_score_of_player(0)
      if score > 2500 and time % 40 == 0 or is_powered_on == false and time % 40 == 0 then
        for i = 1,5 do
          x,y = random_position()
          pewpew.new_rolling_cube(x,y)
        end
      end
      if score >= 2500 then
        time2 = time2 + 1
        if time2 == 1 then
        local test = pewpew.new_customizable_entity(0fx, 0fx)
        pewpew.customizable_entity_set_mesh(test, "/dynamic/bg.lua", 0)
        local test2 = pewpew.new_customizable_entity(0fx, 0fx)
        pewpew.customizable_entity_set_mesh(test2, "/dynamic/bg2.lua", 0)
        local test3 = pewpew.new_customizable_entity(0fx, 0fx)
        pewpew.customizable_entity_set_mesh(test3, "/dynamic/bg3.lua", 0)
        local test4 = pewpew.new_customizable_entity(0fx, 0fx)
        pewpew.customizable_entity_set_mesh(test4, "/dynamic/bg4.lua", 0)
        local test5 = pewpew.new_customizable_entity(0fx, 0fx)
        pewpew.customizable_entity_set_mesh(test5, "/dynamic/bg5.lua", 0)
        local test6 = pewpew.new_customizable_entity(0fx, 0fx)
        pewpew.customizable_entity_set_mesh(test6, "/dynamic/bg6.lua", 0)
        pewpew.play_ambient_sound("/dynamic/2.5k.lua", 0)
        end
      end
      if score >= 5000 then
        time1 = time1 + 1
        if time1 == 1 then
          weapon_config = {frequency = pewpew.CannonFrequency.FREQ_5, cannon = pewpew.CannonType.HEMISPHERE, duration = 654734286}
        end
      end
      if score >= 10000 and time % 60 == 0 or is_powered_on == false and time % 60 == 0 then
        local m_type = fmath.random_int(2,4)
        local x,y = random_position()
        local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
        local score = pewpew.get_score_of_player(0)
        --if m_type == 1 then
        --pewpew.new_mothership(x, y, pewpew.MothershipType.THREE_CORNERS, RandomAngle)
        if m_type == 2 then
            pewpew.new_mothership(x, y, pewpew.MothershipType.FIVE_CORNERS, RandomAngle)
        elseif m_type == 3 then
            pewpew.new_mothership(x, y, pewpew.MothershipType.SIX_CORNERS, RandomAngle)
        elseif m_type == 4 then
            pewpew.new_mothership(x, y, pewpew.MothershipType.SEVEN_CORNERS, RandomAngle)        
        end
     end
     if score >= 12500 and time % 200 == 0 or is_powered_on == false and time % 200 == 0 then
      local wc = fmath.random_int(1,2)
      if wc == 1 then
        local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
        pewpew.new_inertiac(width,height,1fx,RandomAngle)
       local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
       pewpew.new_inertiac(0fx,0fx,1fx,RandomAngle)
      else
        local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
       pewpew.new_inertiac(width,0fx,1fx,RandomAngle)
        local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
        pewpew.new_inertiac(0fx,height,1fx,RandomAngle)
      end
     end
     --if score >= 15000 and time % 300 == 0 or is_powered_on == false and time % 75 == 0 then
      --local x,y = random_position()
      --local ufo = pewpew.new_ufo(x,y,7fx)
      --pewpew.ufo_set_enable_collisions_with_walls(ufo,true)
     --end
     if time % 1250 == 0 then
      local conf = pewpew.get_player_configuration(0)
      pewpew.configure_player(0, {shield = conf.shield + 2})
      local x,y = pewpew.entity_get_position(power_generator)
      bomb = pewpew.new_bomb(x+200fx,y+200fx,pewpew.BombType.SMALL_ATOMIZE)
      player_helpers.add_arrow(bomb, 0x440dd5ff)
      baf_nr = baf_nr * 1.2
      rc = rc + 1
     end
     if score >= 20000 and time % 750 == 0 or is_powered_on == false and time % 600 == 0 then
       for a = 1,35 do
         local x,y = random_position()
         pewpew.new_crowder(x,y)
       end
     end
     if score >= 50000 then
      time3 = time3 + 1
      if time3 == 1 then
      end
     end
     if score >= 22500 and time % 50 == 0 or is_powered_on == false and time % 90 == 0 then
      local x,y = random_position()
      local random_angle = fmath.random_fixedpoint(0fx,fmath.tau())
      pewpew.new_rolling_sphere(x,y,random_angle,4fx)
     end
     local x,y = pewpew.entity_get_position(player)
     if x <= 1fx and y <= 1fx and dc == false or x <= 1fx and y >= 1499fx and dc == false or x >= 1499fx and y <= 1fx and dc == false or x >= 1499fx and y >= 1499fx and dc == false then
      timeidk = timeidk + 1
      if timeidk == 1 then
      pewpew.make_player_ship_transparent(player,35)
      pewpew.set_player_ship_speed(player,2fx,0fx,35)
      t = 0
      dc = true
      pewpew.create_explosion(0fx,0fx,0xff0000ff,1fx,99)
      pewpew.play_sound("/dynamic/boom.lua", 0,0fx,0fx)
      pewpew.create_explosion(0fx,1500fx,0xff0000ff,1fx,99)
      pewpew.play_sound("/dynamic/boom.lua", 0,0fx,1500fx)
      pewpew.create_explosion(1500fx,0fx,0xff0000ff,1fx,99)
      pewpew.play_sound("/dynamic/boom.lua", 0,1500fx,0fx)
      pewpew.create_explosion(1500fx,1500fx,0xff0000ff,1fx,99)
      pewpew.play_sound("/dynamic/boom.lua", 0,1500fx,1500fx)
      else
        timeidk = 0
      end
    else
      t = t + 1
      if t == 300 and pewpew.get_time() < 20 then
        pewpew.create_explosion(0fx,0fx,0x0000ffff,1fx,99)
        pewpew.play_sound("/dynamic/boom.lua", 0,0fx,0fx)
        pewpew.create_explosion(0fx,1500fx,0x0000ffff,1fx,99)
        pewpew.play_sound("/dynamic/boom.lua", 0,0fx,1500fx)
        pewpew.create_explosion(1500fx,0fx,0x0000ffff,1fx,99)
        pewpew.play_sound("/dynamic/boom.lua", 0,1500fx,0fx)
        pewpew.create_explosion(1500fx,1500fx,0x0000ffff,1fx,99)
        pewpew.play_sound("/dynamic/boom.lua", 0,1500fx,1500fx)
        pewpew.create_explosion(750fx,750fx,0x0000ffff,1fx,99)
        pewpew.play_sound("/dynamic/boom.lua", 0,750fx,750fx)
        dc = false
      end
      end
     end
    end)