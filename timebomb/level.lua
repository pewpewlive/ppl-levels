local angle_helpers = require("/dynamic/helpers/angle_helpers.lua")
local player_helpers = require("/dynamic/helpers/player_helpers.lua")
local floating_message = require("/dynamic/helpers/floating_message.lua")
local shield_box = require("/dynamic/helpers/boxes/shield_box.lua")
local cannon_box = require("/dynamic/helpers/boxes/cannon_box.lua")
local box = require("/dynamic/timebomb.lua")
local enemy = require("/dynamic/turret.lua")

local width = 1250fx
local height = 1250fx
pewpew.set_level_size(width, height)

rollingspheres={}

local background = pewpew.new_customizable_entity(-1000fx, -1000fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/bg.lua", 0)

local bg = pewpew.new_customizable_entity(-1000fx, -1000fx)
pewpew.customizable_entity_set_mesh(bg, "/dynamic/bg2.lua", 0)

local bg = pewpew.new_customizable_entity(-1000fx, -1000fx)
pewpew.customizable_entity_set_mesh(bg, "/dynamic/bg2.lua", 0)

local bg2 = pewpew.new_customizable_entity(-1000fx, -1000fx)
pewpew.customizable_entity_set_mesh(bg2, "/dynamic/bg3.lua", 0)

local bg3 = pewpew.new_customizable_entity(-1000fx, -1000fx)
pewpew.customizable_entity_set_mesh(bg3, "/dynamic/bg4.lua", 0)

local bg4 = pewpew.new_customizable_entity(-1000fx, -1000fx)
pewpew.customizable_entity_set_mesh(bg4, "/dynamic/bg5.lua", 0)

local bg5 = pewpew.new_customizable_entity(-1000fx, -1000fx)
pewpew.customizable_entity_set_mesh(bg5, "/dynamic/bg6.lua", 0)

local background2 = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background2, "/dynamic/outline.lua", 0)

local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_30, cannon = pewpew.CannonType.DOUBLE_SWIPE}
local player = player_helpers.new_player_ship(width / 2fx, height / 2fx, 0)
pewpew.configure_player(0, {camera_distance = 0fx, shield = 5})
pewpew.configure_player_ship_weapon(player, weapon_config)

local function random_position()
    return fmath.random_fixedpoint(10fx, width-10fx), fmath.random_fixedpoint(10fx, height-10fx)
end

entity_count = {}

local baf = 1

local nr_ast = 5

local stimer = 200

local timer = -1
pewpew.add_update_callback(
    function()
      timer = timer + 1
      local conf = pewpew.get_player_configuration(0)
      if conf["has_lost"] == true then
         pewpew.stop_game()
      end
      if timer % 300 == 0 then
        local x,y = random_position()
        timebomb(x,y)
      end
      if timer % 500 == 0 then
        local x,y = random_position()
        turret(x,y)
      end
      local score = pewpew.get_score_of_player(0)
      if timer % 125 == 0 and score < 2500 then
      local x,y = random_position()
        pewpew.new_asteroid(x,y)
      end
      local score = pewpew.get_score_of_player(0)
      if timer % 125 == 0 and score > 2500 and score < 10000 then
        local x,y = random_position()
        pewpew.new_asteroid(x,y)
        local x,y = random_position()
        pewpew.new_wary(x,y)
      end
      local score = pewpew.get_score_of_player(0)
      if timer % 75 == 0 and score > 10000 then
        local x,y = random_position()
        pewpew.new_asteroid(x,y)
        local x,y = random_position()
        pewpew.new_wary(x,y)
      end
      if timer % 250 == 0 then
        local m_type = fmath.random_int(1,5)
        local x,y = random_position()
        local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
        local score = pewpew.get_score_of_player(0)
        if m_type == 1 then
            pewpew.new_mothership(x, y, pewpew.MothershipType.THREE_CORNERS, RandomAngle)
        elseif m_type == 2 then
            pewpew.new_mothership(x, y, pewpew.MothershipType.FIVE_CORNERS, RandomAngle)
        elseif m_type == 3 then
            pewpew.new_mothership(x, y, pewpew.MothershipType.SIX_CORNERS, RandomAngle)
        elseif m_type == 4 then
            pewpew.new_mothership(x, y, pewpew.MothershipType.SEVEN_CORNERS, RandomAngle)        
        elseif m_type == 5 and score > 15000 then
            pewpew.new_mothership(x, y, pewpew.MothershipType.FOUR_CORNERS, RandomAngle)
        end
    end
    local is_inertiac = fmath.random_int(0,5)
        if is_inertiac == 5 and timer % 50 == 0 then
            local x,y = random_position()
            local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
            pewpew.new_inertiac(x,y, 1fx, RandomAngle)
        end
        if timer % 500 == 0 then
            local x,y = random_position()
            shield_box.new(x, y ,weapon_config)
        end
        local is_cube = fmath.random_int(0,5)
        if is_cube == 5 and timer % 50 == 0 then
            for i = 1, 10 do
            local x,y = random_position()
            pewpew.new_rolling_cube(x,y)
            end
        end
        if timer % 250 == 0 then
            for i = 1, baf do
                local x,y = random_position()
                local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
                pewpew.new_baf(x,y,RandomAngle,5fx,-1)
            end
            local rn = fmath.random_int(0,10)
            baf = baf + rn
        end
        if timer % 1000 == 0 then
            for i = 1, nr_ast do
                local x,y = random_position()
                pewpew.new_asteroid(x,y)
            end
            local rn = fmath.random_int(0,5)
            nr_ast = nr_ast + rn
        end
        local score = pewpew.get_score_of_player(0)
        if timer % 200 == 0 then
            local x,y = random_position()
            local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
            table.insert(rollingspheres, pewpew.new_rolling_sphere(x,y, RandomAngle, 5fx))
        end
        local score = pewpew.get_score_of_player(0)
        if timer % 2000 == 5 and score ~= 0 then
        local px, py=pewpew.entity_get_position(player)
        pewpew.new_bomb(px,py,2)
        nr_ast = nr_ast - 20
        baf = baf - 25
        end
        if timer % 2000 == 95 and timer > 100 then
            for i=1,#rollingspheres do
                local x,y = random_position()
                local RandomAngle = fmath.random_fixedpoint(0fx,fmath.tau())
                pewpew.new_rolling_sphere(x,y, RandomAngle, 5fx)
            end
        end
        if timer % 1000 == 0 then
            local x,y = random_position()
            local ufo = pewpew.new_ufo(x,y,5fx)
            pewpew.ufo_set_enable_collisions_with_walls(ufo, true)
        end
    end
)

