local color_helpers = require("/dynamic/helpers/color_helpers.lua")
local floating_message = require("/dynamic/helpers/floating_message.lua")

local explobox = {}

local function exploded(box1)
    local x,y = pewpew.entity_get_position(box1)
    local explosion = pewpew.new_customizable_entity(x,y)
    pewpew.customizable_entity_set_mesh(explosion, "/dynamic/explobox/explosion.lua",0)
    pewpew.customizable_entity_set_mesh_color(explosion,0x2500ffff)
    pewpew.customizable_entity_start_spawning(explosion,0)
    pewpew.customizable_entity_set_position_interpolation(explosion,true)
    pewpew.customizable_entity_skip_mesh_attributes_interpolation(explosion)
    local explosion2 = pewpew.new_customizable_entity(x,y)
    pewpew.customizable_entity_set_mesh(explosion2, "/dynamic/explobox/explosion.lua",0)
    pewpew.customizable_entity_set_mesh_color(explosion2,0x150090ff)
    pewpew.customizable_entity_start_spawning(explosion2,0)
    pewpew.customizable_entity_set_position_interpolation(explosion2,true)
    pewpew.customizable_entity_skip_mesh_attributes_interpolation(explosion2)

    local dead2 = 0
    local player_index_u = 0
    local scale = 1fx
    local radius = 50fx
    local once = false
    local time = 0
    pewpew.entity_set_update_callback(explosion, function()
        if dead2 < 1  then
            scale = scale + 1fx/2fx
            radius = radius + 22fx
        end
        time = time + 1
        pewpew.customizable_entity_set_mesh_scale(explosion, scale)
        pewpew.customizable_entity_set_mesh_scale(explosion2, scale-5fx/10fx)
        pewpew.customizable_entity_add_rotation_to_mesh(explosion, 0.509fx,0fx,0fx,1fx)
        pewpew.customizable_entity_add_rotation_to_mesh(explosion2, -0.509fx,0fx,0fx,1fx)
        if time == 15 and dead2 < 1 then
            pewpew.customizable_entity_start_exploding(explosion,20)
            pewpew.customizable_entity_start_exploding(explosion2,30)
            dead2 = dead2 + 1
        end
        if pewpew.entity_get_is_alive(box1) then
            local x,y = pewpew.entity_get_position(box1)
        end
        local entities = pewpew.get_entities_colliding_with_disk(x, y, radius)
        if dead2 < 1 then
            for i = 1, #entities do
                pewpew.entity_react_to_weapon(entities[i], {type = pewpew.WeaponType.ATOMIZE_EXPLOSION, x = x, y = y, player_index = player_index_u})
            end
        end
    end)
end

local function explobox(x,y)
    local box = pewpew.new_customizable_entity(x,y)
    pewpew.customizable_entity_set_mesh(box,"/dynamic/explobox/explobox_mesh2.lua", 0)
    local box1 = pewpew.new_customizable_entity(x,y)
    pewpew.customizable_entity_set_mesh(box1,"/dynamic/explobox/explobox_mesh.lua", 0)
    pewpew.customizable_entity_start_spawning(box,30)
    pewpew.customizable_entity_start_spawning(box1,20)
    pewpew.customizable_entity_set_mesh_color(box, 0x000070ff)
    pewpew.customizable_entity_set_mesh_color(box1, 0x0000ffff)
    pewpew.customizable_entity_set_position_interpolation(box,true)
    pewpew.customizable_entity_set_position_interpolation(box1,true)
    pewpew.entity_set_radius(box1, 9fx)


    local time = 0
    local random_angle = fmath.random_fixedpoint(0fx, fmath.tau())
    local speed = 3fx
    local active = false
    local move_y, move_x = fmath.sincos(random_angle)
    local color = 0x000070ff
    local color2 =  0x0000ffff
    local dead = false
    local c = 0
    local explode = false
    local once = false
    local one = false
    pewpew.entity_set_update_callback(box,function()
        time = time + 1
        if time > 30 and not dead and not explode then
            if time % 3 == 0 and time > 50 then
               c = c + 1
            end
            active = true
            pewpew.customizable_entity_add_rotation_to_mesh(box, 0.209fx,1fx,1fx,1fx)
            pewpew.customizable_entity_add_rotation_to_mesh(box1, 0.409fx,1fx,1fx,1fx)

            local x1, y1 = pewpew.entity_get_position(box)
            pewpew.entity_set_position(box, x1 + (move_x*speed), y1 + (move_y*speed))
            pewpew.entity_set_position(box1, x1 + (move_x*speed), y1 + (move_y*speed))

            local rs = fmath.random_fixedpoint(9fx/10fx, 12fx/10fx)
            local rs2 = fmath.random_fixedpoint(1fx, 12fx/10fx)
            pewpew.customizable_entity_set_mesh_scale(box,rs)
            pewpew.customizable_entity_set_mesh_scale(box1,1fx/rs2)
            
            local g = fmath.random_int(0,150)
            local r = fmath.random_int(0,50)
            local b = fmath.random_int(190,255)
            local a = 85 - c
            pewpew.customizable_entity_set_mesh_color(box,  color_helpers.make_color(r,g,b,a))
            local r = fmath.random_int(0,20)
            local g = fmath.random_int(0,120)
            local b = fmath.random_int(190,255)
            local a = 180 - c*2
            pewpew.customizable_entity_set_mesh_color(box1, color_helpers.make_color(r,g,b,a))
        end
        if time > 300 and not dead and not explode then
            pewpew.customizable_entity_start_exploding(box1,50)
            pewpew.customizable_entity_start_exploding(box,30)
            dead = true
        end

        if explode and not once then
            exploded(box1)
            once = true
        end

    end)
    local function wall(entity_id, wall_normal_x, wall_normal_y)
        if wall_normal_x == -1fx or wall_normal_x == 1fx then --this is basically: if the wall is vertical then make the number move_x from a positive to a negative, and from a negative to a positive
            move_x = -move_x
        end
        if wall_normal_y == -1fx or wall_normal_y == 1fx then --this is basically: if the wall is horizontal then make the number move_y from a positive to a negative, and from a negative to a positive
            move_y = -move_y 
        end
        random_angle = fmath.atan2(move_y, move_x)
    end
    pewpew.customizable_entity_configure_wall_collision(box,true, wall)
    pewpew.customizable_entity_configure_wall_collision(box1,true, wall)
    local function player(entity_id, player_index, ship_entity_id)
        if active then
            pewpew.customizable_entity_start_exploding(box1,50)
            pewpew.customizable_entity_start_exploding(box,30)
            local x,y = pewpew.entity_get_position(box1)
            pewpew.play_ambient_sound("/dynamic/explobox/explobox_sfx.lua",0)
            local conf = pewpew.get_player_configuration(player_index)
            pewpew.configure_player(player_index, {shield = conf.shield + 1})
            dead = true
            explode = true
            pewpew.print("obtain")
            local new_message = floating_message.new(x, y, "Shield + Boom", 1.5fx, 0x7000ffff, 3)
            new_message.dz = 10
            new_message.dalpha = 3
        end
    end
    pewpew.customizable_entity_set_player_collision_callback(box1,player)
end

return explobox
