local particles = require("/dynamic/particles.lua")
local eh = require('/dynamic/helpers/enemy_helpers.lua')
local floating_message = require("/dynamic/helpers/floating_message.lua")
local rival = require("/dynamic/enemies/rival/code.lua")

local star = {}

function star.new(x,y,rival_table)
    local id = eh.basic_needs(x,y,"/dynamic/enemies/lucky_star/mesh.lua",0,nil,1fx,14fx)
    eh.add_entity_to_type(eh.types.LUCKY_STAR, id)
    pewpew.customizable_entity_start_spawning(id,10)
    local time = 0
    local angle = fmath.random_fixedpoint(0fx,fmath.tau())
    local move_y,move_x = fmath.sincos(angle)
    local circler = 0fx
    local sin, cos = fmath.sincos(circler)
    local speed = 6fx
    local dead = false
    roll = 0.509fx
    pewpew.entity_set_update_callback(id,function()
        time = time + 1
        if not dead then pewpew.customizable_entity_set_mesh(id,"/dynamic/enemies/lucky_star/mesh.lua",time % 36) end

        circler = circler + 1fx/10fx
        sin, cos = fmath.sincos(circler)
        move_y,move_x = fmath.sincos(angle)
        local ex, ey = pewpew.entity_get_position(id)
        if not dead then pewpew.entity_set_position(id,ex+(move_x*speed - move_y* cos*2fx),ey+(move_y*speed-move_x *sin*2fx)); pewpew.customizable_entity_add_rotation_to_mesh(id,roll,0fx,0fx,1fx) end

        local random_angle = fmath.random_fixedpoint(0fx,fmath.tau())
        local random = fmath.random_fixedpoint(1fx,10fx)
        local offy,offx = fmath.sincos(random_angle)
        if time % 3 == 0 and not dead then
            particles.new(ex+offx*random,ey+offy*random,20)
        end
    end)
    pewpew.customizable_entity_set_weapon_collision_callback(id, function(entity_id, player_index, weapon_type)
        local ex, ey = pewpew.entity_get_position(id)
        if weapon_type == pewpew.WeaponType.ATOMIZE_EXPLOSION then
            pewpew.create_explosion(ex, ey, 0x00ffffff, 7fx/10fx, 35)
            pewpew.play_sound("/dynamic/enemies/lucky_star/sfx.lua",0,ex,ey)
            pewpew.entity_destroy(id)
        end
        return true
    end)
    pewpew.customizable_entity_configure_wall_collision(id,true,function(entity_id, wall_normal_x, wall_normal_y)
        local dot_product_move = ((wall_normal_x * move_x) + (wall_normal_y * move_y)) * 2fx; 
        local dot_product_sincos = ((wall_normal_x * sin) + (wall_normal_y * cos)) * 2fx
        move_x = move_x - (wall_normal_x * dot_product_move)
        move_y = move_y - (wall_normal_y * dot_product_move); angle = fmath.atan2(move_y,move_x)
        sin = sin - (wall_normal_x * dot_product_sincos)
        cos = cos - (wall_normal_y * dot_product_sincos);circler = fmath.atan2(sin, cos)
    end)
    pewpew.customizable_entity_set_player_collision_callback(id,function(entity_id, player_index, ship_entity_id)
        local conf = pewpew.get_player_configuration(0)
        pewpew.configure_player(0, {shield = conf.shield + 1})
        local ex, ey = pewpew.entity_get_position(id)
        pewpew.play_sound("/dynamic/enemies/lucky_star/sfx.lua",0,ex,ey)
        floating_message.new(ex, ey, "POOF!", 1.5fx, 0x00ffffff, 7)
        pewpew.create_explosion(ex, ey, 0x00ffffff, 7fx/10fx, 35)
        dead = true
        
        for j = 1, #rival_table do
            local cx, cy = pewpew.entity_get_position(rival_table[j])
            local ex, ey = pewpew.entity_get_position(id)
            local distance = fmath.sqrt((cx - ex)*(cx - ex) + (cy - ey)*(cy - ey))
            if distance < 65fx then
                rival.react(rival_table[j]) 
            end
        end
        pewpew.entity_destroy(id)
    end)
end

return star