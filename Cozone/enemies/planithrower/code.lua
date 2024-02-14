local color = require'/dynamic/helpers/color_helpers.lua'
local ph = require'/dynamic/helpers/player_helpers.lua'

local epath = "/dynamic/enemies/planithrower/"

local pt = {}

local function newplanet(x,y,angle,speed,owner)
    local planet = pewpew.new_customizable_entity(x,y)
    pewpew.customizable_entity_set_mesh(planet,epath.."planet.lua",0) 
    pewpew.entity_set_radius(planet,24fx)
    pewpew.customizable_entity_set_position_interpolation(planet,true)
    pewpew.customizable_entity_start_spawning(planet,15)

    local dead = false
    local r = 40 
    local activated = false
    local scale = 1fx/10fx
    local health = 4
    local sin, cos = 0fx,0fx
    local iter = 0fx
    local switch = false
    local angle_step = fmath.tau()/150fx
    local amplitude = fmath.tau()/25fx
    pewpew.entity_set_update_callback(planet,function()
        if scale < 1fx then
            scale = scale + 25fx/1000fx
            if pewpew.entity_get_is_started_to_be_destroyed(owner) and not dead then
                pewpew.customizable_entity_start_exploding(planet,30)
                dead = true
            end
        else
            activated = true
        end
        pewpew.customizable_entity_set_mesh_scale(planet,scale)

        pewpew.customizable_entity_set_mesh_color(planet,color.make_color(r,0,255,185))

        sin, cos = fmath.sincos(angle+iter)
        local bullet_x, bullet_y = pewpew.entity_get_position(planet)
        if not dead then
            if activated then
                pewpew.entity_set_position(planet,bullet_x + cos * speed, bullet_y + sin * speed)
            end
        end
        if not dead then pewpew.customizable_entity_add_rotation_to_mesh(planet,0.809fx,0fx,1fx,1fx) end
        if iter >= amplitude then
            switch = true
        elseif iter <= -amplitude then
            switch = false
        end
        if switch then
            iter = iter - angle_step
        else
            iter = iter + angle_step
        end
    end)

    pewpew.customizable_entity_configure_wall_collision(planet,true,function(entity_id, wall_normal_x, wall_normal_y)
        if not dead and activated then
            health = health - 1
            local dot_product_move = ((wall_normal_x * cos) + (wall_normal_y * sin)) * 2fx; 
            cos = cos - (wall_normal_x * dot_product_move)
            sin = sin - (wall_normal_y * dot_product_move)
            angle = fmath.atan2(sin, cos)
            if health < 0 then
                pewpew.customizable_entity_start_exploding(planet,30)
                dead = true
            end
            if health >= 0 then
                r = r + (255-40)//4
                --print(r)
            end
        end
    end)

    pewpew.customizable_entity_set_player_collision_callback(planet, function(entity_id, player_index, ship_entity_id)
        if not dead then
            pewpew.customizable_entity_start_exploding(planet,30)
            pewpew.add_damage_to_player_ship(ship_entity_id, 1)
            dead = true
        end
    end)
    
    pewpew.customizable_entity_set_weapon_collision_callback(planet, function(entity_id, player_index, weapon_type)
        if weapon_type == pewpew.WeaponType.FREEZE_EXPLOSION or weapon_type == pewpew.WeaponType.ATOMIZE_EXPLOSION then
            if not dead then
                pewpew.customizable_entity_start_exploding(planet,30)
                dead = true
            end
        elseif weapon_type == pewpew.WeaponType.REPULSIVE_EXPLOSION then
            local ex,ey = pewpew.entity_get_position(planet)
            local px,py = pewpew.entity_get_position(ph.player_ships[1])
            local dx,dy = ex-px,ey-py
            local angle = fmath.atan2(dy,dx)
            sin,cos = fmath.sincos(angle)
        end
    end)
end

function pt.new(x,y)
    local id = pewpew.new_customizable_entity(x,y)
    pewpew.customizable_entity_set_mesh(id,epath.."graphics.lua",0)
    pewpew.entity_set_radius(id,23fx)
    pewpew.customizable_entity_set_position_interpolation(id,true)

    local angle = fmath.random_fixedpoint(0fx,fmath.tau())
    pewpew.customizable_entity_set_mesh_angle(id,angle,0fx,0fx,1fx)
    local time = 0
    local dead = false
    local start_fire = false
    local activate = false
    local fire_time = 0
    local timer = 0
    local health = 10
    local move = true
    local FIRST_ACT = false
    local count = 0
    local once = true
    pewpew.entity_set_update_callback(id,function()
        time = time + 1
        if activate and move then
            timer = timer + 1
        end
        if start_fire then
            fire_time = fire_time + 1
        end
        if timer == 1 then angle = fmath.random_fixedpoint(0fx,fmath.tau()) end
        if timer < 50 and activate and move and not dead then
            pewpew.customizable_entity_set_mesh_angle(id,angle,0fx,0fx,1fx)
            local move_y, move_x = fmath.sincos(angle)
            local ex, ey = pewpew.entity_get_position(id)
            pewpew.entity_set_position(id,ex+move_x*3fx,ey+move_y*3fx)
        else 
            start_fire = true
            move = false
        end
        if fire_time == 30 and start_fire and not dead and activate then
            local ex, ey = pewpew.entity_get_position(id)
            local offy,offx = fmath.sincos(angle)
            newplanet(ex+offx*40fx,ey+offy*40fx,angle,9fx,id)
        elseif fire_time == 65 and start_fire and not dead then
            start_fire = false
            move = true
            fire_time = 0
            timer = 0
        end
        if time > 40 then activate = true; FIRST_ACT = true end

        if dead and once then
            pewpew.increase_score_of_player(0,100)
            once = false
        end

        if count > 0 then count = count - 1 else pewpew.customizable_entity_set_mesh(id,epath.."graphics.lua",0) end
    end)
    pewpew.customizable_entity_set_player_collision_callback(id, function(entity_id, player_index, ship_entity_id)
        if not dead then
            local ex,ey = pewpew.entity_get_position(entity_id)
            pewpew.create_explosion(ex, ey, 0x50ff99ff, 15fx/10fx, 40)
            pewpew.new_floating_message(ex, ey, "#00ff00ff100", {scale = 1fx+1fx/6fx, ticks_before_fade = 20})
            pewpew.customizable_entity_start_exploding(id,30)
            pewpew.add_damage_to_player_ship(ship_entity_id, 1)
            pewpew.increase_score_streak_of_player(player_index, 61)
            pewpew.increase_score_of_player(player_index, 100)
            dead = true
        end
    end)

    pewpew.customizable_entity_set_weapon_collision_callback(id,function(entity_id, player_index, weapon_type)
        if not FIRST_ACT then return false end
        if weapon_type == pewpew.WeaponType.BULLET then
            if not dead then
                local ex, ey = pewpew.entity_get_position(id)
                pewpew.play_sound(epath.."sounds.lua",0,ex,ey)
                health = health - 1
                pewpew.increase_score_of_player(player_index, 10)
                pewpew.increase_score_streak_of_player(player_index, 11)
                if health < 1 then
                    local ex,ey = pewpew.entity_get_position(entity_id)
                    pewpew.create_explosion(ex, ey, 0x50ff99ff, 15fx/10fx, 40)
                    pewpew.new_floating_message(ex, ey, "#00ff00ff100", {scale = 1fx+1fx/6fx, ticks_before_fade = 20})
                    pewpew.increase_score_of_player(player_index, 100)
                    pewpew.customizable_entity_start_exploding(id,30)
                    local ss = pewpew.get_score_streak_level(player_index)
                    for i = 1, ss do
                        pewpew.new_pointonium(ex, ey, 64)
                    end
                    pewpew.increase_score_streak_of_player(player_index, 61)
                    dead = true
                end
            end
        elseif weapon_type == pewpew.WeaponType.ATOMIZE_EXPLOSION and not dead then
            health = 0
            dead = true
            local ex,ey = pewpew.entity_get_position(entity_id)
            pewpew.create_explosion(ex, ey, 0x50ff99ff, 15fx/10fx, 40)
            pewpew.new_floating_message(ex, ey, "#00ff00ff100", {scale = 1fx+1fx/6fx, ticks_before_fade = 20})
            pewpew.increase_score_of_player(player_index, 100)
            pewpew.customizable_entity_start_exploding(id,30)
            local ex, ey = pewpew.entity_get_position(id)
            pewpew.play_sound(epath.."sounds.lua",0,ex,ey)
            local ss = pewpew.get_score_streak_level(player_index)
            for i = 1, ss do
                pewpew.new_pointonium(ex, ey, 64)
            end
            pewpew.increase_score_streak_of_player(player_index, 61)
            return true
        end
        if weapon_type == pewpew.WeaponType.FREEZE_EXPLOSION then
            time = -40
            activate = false
            move = false
            start_fire = false
            return false
        end
        if not dead then
            count = 2
            pewpew.customizable_entity_set_mesh(id,epath.."graphics.lua",1)
            return true
        end
    end)
    pewpew.customizable_entity_configure_wall_collision(id,true,function(entity_id, wall_normal_x, wall_normal_y)
    end)
    return id
end

return pt