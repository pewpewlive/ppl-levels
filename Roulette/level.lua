local gameplay = require("/dynamic/gameplay.lua")
local player_helpers = require("/dynamic/helpers/player_helpers.lua")
local revolver = require("/dynamic/revolver_code.lua")
local floating_message = require("/dynamic/helpers/floating_message.lua")
local width = 750fx
local height = 600fx
pewpew.set_level_size(width, height)

local ship = player_helpers.new_player_ship(width / 2fx, height / 2fx, 0)
pewpew.configure_player(0, {camera_distance = 50fx, shield = 400, move_joystick_color = 0x0000ffff, shoot_joystick_color = 0x0000ffff})
pewpew.configure_player_ship_weapon(ship, {frequency = pewpew.CannonFrequency.FREQ_15, cannon = pewpew.CannonType.TIC_TOC})

local background = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 0)
local background2 = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(background2, "/dynamic/test_bg.lua", 1)
local background3 = pewpew.new_customizable_entity(width / 2fx, height / 2fx)

local yellow_ = pewpew.new_customizable_entity(width / 2fx, -height - height /2fx)

local background4 = pewpew.new_customizable_entity(width / 2fx, height / 2fx)

local positions = {                         {375fx,120fx},
                    {120fx,300fx},                               {630fx,300fx},
                                            {375fx,480fx}}

local function random_valid_positions()
  local index = fmath.random_int(1, #positions)
  return positions[index][1], positions[index][2]
end

--[[
    How Roulette works:

    It will cycle in 6 different level themes like:
    1. blue theme
    2. red theme
    3. green theme

    4. pink theme
    5. yellow theme
    6. cyan theme

    Each theme has different gameplay, with each full cycle getting considerably harder

    The themes will cycle every 30 or 60 seconds, i havent decided yet

    Ideas for each theme:

    Blue theme could have:
    1.waries
    2.dart
    3.blue bafs

    Red theme could have:
    1.rolling spheres
    2.red motherships
    3.red bafs

    Green theme could have:
    1.green motherships
    2.green rps
    3.green bafs

    Pink theme could have:
    1.pink motherships
    2.waries
    3.quadros

    Yellow theme could have:
    1.orange motherships
    2.rolling cubes
    3.spinies
    
    Cyan theme could have:
    1.cyan motherships
    2.iceball
    3.blue bafs
]]

gameplay.activate(ship)


local counter = 0
local blue_theme = true
local red_theme = false
local green_theme = false
local pink_theme = false
local yellow_theme = false
local cyan_theme = false

local true_ = true
local once = true
local PLEASE = true
function level_tick()
    counter = counter + 1
    local conf = pewpew.get_player_configuration(0)
    if conf["has_lost"] then
	    pewpew.stop_game()
    end
    if counter >= 900 and blue_theme then
        if counter < 935 then
            if once then 
                px, py = pewpew.entity_get_position(ship)
                rx, ry = random_valid_positions()
                once = false
            end
            pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 6)
            pewpew.configure_player_ship_weapon(ship, {frequency = pewpew.CannonFrequency.FREQ_15, cannon = pewpew.CannonType.TIC_TOC})
            pewpew.configure_player(0, {camera_x_override = width/2fx, camera_y_override = 25500fx})
            pewpew.entity_set_position(ship, px, py)
            if true_ then
                revolver.new()
                true_ = false
            end
        else
            pewpew.entity_set_position(ship, rx, ry)
            pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 1)
            pewpew.configure_player(0, {move_joystick_color = 0xff0000ff, shoot_joystick_color = 0xff0000ff})
            w1 = pewpew.add_wall(225fx,375fx,525fx,375fx)
            w2 = pewpew.add_wall(525fx,375fx,525fx,225fx)
            w3 = pewpew.add_wall(225fx,225fx,525fx,225fx)
            w4 = pewpew.add_wall(225fx,375fx,225fx,225fx)
            pewpew.customizable_entity_set_mesh(background4, "/dynamic/blue_walls.lua", 1)
            pewpew.remove_wall(h1)
            pewpew.remove_wall(h2)
            pewpew.remove_wall(h3)
            pewpew.remove_wall(h4)
            pewpew.remove_wall(h5)
            pewpew.remove_wall(h6)
            blue_theme = false
            red_theme = true
            counter = 0
            once = true
        end
    end
    if counter > 900 and red_theme then
        if counter < 935 then
            if once then 
                px, py = pewpew.entity_get_position(ship)
                once = false
            end
            pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 6)
            pewpew.configure_player_ship_weapon(ship, {frequency = pewpew.CannonFrequency.FREQ_7_5, cannon = pewpew.CannonType.SINGLE})
            pewpew.configure_player(0, {camera_x_override = width/2fx, camera_y_override = 25500fx})
            pewpew.entity_set_position(ship, px, py)
        else
            pewpew.entity_set_position(ship, px, py)
            pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 2)
            pewpew.configure_player(0, {move_joystick_color = 0x00ff00ff, shoot_joystick_color = 0x00ff00ff})
            if PLEASE then
                pewpew.remove_wall(w1)
                pewpew.remove_wall(w2)
                pewpew.remove_wall(w3)
                pewpew.remove_wall(w4)
                PLEASE = false
            end
            red_theme = false
            green_theme = true
            pewpew.customizable_entity_set_mesh(background2, "/dynamic/test_bg.lua", 0)
            counter = 0
            once = true
        end
    end
    if counter > 900 and green_theme then
        if counter < 935 then
            if once then 
                px, py = pewpew.entity_get_position(ship)
                once = false
            end
            pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 6)
            pewpew.configure_player_ship_weapon(ship, {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.TRIPLE})
            pewpew.configure_player(0, {camera_x_override = width/2fx, camera_y_override = 25500fx})
            pewpew.entity_set_position(ship, px, py)
        else
            pewpew.entity_set_position(ship, 375fx,300fx)
            pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 3)
            pewpew.customizable_entity_set_mesh(background2, "/dynamic/test_bg.lua", 1)
            pewpew.configure_player(0, {move_joystick_color = 0xff00ffff, shoot_joystick_color = 0xff00ffff})
            green_theme = false
            t = pewpew.add_wall(150fx,450fx,200fx,450fx)
            t2 = pewpew.add_wall(200fx,450fx,200fx,400fx)
            t3 = pewpew.add_wall(200fx,400fx,150fx,400fx)
            t4 = pewpew.add_wall(150fx,400fx,150fx,450fx)
    
            t5 = pewpew.add_wall(200fx,400fx,200fx,350fx)
            t6 = pewpew.add_wall(200fx,350fx,250fx,350fx)
            t7 = pewpew.add_wall(250fx,350fx,250fx,400fx)
            t8 = pewpew.add_wall(250fx,400fx,200fx,400fx)
    
    
            t9 = pewpew.add_wall(600fx,450fx,550fx,450fx)
            t10 = pewpew.add_wall(550fx,450fx,550fx,400fx)
            t11 = pewpew.add_wall(550fx,400fx,600fx,400fx)
            t12 = pewpew.add_wall(600fx,400fx,600fx,450fx)
    
            t13 = pewpew.add_wall(550fx,400fx,550fx,350fx)
            t14 = pewpew.add_wall(550fx,350fx,500fx,350fx)
            t15 = pewpew.add_wall(500fx,350fx,500fx,400fx)
            t16 = pewpew.add_wall(500fx,400fx,550fx,400fx)
    
    
            t17 = pewpew.add_wall(600fx,150fx,550fx,150fx)
            t18 = pewpew.add_wall(550fx,150fx,550fx,200fx)
            t19 = pewpew.add_wall(550fx,200fx,600fx,200fx)
            t20 = pewpew.add_wall(600fx,200fx,600fx,150fx)
    
            t21 = pewpew.add_wall(550fx,200fx,550fx,250fx)
            t22 = pewpew.add_wall(550fx,250fx,500fx,250fx)
            t23 = pewpew.add_wall(500fx,250fx,500fx,200fx)
            t24 = pewpew.add_wall(500fx,200fx,550fx,200fx)
    
    
            t25 = pewpew.add_wall(150fx,150fx,200fx,150fx)
            t26 = pewpew.add_wall(200fx,150fx,200fx,200fx)
            t27 = pewpew.add_wall(200fx,200fx,150fx,200fx)
            t28 = pewpew.add_wall(150fx,200fx,150fx,150fx)
    
            t29 = pewpew.add_wall(200fx,200fx,200fx,250fx)
            t30 = pewpew.add_wall(200fx,250fx,250fx,250fx)
            t31 = pewpew.add_wall(250fx,250fx,250fx,200fx)
            t32 = pewpew.add_wall(250fx,200fx,200fx,200fx)
            pink_theme = true
            counter = 0 
            once = true
            PLEASE = true
        end
    end
    if counter > 900 and pink_theme then
        if counter < 935 then
            if once then 
                px, py = pewpew.entity_get_position(ship)
                once = false
            end
            pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 6)
            pewpew.configure_player_ship_weapon(ship, {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.FOUR_DIRECTIONS})
            pewpew.configure_player(0, {camera_x_override = width/2fx, camera_y_override = 25500fx})
            pewpew.entity_set_position(ship, px, py)
        else
            pewpew.entity_set_position(ship, px, py)
            pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 4)
            pewpew.configure_player(0, {move_joystick_color = 0xffff00ff, shoot_joystick_color = 0xffff00ff})
            pewpew.remove_wall(t)
            pewpew.remove_wall(t2)
            pewpew.remove_wall(t3)
            pewpew.remove_wall(t4)
            pewpew.remove_wall(t5)
            pewpew.remove_wall(t5)
            pewpew.remove_wall(t6)
            pewpew.remove_wall(t7)
            pewpew.remove_wall(t8)
            pewpew.remove_wall(t9)
            pewpew.remove_wall(t10)
            pewpew.remove_wall(t11)
            pewpew.remove_wall(t12)
            pewpew.remove_wall(t13)
            pewpew.remove_wall(t14)
            pewpew.remove_wall(t15)
            pewpew.remove_wall(t16)
            pewpew.remove_wall(t17)
            pewpew.remove_wall(t18)
            pewpew.remove_wall(t19)
            pewpew.remove_wall(t20)
            pewpew.remove_wall(t21)
            pewpew.remove_wall(t22)
            pewpew.remove_wall(t23)
            pewpew.remove_wall(t24)
            pewpew.remove_wall(t25)
            pewpew.remove_wall(t26)
            pewpew.remove_wall(t27)
            pewpew.remove_wall(t28)
            pewpew.remove_wall(t29)
            pewpew.remove_wall(t30)
            pewpew.remove_wall(t31)
            pewpew.remove_wall(t32)
            pink_theme = false
            yellow_theme = true
            counter = 0 
            once = true
        end
    end
    if counter > 900 and yellow_theme then
        if counter < 935 then
            if once then 
                px, py = pewpew.entity_get_position(ship)
                once = false
            end
            pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 6)
            pewpew.configure_player_ship_weapon(ship, {frequency = pewpew.CannonFrequency.FREQ_15, cannon = pewpew.CannonType.DOUBLE})
            pewpew.configure_player(0, {camera_x_override = width/2fx, camera_y_override = 25500fx})
            pewpew.entity_set_position(ship, px, py)
        else
            pewpew.entity_set_position(ship, width/2fx, height/2fx)
            pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 5)
            yellow_theme = false
            pewpew.configure_player(0, {move_joystick_color = 0x00ffffff, shoot_joystick_color = 0x00ffffff})
            cyan_theme = true
            counter = 0 
            once = true
        end
    end
    if counter > 900 and cyan_theme then
        if counter < 935
        then
            if once then 
                px, py = pewpew.entity_get_position(ship)
                once = false
            end
            pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 6)
            pewpew.configure_player_ship_weapon(ship, {frequency = pewpew.CannonFrequency.FREQ_15, cannon = pewpew.CannonType.TIC_TOC})
            pewpew.configure_player(0, {camera_x_override = width/2fx, camera_y_override = 25500fx})
            pewpew.entity_set_position(ship, px, py)
        else
            pewpew.entity_set_position(ship, px, py)
            pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 0)
            cyan_theme = false
            pewpew.configure_player(0, {move_joystick_color = 0x0000ffff, shoot_joystick_color = 0x0000ffff})
            blue_theme = true
            pewpew.customizable_entity_set_mesh(background4, "/dynamic/blue_walls.lua", 0)

            local conf = pewpew.get_player_configuration(0)
            pewpew.configure_player(0, {shield = conf.shield + 1})
            px, py = pewpew.entity_get_position(ship)
            local new_message = floating_message.new(px, py, "Good Job! Shield +1", 1.5fx, 0x7000ffff, 3)
            h1 = pewpew.add_wall(300fx,150fx,150fx,150fx)
            h2 = pewpew.add_wall(150fx,150fx,150fx,450fx)
            h3 = pewpew.add_wall(150fx,450fx,300fx,450fx)
            h4 = pewpew.add_wall(450fx,150fx,600fx,150fx)
            h5 = pewpew.add_wall(600fx,150fx,600fx,450fx)
            h6 = pewpew.add_wall(600fx,450fx,450fx,450fx)
            counter = 0 
            once = true
        end
    end
    if pink_theme then
        pewpew.customizable_entity_set_mesh(background3, "/dynamic/pink_theme.lua", 0)
    else
        pewpew.customizable_entity_set_mesh(background3, "/dynamic/test_bg.lua", 1)
    end
    if yellow_theme then
        pewpew.customizable_entity_add_rotation_to_mesh(yellow_, fmath.tau() / -120fx, 0fx, 1fx, 0fx)
    end
    if yellow_theme then
        pewpew.customizable_entity_set_mesh(yellow_, "/dynamic/dust.lua", 0)
    else
        pewpew.customizable_entity_set_mesh(yellow_, "/dynamic/test_bg.lua", 1)
    end
end

if blue_theme then
    pewpew.customizable_entity_set_mesh(background4, "/dynamic/blue_walls.lua", 0)

    h1 = pewpew.add_wall(300fx,150fx,150fx,150fx)
    h2 = pewpew.add_wall(150fx,150fx,150fx,450fx)
    h3 = pewpew.add_wall(150fx,450fx,300fx,450fx)
    h4 = pewpew.add_wall(450fx,150fx,600fx,150fx)
    h5 = pewpew.add_wall(600fx,150fx,600fx,450fx)
    h6 = pewpew.add_wall(600fx,450fx,450fx,450fx)
end

local function custom_backgrounds(x, y)
    local dots = pewpew.new_customizable_entity(x, y)
    local time = 0
    pewpew.entity_set_update_callback(dots, function()
        time = time + 1

        if blue_theme then
            pewpew.customizable_entity_set_mesh(dots, "/dynamic/dots.lua", 0)
        elseif yellow_theme == true then
            pewpew.customizable_entity_set_mesh(dots, "/dynamic/dots.lua", 1)
        else 
            pewpew.customizable_entity_set_mesh(dots, "/dynamic/dots.lua", 2)
        end
    end)
end

custom_backgrounds(0fx,0fx)

pewpew.add_update_callback(level_tick)