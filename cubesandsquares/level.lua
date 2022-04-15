local angle_helpers = require("/dynamic/helpers/angle_helpers.lua")
local player_helpers = require("/dynamic/helpers/player_helpers.lua")
local floating_message = require("/dynamic/helpers/floating_message.lua")
local shield_box = require("/dynamic/helpers/boxes/shield_box.lua")
local cannon_box = require("/dynamic/helpers/boxes/cannon_box.lua")

local width = 1500fx
local height = 1500fx
pewpew.set_level_size(width, height)

local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/outline.lua", 0)

local bg = pewpew.new_customizable_entity(700fx, 700fx)
pewpew.customizable_entity_set_mesh(bg, "/dynamic/bg.lua", 0)

local bg2 = pewpew.new_customizable_entity(650fx, 650fx)
pewpew.customizable_entity_set_mesh(bg2, "/dynamic/bg.lua", 1)

local bg3 = pewpew.new_customizable_entity(600fx, 600fx)
pewpew.customizable_entity_set_mesh(bg3, "/dynamic/bg.lua", 2)

local bg4 = pewpew.new_customizable_entity(550fx, 550fx)
pewpew.customizable_entity_set_mesh(bg4, "/dynamic/bg.lua", 3)

local bg5 = pewpew.new_customizable_entity(500fx, 500fx)
pewpew.customizable_entity_set_mesh(bg5, "/dynamic/bg.lua", 4)

local bg6 = pewpew.new_customizable_entity(450fx, 450fx)
pewpew.customizable_entity_set_mesh(bg6, "/dynamic/bg.lua", 5)

local bg7 = pewpew.new_customizable_entity(400fx, 400fx)
pewpew.customizable_entity_set_mesh(bg7, "/dynamic/bg.lua", 6)

local bg8 = pewpew.new_customizable_entity(350fx, 350fx)
pewpew.customizable_entity_set_mesh(bg8, "/dynamic/bg.lua", 7)

local bg9 = pewpew.new_customizable_entity(300fx, 300fx)
pewpew.customizable_entity_set_mesh(bg9, "/dynamic/bg.lua", 8)

local bg10 = pewpew.new_customizable_entity(250fx, 250fx)
pewpew.customizable_entity_set_mesh(bg10, "/dynamic/bg.lua", 9)

local bg11 = pewpew.new_customizable_entity(200fx, 200fx)
pewpew.customizable_entity_set_mesh(bg11, "/dynamic/bg.lua", 10)

local bg12 = pewpew.new_customizable_entity(150fx, 150fx)
pewpew.customizable_entity_set_mesh(bg12, "/dynamic/bg.lua", 11)

local bg13 = pewpew.new_customizable_entity(100fx, 100fx)
pewpew.customizable_entity_set_mesh(bg13, "/dynamic/bg.lua", 12)

local bg14 = pewpew.new_customizable_entity(50fx, 50fx)
pewpew.customizable_entity_set_mesh(bg14, "/dynamic/bg.lua", 13)

local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_30, cannon = pewpew.CannonType.DOUBLE}
local player = player_helpers.new_player_ship(width / 2fx, height / 2fx, 0)
pewpew.configure_player(0, {camera_distance = 0fx, shield = 5})
pewpew.configure_player_ship_weapon(player, weapon_config)

local function random_position()
    return fmath.random_fixedpoint(10fx, width-10fx), fmath.random_fixedpoint(10fx, height-10fx)
end


local time = 0
pewpew.add_update_callback(
    function()
      time = time + 1
      local conf = pewpew.get_player_configuration(0)
      if conf["has_lost"] == true then
         pewpew.stop_game()
      end
      local score = pewpew.get_score_of_player(0)
      pewpew.increase_score_of_player(0, 1)
      if time < 500 and time % 90 == 0 then
        pewpew.new_rolling_cube(random_position())
     end
     if time > 500 and time < 1000 and time % 60 == 0 then 
        pewpew.new_rolling_cube(random_position())
     end
     if time > 1000 and time < 1500 and time % 30 == 0 then 
        pewpew.new_rolling_cube(random_position())
     end     
     if time > 1500 and time < 2500 and time % 15 == 0 then 
        pewpew.new_rolling_cube(random_position())
     end
     local score = pewpew.get_score_of_player(0)
     if time > 2500 and score < 40250 and time % 20 == 0 then 
        pewpew.new_rolling_cube(random_position())
     end
     local score = pewpew.get_score_of_player(0)
     if time > 250 and time % 250 == 0 and score < 15000 then
        local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
        local x,y = random_position()
        pewpew.new_mothership(x, y, pewpew.MothershipType.FOUR_CORNERS, RandomAngle)
     end
     local score = pewpew.get_score_of_player(0)
     if time % 500 == 0 then
        local x,y = random_position()
        shield_box.new(x, y ,weapon_config)
     end
     if score > 7500 and time % 500 == 0 then
      local x,y = random_position()
        pewpew.new_bomb(x, y, 1)
     end
     if time < 2000 and time % 250 == 0 then
      pewpew.new_rolling_cube(1500fx, 1500fx)
      pewpew.new_rolling_cube(1500fx, 1500fx)
      pewpew.new_rolling_cube(1500fx, 0fx)
      pewpew.new_rolling_cube(1500fx, 0fx)
      pewpew.new_rolling_cube(0fx, 1500fx)
      pewpew.new_rolling_cube(0fx, 1500fx)
      pewpew.new_rolling_cube(0fx, 0fx)
      pewpew.new_rolling_cube(0fx, 0fx)
      pewpew.new_rolling_cube(1500fx, 1500fx)
      pewpew.new_rolling_cube(1500fx, 1500fx)
      pewpew.new_rolling_cube(1500fx, 0fx)
      pewpew.new_rolling_cube(1500fx, 0fx)
      pewpew.new_rolling_cube(0fx, 1500fx)
      pewpew.new_rolling_cube(0fx, 1500fx)
      pewpew.new_rolling_cube(0fx, 0fx)
      pewpew.new_rolling_cube(0fx, 0fx)
     end
     if time > 2000 and time % 250 == 0 then
      pewpew.new_rolling_cube(1500fx, 1500fx)
      pewpew.new_rolling_cube(1500fx, 1500fx)
      pewpew.new_rolling_cube(1500fx, 0fx)
      pewpew.new_rolling_cube(1500fx, 0fx)
      pewpew.new_rolling_cube(0fx, 1500fx)
      pewpew.new_rolling_cube(0fx, 1500fx)
      pewpew.new_rolling_cube(0fx, 0fx)
      pewpew.new_rolling_cube(0fx, 0fx)
     end
     local score = pewpew.get_score_of_player(0)
     if score > 7500 and score < 17500 and time % 1000 == 0 then
      local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
      pewpew.new_inertiac(1500fx, 1500fx, 1fx, RandomAngle)
      pewpew.new_inertiac(1500fx, 0fx, 1fx, RandomAngle)
      pewpew.new_inertiac(0fx, 1500fx, 1fx, RandomAngle)
      pewpew.new_inertiac(0fx, 0fx, 1fx, RandomAngle)
     end
     local score = pewpew.get_score_of_player(0)
     if score > 15000 and time % 120 == 0 then        
      local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
      local x,y = random_position()
      pewpew.new_mothership(x, y, pewpew.MothershipType.FOUR_CORNERS, RandomAngle)
     end
     if score > 17500 and score < 35000 and time % 750 == 0 then
      local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
      pewpew.new_inertiac(1500fx, 1500fx, 1fx, RandomAngle)
      pewpew.new_inertiac(1500fx, 0fx, 1fx, RandomAngle)
      pewpew.new_inertiac(0fx, 1500fx, 1fx, RandomAngle)
      pewpew.new_inertiac(0fx, 0fx, 1fx, RandomAngle)
     end
     local score = pewpew.get_score_of_player(0)
     if score > 30000 and time % 60 == 0 then        
      local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
      local x,y = random_position()
      pewpew.new_mothership(x, y, pewpew.MothershipType.FOUR_CORNERS, RandomAngle)
     end
     local score = pewpew.get_score_of_player(0)
     if score > 35000 and score < 40000 and time % 500 == 0 then
      local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
      pewpew.new_inertiac(1500fx, 1500fx, 1fx, RandomAngle)
      pewpew.new_inertiac(1500fx, 0fx, 1fx, RandomAngle)
      pewpew.new_inertiac(0fx, 1500fx, 1fx, RandomAngle)
      pewpew.new_inertiac(0fx, 0fx, 1fx, RandomAngle)
     end
     local score = pewpew.get_score_of_player(0)
     if score > 40000 and score < 40250 and time % 2 == 0 then
      pewpew.new_rolling_cube(random_position())
     end
     local score = pewpew.get_score_of_player(0)
     if score > 45000 and time % 10 == 0 then
      pewpew.new_rolling_cube(random_position())
     end
     local score = pewpew.get_score_of_player(0)
     if score > 50000 and time % 250 == 0 then
      local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
      local x,y = random_position()
      pewpew.new_rolling_sphere(x, y, RandomAngle, 2fx)
     end
     local score = pewpew.get_score_of_player(0)
     if score > 45000 and time % 500 == 0 then
      local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
      pewpew.new_inertiac(1500fx, 1500fx, 1fx, RandomAngle)
      pewpew.new_inertiac(1500fx, 0fx, 1fx, RandomAngle)
      pewpew.new_inertiac(0fx, 1500fx, 1fx, RandomAngle)
      pewpew.new_inertiac(0fx, 0fx, 1fx, RandomAngle)
     end
    end)