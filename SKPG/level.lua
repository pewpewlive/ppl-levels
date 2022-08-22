local player_helpers = require("/dynamic/helpers/player_helpers.lua")
local global_vars = require("/dynamic/global_vars.lua")
local star = require("/dynamic/enemies/lucky_star/code.lua")
local brownian = require("/dynamic/enemies/brownian/code.lua")
local BAF = require("/dynamic/enemies/BAF/BAF.lua")
local tank = require("/dynamic/enemies/tank/code.lua")
local altar = require("/dynamic/enemies/altar/code.lua")
local rival = require("/dynamic/enemies/rival/code.lua")
local eh = require("/dynamic/helpers/enemy_helpers.lua")
local color_helpers = require("/dynamic/helpers/color_helpers.lua")

local width,height = global_vars[1][1],global_vars[1][2]
pewpew.set_level_size(width,height)

local stars = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(stars, "/dynamic/stars.lua", 0)
pewpew.entity_set_update_callback(stars, function()
  pewpew.customizable_entity_add_rotation_to_mesh(stars, fmath.tau() / 4096fx, 0fx, 0fx, 1fx)
end)

local weapon_config = {frequency = 1, cannon = 1}
local ship = player_helpers.new_player_ship(width/2fx+0fx, height / 2fx, 0)
pewpew.configure_player_ship_weapon(ship, weapon_config)
pewpew.configure_player(0, {camera_distance = -100fx, shield = 2--[[,camera_rotation_x_axis = -fmath.tau()/18fx]]})

local function random_position()
    return fmath.random_fixedpoint(50fx, width-50fx), fmath.random_fixedpoint(50fx, height-50fx)
end
local function random_position2()
  return fmath.random_fixedpoint(150fx, width-150fx), fmath.random_fixedpoint(150fx, height-150fx)
end
local function red_brownian_spawn()
  return fmath.random_fixedpoint(50fx, width/2fx-50fx), fmath.random_fixedpoint(100fx, height-100fx)
end
local function blue_brownian_spawn()
  return fmath.random_fixedpoint(width/2fx+50fx, width-50fx), fmath.random_fixedpoint(100fx, height-100fx)
end

local right_side = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(right_side, "/dynamic/cool_graphics.lua", 0)
pewpew.customizable_entity_set_mesh_color(right_side,0x0000ffff)
local left_side = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(left_side, "/dynamic/cool_graphics.lua", 0)
pewpew.customizable_entity_set_mesh_scale(left_side,-1fx)
pewpew.customizable_entity_set_mesh_color(left_side,0xff0000ff)
local beams = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(beams, "/dynamic/beam_graphics.lua", 0)
local beams2 = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(beams2, "/dynamic/beam_graphics.lua", 1)

--[[for i = 1, 5 do
  local ra = fmath.random_int(0,1)
  if ra == 0 then
    rx,ry = red_brownian_spawn()
  else
    rx,ry = blue_brownian_spawn()
  end
  brownian.new(rx,ry,0,ra) 
end]]
--local rx,ry = random_position()
--BAF.new(rx,ry,ship,6fx,fmath.random_fixedpoint(0fx,fmath.tau()))
--local rx,ry = random_position2()
--tank.new(rx,ry,ship,weapon_config)
local alters = altar.new(width/2fx,height/2fx,ship)
local rival_table = {rival.new(width-50fx,height-50fx), rival.new(50fx,height-50fx), rival.new(width/2fx-width/2fx+50fx,50fx),rival.new(width-50fx,50fx)}
for i = 1, #rival_table do eh.add_entity_to_type(eh.types.RIVAL, rival_table[i]) end
--star.new(rx,ry, rival_table)

--[[local rx,ry = random_position2()
tank.new(rx,ry,ship,weapon_config)
local rx,ry = random_position2()
tank.new(rx,ry,ship,weapon_config)]]

gifted_rival_count = 0

local function lerp(ax, ay, bx, by, t)
  return (ax * (1fx - t)) + (bx * t), (ay * (1fx - t)) + (by * t)
end

local function lerp1(a, b, t)
  return (a * (1 - t)) + (b * t)
end

local function lerp1f(a, b, t)
  return (a * (1fx - t)) + (b * t)
end

local shooting_count = 0
local global_frame = 30

local function laser(x,y)
  local angle = fmath.atan2(height / 2fx - y, width / 2fx - x)
  local sin, cos = fmath.sincos(angle)
  local id2 = eh.basic_needs(x + cos * 15fx,y +sin * 15fx,"/dynamic/enemies/altar/other_laser.lua",0,nil,1fx/4fx,nil)
  pewpew.customizable_entity_set_mesh_angle(id2,angle,0fx,0fx,1fx)
  pewpew.customizable_entity_skip_mesh_attributes_interpolation(id2)
  pewpew.customizable_entity_start_spawning(id2,0)
  local time = 0
  local once_up = true
  pewpew.entity_set_update_callback(id2,function()
    if time ~= 30 then
      time = time + 1
      pewpew.customizable_entity_set_mesh(id2,"/dynamic/enemies/altar/other_laser.lua",time)
    end
    if time == 30 and once_up then shooting_count = shooting_count + 1; once_up = false end
    if time == 30 and shooting_count == 4 then
      global_frame = global_frame + 1
      pewpew.customizable_entity_set_mesh(id2,"/dynamic/enemies/altar/other_laser.lua",global_frame)
      if global_frame > 58 then
          pewpew.entity_destroy(id2)
      end
    end
  end)
end

local tanks = 1
local time = 0
local once = false
local mod = 480
local mod2 = 55
local mod3 = 110
local camera_t = 0fx
local old_x, old_y = 0fx, 0fx
local px, py = 0fx, 0fx
local time_reset = true
local color_fade = 0
local rotation_speed = 0fx
local shake_factor = 2fx
local once_spawn = true
local final = false
function level_tick()
  time = time + 1
  if not gifted_rival_count ~= 4 then 
    local conf = pewpew.get_player_configuration(0)
    if conf["has_lost"] then
      pewpew.stop_game()
    end
  end
  if gifted_rival_count ~= 4 then
    if time % 240 == 0 and mod2 > 1 then
      mod2 = mod2 - 1
    end
    if time % 250 == 0 then
      mod3 = mod3 - 1
    end
    if time % 150 == 0 then
      local random_int = fmath.random_int(1,3)
      local MEGA = fmath.random_int(1,100)
      if MEGA ~= 1 then
        if random_int == 1 then
          local rx,ry = random_position()
          pewpew.new_mothership(rx, ry, pewpew.MothershipType.THREE_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
        elseif random_int == 2 then
          local rx,ry = random_position()
          pewpew.new_mothership(rx, ry, pewpew.MothershipType.FIVE_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
        else
          local rx,ry = random_position()
          pewpew.new_mothership(rx, ry, pewpew.MothershipType.SIX_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
        end
      else
        local rx,ry = random_position()
        pewpew.new_mothership(rx, ry, pewpew.MothershipType.FOUR_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
      end
    end
    if time % 325 == 0 then
      local rx,ry = random_position()
      BAF.new(rx,ry,ship,5fx,fmath.random_fixedpoint(0fx,fmath.tau()))
    end
    if time % mod == 0 then
      local rx,ry = random_position()
      pewpew.new_inertiac(rx,ry,1fx,fmath.random_fixedpoint(0fx,fmath.tau()))
      mod = mod - 1
    end
    if time % mod2 == 0 then
      for i = 1, 2 do
        local ra = fmath.random_int(0,1)
        if ra == 0 then
          rx,ry = red_brownian_spawn()
        else
          rx,ry = blue_brownian_spawn()
        end
        brownian.new(rx,ry,0,ra) 
      end
    end
    if pewpew.entity_get_is_alive(ship) then
      if time % 10 == 0 and tanks < 2 then
        local rx,ry = random_position2()
        tan = tank.new(rx,ry,ship,weapon_config)
        tanks = tanks + 1
        once = true
      end
      if once and not pewpew.entity_get_is_alive(tan) then
        tanks = tanks - 1
        once = false
      end
    end
    if time % 800 == 0 then--kaj be like 
      star.new(rx,ry, rival_table)
    end
  else
    if not final then
    if time_reset then 
      time = 0 
      time_reset = false 
    end

    if time == 60 then
      pewpew.entity_set_update_callback(alters[1], nil)

      local entities = pewpew.get_all_entities()
      for i = 1, #entities do
        if pewpew.entity_get_is_alive(entities[i]) then
          local x, y = pewpew.entity_get_position(entities[i])
          pewpew.entity_react_to_weapon(entities[i], {type = pewpew.WeaponType.ATOMIZE_EXPLOSION, x = x, y = y, player_index = 0}) 
        end
      end

      px, py = pewpew.entity_get_position(ship)
      pewpew.entity_destroy(ship)
      pewpew.increase_score_of_player(0, -pewpew.get_score_of_player(0) + 20200620) 
    end
    
    if time > 60 and time < 160 then
      if camera_t < 1fx then camera_t = camera_t + (1fx / 85fx) else camera_t = 1fx end
      local new_x, new_y = lerp(px, py, width / 2fx, height / 2fx, camera_t)
      pewpew.configure_player(0, {camera_x_override = new_x, camera_y_override = new_y})
    end

    if time == 161 then 
      pewpew.customizable_entity_start_exploding(alters[2], 30) 
      pewpew.customizable_entity_start_exploding(alters[3], 30)
      pewpew.play_ambient_sound("/dynamic/enemies/altar/sfx.lua",3)
    end

    if time > 200 and time < 265 then
      local rangle = fmath.random_fixedpoint(0fx,fmath.tau())
      local offy,offx = fmath.sincos(rangle)
      pewpew.configure_player(0,{camera_x_override = width / 2fx+offx*5fx,camera_y_override = height / 2fx+offy*5fx})

      if time % 15 == 0 then 
        pewpew.create_explosion(width / 2fx, height / 2fx, 0xff8800ff, 2fx, 35)
      end
    end

    if time == 261 then 
      pewpew.customizable_entity_set_mesh_color(alters[1], 0xff8800ff)
      pewpew.play_ambient_sound("/dynamic/enemies/altar/sfx.lua",2)
      pewpew.customizable_entity_set_mesh_scale(alters[1], 3fx) 
      pewpew.create_explosion(width / 2fx, height / 2fx, 0xff8800ff, 3fx, 50)
      pewpew.create_explosion(width / 2fx, height / 2fx, 0xffffffff, 1fx, 20)
    end

    if time == 266 then pewpew.configure_player(0,{camera_x_override = width / 2fx,camera_y_override = height / 2fx}) end

    if time > 270 and time < 390 then
      if rotation_speed < 1fx then rotation_speed = rotation_speed + (1fx / 120fx) else rotation_speed = 1fx end
    end

    if time > 270 then
      if pewpew.entity_get_is_alive(alters[1]) then pewpew.customizable_entity_add_rotation_to_mesh(alters[1], lerp1f(0fx, 0.059fx, rotation_speed), 0fx, 0fx, 1fx) end
    end

    if time > 420 and global_frame < 58 then
      local rangle = fmath.random_fixedpoint(0fx,fmath.tau())
      local offy,offx = fmath.sincos(rangle)
      pewpew.configure_player(0,{camera_x_override = width / 2fx+offx*shake_factor,camera_y_override = height / 2fx+offy*shake_factor})
      
      if shake_factor == 3.2048fx then
        if time % 30 == 0 then 
          pewpew.create_explosion(width / 2fx, height / 2fx, 0xff8800ff, 2fx, 35)
          pewpew.create_explosion(width / 2fx, height / 2fx, 0xff0000ff, 1fx/2fx, 50)
          pewpew.create_explosion(width / 2fx, height / 2fx, 0x0000ffff, 1fx/2fx, 50)
        end
      elseif shake_factor == 5fx then
        if time % 20 == 0 then 
          pewpew.create_explosion(width / 2fx, height / 2fx, 0xff8800ff, 2fx, 35)
          pewpew.create_explosion(width / 2fx, height / 2fx, 0xff0000ff, 1fx/2fx, 50)
          pewpew.create_explosion(width / 2fx, height / 2fx, 0x0000ffff, 1fx/2fx, 50)
        end
      elseif shake_factor == 6.2048fx then
        if time % 10 == 0 then 
          pewpew.create_explosion(width / 2fx, height / 2fx, 0xff8800ff, 2fx, 35)
          pewpew.create_explosion(width / 2fx, height / 2fx, 0xff0000ff, 1fx/2fx, 50)
          pewpew.create_explosion(width / 2fx, height / 2fx, 0x0000ffff, 1fx/2fx, 50)
        end
      elseif shake_factor == 8fx then
        if time % 5 == 0 then 
          pewpew.create_explosion(width / 2fx, height / 2fx, 0xff8800ff, 2fx, 35)
          pewpew.create_explosion(width / 2fx, height / 2fx, 0xff0000ff, 1fx/2fx, 50)
          pewpew.create_explosion(width / 2fx, height / 2fx, 0x0000ffff, 1fx/2fx, 50)
        end
      end
    end

    if time == 480 then
      laser(width-50fx,height-50fx)
      shake_factor = shake_factor + 3fx/2fx
      pewpew.play_ambient_sound("/dynamic/enemies/altar/sfx.lua",1)
    end
    if time == 540 then
      laser(width-50fx,50fx)
      shake_factor = shake_factor + 3fx/2fx
      pewpew.play_ambient_sound("/dynamic/enemies/altar/sfx.lua",1)
    end
    if time == 600 then
      laser(50fx,50fx)
      shake_factor = shake_factor + 3fx/2fx
      pewpew.play_ambient_sound("/dynamic/enemies/altar/sfx.lua",1)
    end
    if time == 660 then
      laser(50fx,height-50fx)
      shake_factor = shake_factor + 3fx/2fx
      pewpew.play_ambient_sound("/dynamic/enemies/altar/sfx.lua",1)
    end

    if (global_frame > 58 and global_frame < 100) and once_spawn then 
      time = 1001
      global_frame = 101
      once_spawn = false
      local rival = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
      pewpew.customizable_entity_set_mesh(rival,"/dynamic/enemies/rival/mesh.lua",1)
      pewpew.customizable_entity_start_spawning(rival, 0)
      pewpew.customizable_entity_add_rotation_to_mesh(rival, fmath.tau() / 4fx, 0fx, 0fx, 1fx)
      pewpew.customizable_entity_set_mesh_scale(rival, 5.2048fx)
      pewpew.entity_set_radius(rival, 85fx)

      pewpew.create_explosion(width / 2fx, height / 2fx, 0xff0000ff, 2fx, 50)
      pewpew.create_explosion(width / 2fx, height / 2fx, 0x0000ffff, 2fx, 50)

      pewpew.play_ambient_sound("/dynamic/enemies/altar/sfx.lua",4)
      pewpew.customizable_entity_skip_mesh_attributes_interpolation(rival)

      camera_t = 0fx

      local z = 0fx
      local s = 5.2048fx
      pewpew.customizable_entity_set_player_collision_callback(rival,function(entity_id, player_index, ship_entity_id)
        if z == 0fx then pewpew.customizable_entity_start_exploding(alters[1], 30) end
        pewpew.customizable_entity_set_mesh_z(beams, z)
        pewpew.customizable_entity_set_mesh_z(beams2, z)
        pewpew.customizable_entity_set_mesh_z(right_side, z)
        pewpew.customizable_entity_set_mesh_z(left_side, z)
        pewpew.customizable_entity_set_mesh_z(stars, z)
        pewpew.set_player_ship_speed(ship,0fx,0fx,400)

        z = (z + 30fx)
        s = s + 0.2048fx
        pewpew.customizable_entity_set_mesh_scale(rival, s)

        if s >= 20fx then final = true; time = 0;
          pewpew.entity_destroy(beams)
          pewpew.entity_destroy(beams2)
          pewpew.entity_destroy(right_side)
          pewpew.entity_destroy(left_side)
          pewpew.entity_destroy(stars)
          for i = 1, #rival_table do
            pewpew.entity_destroy(rival_table[i])
          end
          pewpew.customizable_entity_start_exploding(rival, 30)
          pewpew.add_damage_to_player_ship(ship, 999)
         end
      end)
    end

    if time > 1060 and global_frame == 105 and time < 1160 then
      if camera_t < 1fx then camera_t = camera_t + (1fx / 85fx) else camera_t = 1fx end
      local new_x, new_y = lerp(width / 2fx, height / 2fx, px, py, camera_t)
      pewpew.configure_player(0, {camera_x_override = new_x, camera_y_override = new_y})
    end

    if time == 1190 then ship = player_helpers.new_player_ship(px, py, 0) end
  end
  end
end

pewpew.add_update_callback(level_tick)
