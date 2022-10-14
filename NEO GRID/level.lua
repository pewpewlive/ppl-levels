local player_helpers = require("/dynamic/helpers/player_helpers.lua")
local discos = require("/dynamic/enemies/discos/code.lua")
local gv = require("/dynamic/gv.lua")
local gh = require("/dynamic/helpers/gameplay_helper.lua")
local shield = require("/dynamic/helpers/boxes/shield_box.lua")
local floating_message = require("/dynamic/helpers/floating_message.lua")
local ch = require("/dynamic/helpers/color_helpers.lua")

local w,h = gv[1][1],gv[1][2]
pewpew.set_level_size(w,h)

--[[
    Cannon:
        0.SINGLE
        1.TIC_TOC
        2.DOUBLE
        3.TRIPLE
        4.FOUR_DIRECTIONS
        5.DOUBLE_SWIPE
        6.HEMISPHERE
    Weapon Freq:
        0.FREQ_30
        1.FREQ_15
        2.FREQ_10
        3.FREQ_7_5
        4.FREQ_6
        5.FREQ_5
        6.FREQ_3
        7.FREQ_2
        8.FREQ_1
]]

--player
local weapon_config = {frequency = 1, cannon = 2}
local ship = player_helpers.new_player_ship(w/2fx, h/2fx, 0)
pewpew.configure_player_ship_weapon(ship, weapon_config)
pewpew.configure_player(0, {camera_distance = -1000fx, shield = 3})
pewpew.make_player_ship_transparent(ship, 70)

--level graphics
local duration = 80
local bg = pewpew.new_customizable_entity(w/2fx, h/2fx)
pewpew.customizable_entity_set_mesh(bg, "/dynamic/graphics.lua",0)
pewpew.customizable_entity_configure_music_response(bg, {color_start = 0x0000ffff,color_end = 0x00000000})
pewpew.customizable_entity_start_spawning(bg, duration)
local bgg = pewpew.new_customizable_entity(w/2fx, h/2fx)
pewpew.customizable_entity_set_mesh(bgg, "/dynamic/graphics.lua",0)
pewpew.customizable_entity_configure_music_response(bgg, {color_start = 0xff006100,color_end = 0xff0061f9})
pewpew.customizable_entity_start_spawning(bgg, duration)
local bg2 = pewpew.new_customizable_entity(0fx,0fx)
pewpew.customizable_entity_set_position_interpolation(bg2, true)
pewpew.customizable_entity_configure_music_response(bg2, {color_start = 0xff006100,color_end = 0xff0061f9})
pewpew.customizable_entity_start_spawning(bg2, duration)
local bg3 = pewpew.new_customizable_entity(w,h)
pewpew.customizable_entity_set_position_interpolation(bg3, true)
pewpew.customizable_entity_configure_music_response(bg3, {color_start = 0x5100ffbb,color_end = 0x5100ff00})
pewpew.customizable_entity_start_spawning(bg2, duration)

--random spawn
local function rs()
    return fmath.random_fixedpoint(0fx+20fx, w-20fx),fmath.random_fixedpoint(0fx+20fx, h-20fx)
end
--random angle
local function rangle()
    return fmath.random_fixedpoint(0fx, fmath.tau())
end

local function spawn_cube_army(startx,starty,endx,endy,cubes)
    local dx, dy = startx - endx, starty - endy
    local distance = fmath.sqrt((dx * dx) + (dy * dy))
    local angle = fmath.atan2(dy,dx)
    local y,x = fmath.sincos(angle+fmath.tau()/2fx)
    local inc = 0fx
    for i = 1, cubes do
        local thing = pewpew.new_rolling_cube(startx+x*inc, starty+y*inc)
        inc = inc + distance/fmath.to_fixedpoint(cubes)
        pewpew.rolling_cube_set_enable_collisions_with_walls(thing, true)
    end
    local thing = pewpew.new_rolling_cube(startx+x*inc, starty+y*inc)
    pewpew.rolling_cube_set_enable_collisions_with_walls(thing, true)
end

local function random_army_spawn()
    local rn = fmath.random_int(1, 4)
    if rn == 1 then
        spawn_cube_army(250fx,250fx,w-250fx,250fx,13) 
    elseif rn == 2 then
        spawn_cube_army(250fx,250fx,250fx,h-250fx,13)
    elseif rn == 3 then
        spawn_cube_army(w-250fx,250fx,w-250fx,h-250fx,13)
    elseif rn == 4 then
        spawn_cube_army(250fx,h-250fx,w-250fx,h-250fx,13)
    end
end

--the enemy counter
local function enemy_counter()
    local id = pewpew.new_customizable_entity(w/2fx, h/2fx)
    pewpew.customizable_entity_set_mesh_scale(id, 22fx/10fx)
    pewpew.customizable_entity_configure_music_response(id,{scale_x_start = 4fx,scale_x_end = 7fx,scale_y_start = 4fx,scale_y_end = 7fx,scale_z_start = 4fx,scale_z_end = 7fx})

    local once = true; local once2 = true
    local except = true
    pewpew.entity_set_update_callback(id, function()
        if gh.enemies < 4 then
            pewpew.customizable_entity_set_string(id, "#00ff00ff"..gh.enemies)
        elseif gh.enemies >= 4 and gh.enemies < 8 then
            pewpew.customizable_entity_set_string(id, "#ffff00ff"..gh.enemies)
        elseif gh.enemies >= 8 then
            pewpew.customizable_entity_set_string(id, "#ff0000ff"..gh.enemies)
        end 
        if gh.enemies >= 10 then
            if pewpew.entity_get_is_alive(ship) and once2 then
                local px, py = pewpew.entity_get_position(ship)
                local new_message = floating_message.new(px, py-50fx, "Too many floating cubes!", 1.5fx, 0xff0000ff, 3)
                pewpew.add_damage_to_player_ship(ship, 9999)
                once2 = false
            end
        end
    end)
end

enemy_counter()

local function warning()
    local bottom = pewpew.new_customizable_entity(w/2fx, 60fx)
    local left = pewpew.new_customizable_entity(w-60fx, h/2fx)
    local right = pewpew.new_customizable_entity(60fx, h/2fx)
    local top = pewpew.new_customizable_entity(w/2fx, h-60fx)
    local a = 0
    pewpew.customizable_entity_set_mesh_angle(right, fmath.tau()/4, 0fx,0fx,1fx)
    pewpew.customizable_entity_set_mesh_angle(left, fmath.tau()/4+fmath.tau()/2, 0fx,0fx,1fx)
    local ALARM = false; local scale_down = true
    local thing = "-------------------"
    pewpew.entity_set_update_callback(bottom, function()
        if gh.enemies >= 8 then
            ALARM = true
        else ALARM = false end
        if ALARM then
        if a < 30 then scale_down = false elseif a > 230 then scale_down = true end
        if not scale_down then
            a = a + 4
        else a = a - 4 end else a = 0 end
        local color = ch.make_color(255,0,0,a)
        pewpew.customizable_entity_set_string(bottom, ch.color_to_string(color)..thing.."DANGER: TOO MANY FLOATING CUBES"..thing)
        pewpew.customizable_entity_set_string(top, ch.color_to_string(color)..thing.."DANGER: TOO MANY FLOATING CUBES"..thing)
        pewpew.customizable_entity_set_string(left, ch.color_to_string(color)..thing.."DANGER: TOO MANY FLOATING CUBES"..thing)
        pewpew.customizable_entity_set_string(right, ch.color_to_string(color)..thing.."DANGER: TOO MANY FLOATING CUBES"..thing)
    end)
end

warning()

for i = 1, 2 do 
    local rx, ry = rs(); local ra = rangle()
    discos.new(rx,ry,ra,6fx,ship)
end
local rx, ry = rs()
pewpew.new_wary(rx, ry)
local rx, ry = rs(); local ra = rangle()
pewpew.new_inertiac(rx, ry, 11fx/10fx, 0fx)
pewpew.new_rolling_sphere(rx, ry, ra, 5fx)
local rx, ry = rs()
local bo = pewpew.new_bomb(rx, ry, 0)
player_helpers.add_arrow(bo,0x0090ff80)
local rx, ry = rs()
local bo = pewpew.new_bomb(rx, ry, 3)
player_helpers.add_arrow(bo,0x9000ff80)

local time = 0
local mod = 120; local sub = 7
local inc = 0fx; local count = 0
pewpew.add_update_callback(function()
    local player_score = pewpew.get_score_of_player(0)
    time = time + 1
    local rx, ry = rs(); local ra = rangle()
    if time % 890 == 0 then
        if count > 4 and count <= 6 then
            sub = 4
        elseif count > 6 and count < 7 then
            sub = 3
        elseif count >= 7 then
            sub = 2
        end
        count = count + 1
        shield.new(rx,ry,weapon_config)
        mod = mod - sub
        --print("Spawn Freq: ".. mod .." | Subtract: ".. sub .. " | Score: " .. player_score)
        if count % 2 == 0 then
            local rx, ry = rs()
            local bo = pewpew.new_bomb(rx, ry, 0)
            player_helpers.add_arrow(bo,0x0090ff80)
        else
            local rx, ry = rs()
            local bo = pewpew.new_bomb(rx, ry, 3)
            player_helpers.add_arrow(bo,0x9000ff80)
        end
    end
    if time < 30 then
        inc = inc + 60fx
        pewpew.configure_player(0, {camera_distance = -1900fx+inc})
    end
    if pewpew.get_player_configuration(0).has_lost == true then pewpew.stop_game() end
    if time % 439 == 0 then
        pewpew.new_inertiac(rx, ry, 11fx/10fx, 0fx)
    end
    if time % 378 == 0 then
        random_army_spawn()
    end
    if time % 210 == 0 then
        pewpew.new_wary(rx, ry)
    end
    if time % 359 == 0 then
        pewpew.new_rolling_sphere(rx, ry, ra, 5fx)
    end
    pewpew.customizable_entity_set_mesh(bg2, "/dynamic/grid.lua",time%88)
    pewpew.customizable_entity_set_mesh(bg3, "/dynamic/grid2.lua",time%88)
    if time % mod == 0 then discos.new(rx,ry,ra,7fx,ship) end
end)