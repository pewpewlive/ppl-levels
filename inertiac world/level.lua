local angle_helpers = require("/dynamic/helpers/angle_helpers.lua")
local player_helpers = require("/dynamic/helpers/player_helpers.lua")
local floating_message = require("/dynamic/helpers/floating_message.lua")
local shield_box = require("/dynamic/helpers/boxes/shield_box.lua")
local cannon_box = require("/dynamic/helpers/boxes/cannon_box.lua")
local turret = require("/dynamic/player_turret.lua")

local width = 1500fx
local height = 1500fx
pewpew.set_level_size(width, height)

local background = pewpew.new_customizable_entity(750fx, 750fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/outline.lua", 0)

local bg1 = pewpew.new_customizable_entity(750fx, 750fx)
pewpew.customizable_entity_set_mesh(bg1, "/dynamic/bg.lua", 0)

local bg2 = pewpew.new_customizable_entity(750fx, 750fx)
pewpew.customizable_entity_set_mesh(bg2, "/dynamic/bg.lua", 1)

local bg3 = pewpew.new_customizable_entity(750fx, 750fx)
pewpew.customizable_entity_set_mesh(bg3, "/dynamic/bg.lua", 2)

local bg4 = pewpew.new_customizable_entity(750fx, 750fx)
pewpew.customizable_entity_set_mesh(bg4, "/dynamic/bg.lua", 3)

local bg5 = pewpew.new_customizable_entity(750fx, 750fx)
pewpew.customizable_entity_set_mesh(bg5, "/dynamic/bg.lua", 4)

local bg6 = pewpew.new_customizable_entity(750fx, 750fx)
pewpew.customizable_entity_set_mesh(bg6, "/dynamic/bg.lua", 5)

local bg7 = pewpew.new_customizable_entity(750fx, 750fx)
pewpew.customizable_entity_set_mesh(bg7, "/dynamic/bg.lua", 6)

local bg8 = pewpew.new_customizable_entity(750fx, 750fx)
pewpew.customizable_entity_set_mesh(bg8, "/dynamic/bg.lua", 7)

local bg9 = pewpew.new_customizable_entity(750fx, 750fx)
pewpew.customizable_entity_set_mesh(bg9, "/dynamic/bg.lua", 8)

local bg11 = pewpew.new_customizable_entity(750fx, 750fx)
pewpew.customizable_entity_set_mesh(bg11, "/dynamic/bg.lua", 10)

local bg12 = pewpew.new_customizable_entity(750fx, 750fx)
pewpew.customizable_entity_set_mesh(bg12, "/dynamic/bg.lua", 11)

local bg10 = pewpew.new_customizable_entity(750fx, 750fx)
pewpew.customizable_entity_set_mesh(bg10, "/dynamic/bg.lua", 9)

local sphere = pewpew.new_customizable_entity(750fx, 750fx)
pewpew.customizable_entity_set_mesh(sphere, "/dynamic/sphere.lua", 0)

pewpew.add_wall(0fx,750fx,220fx,220fx)
pewpew.add_wall(750fx,0fx,220fx,220fx)
pewpew.add_wall(750fx,0fx,1280fx,220fx)
pewpew.add_wall(1280fx,220fx,1500fx,750fx)
pewpew.add_wall(0fx,750fx,220fx,1280fx)
pewpew.add_wall(220fx,1280fx,750fx,1500fx)
pewpew.add_wall(750fx,1500fx,1280fx,1280fx)
pewpew.add_wall(1500fx,750fx,1280fx,1280fx)

local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_15, cannon = pewpew.CannonType.TRIPLE}
local player = player_helpers.new_player_ship(width / 2fx, height / 2fx, 0)
pewpew.configure_player(0, {camera_distance = 0fx, shield = 5})
pewpew.configure_player_ship_weapon(player, weapon_config)

local stime = 0

local function random_position()
    return fmath.random_fixedpoint(221fx, width-221fx), fmath.random_fixedpoint(221fx, height-221fx)
end

local function shielding_inertiac(x,y,acceleration,angle,shield_boxes)
   local timer = 0
   local inertiac = pewpew.new_inertiac(x,y,acceleration,angle)
   pewpew.add_arrow_to_player_ship(player, inertiac, 0xffff0055)
   pewpew.add_update_callback(function()
      if not pewpew.entity_get_is_alive(inertiac) then
         timer = timer + 1
         if timer == 1 and pewpew.entity_get_is_alive(player) then
            for i = 1, shield_boxes do
            local rx, ry = random_position()
            shield_box.new(rx,ry)
         end
         end
      end
   end)
end

local function timed_inertiac(x,y,acceleration,angle,time)
   local timer = 0
   local inertiac = pewpew.new_inertiac(x,y,acceleration,angle)
   pewpew.add_arrow_to_player_ship(player, inertiac, 0x0000ff55)
   pewpew.add_update_callback(function()
      if pewpew.entity_get_is_alive(inertiac) then
         timer = timer + 1
         local ix, iy = pewpew.entity_get_position(inertiac)
         if timer % time == 0 then
            pewpew.entity_destroy(inertiac)
            pewpew.create_explosion(ix,iy,0xf5c85dff,5fx,100)
         end
      end
   end)
end

local function damaging_inertiac(x,y,acceleration,angle,time,damage,nrdamage)
   local timer = 0
   local cnrdamage = 0
   local t = 0
   local inertiac = pewpew.new_inertiac(x,y,acceleration,angle)
   pewpew.add_arrow_to_player_ship(player, inertiac, 0xff0000ff)
   pewpew.add_update_callback(function()
      if pewpew.entity_get_is_alive(inertiac) then
         timer = timer + 1
         if timer % time == 0 and pewpew.entity_get_is_alive(player) then
            cnrdamage = cnrdamage + 1
           pewpew.add_damage_to_player_ship(player, damage)
         end
         if cnrdamage == nrdamage then
            local ix, iy = pewpew.entity_get_position(inertiac)
            t = t + 1
            if t == 1 then
            pewpew.entity_destroy(inertiac)
            pewpew.create_explosion(ix,iy,0xf5c85dff,5fx,100)
            end
         end
      end
   end)
end

local function powering_inertiac(x,y,acceleration,angle,powerup_boxes,random_pos,type)
   if random_pos == true or random_pos == false then 
     local timer = 0
     local inertiac = pewpew.new_inertiac(x,y,acceleration,angle)
     pewpew.add_arrow_to_player_ship(player, inertiac, 0xffffffaa)
     pewpew.add_update_callback(function()
      if pewpew.entity_get_is_alive(inertiac) then
         inx,iny = pewpew.entity_get_position(inertiac)
      end
       if not pewpew.entity_get_is_alive(inertiac) then
          timer = timer + 1
          if timer == 1 then
             for i = 1, powerup_boxes do
                if random_pos == true and pewpew.entity_get_is_alive(player) then
                   local rx, ry = random_position()
                   cannon_box.new(rx, ry, type)
                elseif random_pos == false and pewpew.entity_get_is_alive(player) then
                   cannon_box.new(x, y, type)
                end
             end
          end
       end
    end)
   else
      pewpew.print("random_pos should be either true or false")
   end
end

local timet = 120

local time = 0
pewpew.add_update_callback(
    function()
      if pewpew.entity_get_is_alive(player) then
      time = time + 1
      local move_angle, move_distance, shoot_angle, shoot_distance = pewpew.get_player_inputs(0)
      if shoot_distance > 0fx and pewpew.entity_get_is_alive(player) then
         local px, py = pewpew.entity_get_position(player)
         pewpew.new_player_bullet(px,py,shoot_angle,0)
      end
      if time % 500 == 0 then
         local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
         shielding_inertiac(375fx,750fx,1fx,RandomAngle,1)
         local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
         timed_inertiac(1500fx-375fx,750fx,1.2048fx,RandomAngle,500)
         local score = pewpew.get_score_of_player(0)
         if score > 30000 then
         local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
         damaging_inertiac(750fx,1500fx-375fx,1.3000fx,RandomAngle,450,1,1)
         end
      end
      if timet <= 0 or time % timet == 0 then
         local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
         pewpew.new_inertiac(1fx,750fx,1fx,RandomAngle)
         local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
         pewpew.new_inertiac(220fx,221fx,1fx,RandomAngle)
         local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
         pewpew.new_inertiac(750fx,1fx,1fx,RandomAngle)
         local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
         pewpew.new_inertiac(1280fx,1279fx,1fx,RandomAngle)
         local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
         pewpew.new_inertiac(1280fx,221fx,1fx,RandomAngle)
         local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
         pewpew.new_inertiac(220fx,1279fx,1fx,RandomAngle)
         local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
         pewpew.new_inertiac(750fx,1499fx,1fx,RandomAngle)
         local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
         pewpew.new_inertiac(1499fx,750fx,1fx,RandomAngle)
         timet = timet - 2
      end
      if time % 1500 == 0 then
         timet = timet + 20
      end
      if time % 1000 == 0 then
         pewpew.new_bomb(750fx,750fx,1)
      end
      local score = pewpew.get_score_of_player(0)
      if score > 10000 then
         stime = stime + 1
         if stime == 1 then
             player_turret(750fx,750fx,2)
         end
      end
      if time % 500 == 0 then 
         local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
         powering_inertiac(750fx,375fx,1.2048fx,RandomAngle,2,true,2)
      end
      if time % 1500 == 0 then
         local x, y = random_position()
         player_turret(x,y,2)
      end
      local chance = fmath.random_int(100,2000)
      if chance == 1000 then
         local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
         local x, y = random_position()
         damaging_inertiac(x,y,3fx,RandomAngle,150,0,9999)
      end
   else
      pewpew.stop_game()
   end
end)
