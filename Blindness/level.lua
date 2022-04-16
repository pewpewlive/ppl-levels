local player_helper = require("/dynamic/helpers/player_helpers.lua")
local angle_helpers = require("/dynamic/helpers/angle_helpers.lua")
local floating_message = require("/dynamic/helpers/floating_message.lua")
local shield_box = require("/dynamic/helpers/boxes/shield_box.lua")
local cannon_box = require("/dynamic/helpers/boxes/cannon_box.lua")
local blindness_boxes = require("/dynamic/blindness_boxes/blindness_boxes.lua")
local set = require("/dynamic/timeout_helper.lua")


local height = 1000fx
local width = 750fx
pewpew.set_level_size(width, height)

local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.DOUBLE}
local player = player_helper.new_player_ship( 375fx, 150fx, 0)
pewpew.configure_player(0, {camera_distance = 650fx, shield = 2})
pewpew.configure_player_ship_weapon(player, weapon_config)
local function random_position()
    return fmath.random_fixedpoint(10fx, width-10fx), fmath.random_fixedpoint(10fx, height-10fx)
end
local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/outline.lua", 0)
local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/outline.lua", 1)
local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/outline.lua", 2)
local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/outline.lua", 3)
local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/outline.lua", 4)
local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/outline.lua", 5)
local background = pewpew.new_customizable_entity(-220fx, -220fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/background.lua", 0)
local dots_background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(dots_background, "/dynamic/cage_graphics.lua", 0)

pewpew.add_wall(335fx, 400fx, 415fx, 400fx)
pewpew.add_wall(275fx, 460fx, 275fx, 540fx)
pewpew.add_wall(480fx, 460fx, 480fx, 540fx)
pewpew.add_wall(335fx, 600fx, 415fx, 600fx)

local text = pewpew.new_customizable_entity(375fx, 1085fx)
pewpew.customizable_entity_set_string(text, "#ffffff05April fools? More like Blind fools!")
local text2 = pewpew.new_customizable_entity(378fx, 1087fx)
pewpew.customizable_entity_set_string(text2, "#ffffff04April fools? More like Blind fools!")
local text3 = pewpew.new_customizable_entity(372fx, 1083fx)
pewpew.customizable_entity_set_string(text3, "#ffffff03April fools? More like Blind fools!")


local function toRad(x)
  return x * (22fx/7fx) / 180fx
end
  
local function toDeg(x)
  return x * 180fx / (22fx/7fx)
end

local function random_position()
  return fmath.random_fixedpoint(10fx, width-10fx), fmath.random_fixedpoint(10fx, height-10fx)
end
local angle = fmath.random_fixedpoint(0fx,fmath.tau())
local rx, ry = random_position()
local shield = shield_box.new(375fx, 500fx, weapon_config)
local time = 0
pewpew.add_update_callback(
    function()
      time = time + 1
      local conf = pewpew.get_player_configuration(0)
      if conf["has_lost"] == true then
        pewpew.stop_game()
      end
      if time > 150 and time < 1150 and time % 295 == 0 then 
        pewpew.new_wary(random_position())
      end
      if time > 1150 and time < 2150 and time % 245 == 0 then 
        pewpew.new_wary(random_position())
      end
      if time > 2150 and time % 225 == 0 then 
        pewpew.new_wary(random_position())
      end
      if time > 250 and time < 1250 and time % 470 == 0 then 
        pewpew.new_asteroid(random_position())
      end  
      if time > 1250 and time < 2250 and time % 425 == 0 then 
        pewpew.new_asteroid(random_position())
      end  
      if time > 2250 and time % 380 == 0 then 
        pewpew.new_asteroid(random_position())
      end  
      if time > 450 and time % 700 == 0 then 
        pewpew.new_rolling_sphere(fmath.random_fixedpoint(25fx,725fx),fmath.random_fixedpoint(25fx,100fx), fmath.random_fixedpoint(0fx,fmath.tau()), 3fx)
        pewpew.new_rolling_sphere(fmath.random_fixedpoint(25fx,725fx),fmath.random_fixedpoint(900fx,975fx), fmath.random_fixedpoint(0fx,fmath.tau()), 3fx)
      end   
      if time > 300 and time < 1300 and time % 400 == 0 then 
        pewpew.new_mothership(rx, ry, pewpew.MothershipType.FIVE_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
      end
      if time > 1300 and time < 2300 and time % 355 == 0 then 
        pewpew.new_mothership(rx, ry, pewpew.MothershipType.FIVE_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
      end
      if time > 2300 and time % 305 == 0 then 
        pewpew.new_mothership(rx, ry, pewpew.MothershipType.FIVE_CORNERS, fmath.random_fixedpoint(0fx,fmath.tau()))
      end
      if time > 300 and time < 1700 % 650 == 0 then 
        pewpew.new_crowder(1fx, 1fx)
        pewpew.new_crowder(1fx, 1fx)
        pewpew.new_crowder(749fx, 1fx)
        pewpew.new_crowder(749fx, 1fx)
        pewpew.new_crowder(749fx, 999fx)
        pewpew.new_crowder(749fx, 999fx)
        pewpew.new_crowder(1fx, 999fx)
        pewpew.new_crowder(1fx, 999fx)
      end
      if time > 1700 and time < 3100 and time % 645 == 0 then 
        pewpew.new_crowder(1fx, 1fx)
        pewpew.new_crowder(1fx, 1fx)
        pewpew.new_crowder(1fx, 1fx)
        pewpew.new_crowder(749fx, 1fx)
        pewpew.new_crowder(749fx, 1fx)
        pewpew.new_crowder(749fx, 1fx)
        pewpew.new_crowder(749fx, 999fx)
        pewpew.new_crowder(749fx, 999fx)
        pewpew.new_crowder(749fx, 999fx)
        pewpew.new_crowder(1fx, 999fx)
        pewpew.new_crowder(1fx, 999fx)
        pewpew.new_crowder(1fx, 999fx)
      end
      if time > 3100 and time % 645 == 0 then 
        pewpew.new_crowder(1fx, 1fx)
        pewpew.new_crowder(1fx, 1fx)
        pewpew.new_crowder(1fx, 1fx)
        pewpew.new_crowder(1fx, 1fx)
        pewpew.new_crowder(749fx, 1fx)
        pewpew.new_crowder(749fx, 1fx)
        pewpew.new_crowder(749fx, 1fx)
        pewpew.new_crowder(749fx, 1fx)
        pewpew.new_crowder(749fx, 999fx)
        pewpew.new_crowder(749fx, 999fx)
        pewpew.new_crowder(749fx, 999fx)
        pewpew.new_crowder(749fx, 999fx)
        pewpew.new_crowder(1fx, 999fx)
        pewpew.new_crowder(1fx, 999fx)
        pewpew.new_crowder(1fx, 999fx)
        pewpew.new_crowder(1fx, 999fx)
      end
      if time > 200 and time % 600 == 0 then
        shield_box.new(375fx, 500fx, weapon_config)
      end
      if time > 650 and time % 1200 == 0 then
        cannon_box.new(fmath.random_fixedpoint(10fx, 740fx), fmath.random_fixedpoint(10fx, 990fx), fmath.random_int(3, 3))
      end
      if time > 600 and time % 675 == 0 then
        -- arguments (in order): x, y, expiration (in ticks), ship id, callback function
       blindness_boxes.create_box(fmath.random_fixedpoint(10fx, 740fx), fmath.random_fixedpoint(10fx, 990fx), 350, player, function(player_index, ship_id)
         pewpew.configure_player(player_index, {camera_distance = 300fx})
      -- arguments (in order): duration of powerup, callback function
         set.timeout(200, function()
           pewpew.configure_player(player_index, {camera_distance = 650fx})
  end)
end)
        
      end
      if time % 30 == 0 then
        local x, y = pewpew.entity_get_position(player)
        pewpew.print(x .. " , " .. y)
       end 
    end)