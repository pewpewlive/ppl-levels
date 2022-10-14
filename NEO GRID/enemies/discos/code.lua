local gh = require("/dynamic/helpers/gameplay_helper.lua")
local discos = {}

--[[ color_start , color_end , scale_x_start , scale_x_end , scale_y_start , scale_y_end , scale_z_start , scale_z_end}]]

local function change_mesh(eid,path,og_index,new_index)
    local cback = pewpew.new_customizable_entity(0fx,0fx)
    local time = 0
    pewpew.entity_set_update_callback(cback, function()
        time = time + 1
        if pewpew.entity_get_is_alive(eid) then
            if time < 3 then
                pewpew.customizable_entity_set_mesh(eid, path, new_index)
            else pewpew.customizable_entity_set_mesh(eid, path, og_index); pewpew.entity_destroy(cback) end
        end
    end)
end

local function explosion(x,y)
    local explosion = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh_scale(explosion, 1fx/7fx)
    pewpew.customizable_entity_set_mesh(explosion, "/dynamic/enemies/discos/granada_mesh.lua", 1)
    pewpew.customizable_entity_set_position_interpolation(explosion, true)
    pewpew.customizable_entity_start_spawning(explosion, 0)
    pewpew.customizable_entity_skip_mesh_attributes_interpolation(explosion)

    local cback = pewpew.new_customizable_entity(x, y)
    local scale = 1fx/7fx
    local once = true
    local escale = 1fx
    local radius = 18fx
    pewpew.entity_set_update_callback(cback, function()
        local scaling do
            if scale < escale then
                scale = scale + 1fx/20fx
                radius = radius + 70fx/10fx
                pewpew.customizable_entity_set_mesh_scale(explosion, scale)
                pewpew.entity_set_radius(explosion, radius)
            end
            if scale >= escale then
                pewpew.customizable_entity_start_exploding(explosion, 30)
                pewpew.entity_destroy(cback)
                pewpew.entity_set_radius(explosion, 0fx)
            end
        end
    end)
    pewpew.customizable_entity_set_player_collision_callback(explosion, function(entity_id, player_index, ship_entity_id)
        if once then
            pewpew.add_damage_to_player_ship(ship_entity_id, 1)
            once = false
        end
    end)
end

local function new_granada(sx,sy,ex,ey)
    local id = pewpew.new_customizable_entity(sx, sy)
    pewpew.customizable_entity_start_spawning(id, 0)
    pewpew.customizable_entity_set_mesh(id, "/dynamic/enemies/discos/granada_mesh.lua", 0)
    pewpew.customizable_entity_set_position_interpolation(id, true)
    pewpew.customizable_entity_configure_music_response(id,{scale_x_start = 1fx,scale_x_end = 12fx/10fx,scale_y_start = 1fx,scale_y_end = 12fx/10fx,scale_z_start = 1fx,scale_z_end = 12fx/10fx})
    pewpew.customizable_entity_set_mesh_color(id, 0x500000ff)
    local cback = pewpew.new_customizable_entity(sx, sy)
    local dx2, dy2 = ex - sx, ey - sy
    local angle = fmath.atan2(dy2,dx2); local my,mx = fmath.sincos(angle)
    local mlength = fmath.sqrt((dx2 * dx2) + (dy2 * dy2))
    local z = 0fx; local explode = false
    pewpew.entity_set_update_callback(cback, function()
        local cx, cy = pewpew.entity_get_position(id)
        local dx, dy = ex - cx, ey - cy
        local clength = fmath.sqrt((dx * dx) + (dy * dy))
        local pe = 100fx-(clength / mlength * 100fx)
        if cx < ex+10fx and cx > ex-10fx and cy < ey+10fx and cy > ey-10fx then
            explode = true
            explosion(cx,cy)
        else
            if pe > 0fx and pe < 50fx then
                z = z + 28fx
            else z = z - 28fx end
            pewpew.customizable_entity_set_mesh_z(id, z)
            pewpew.entity_set_position(id, cx+mx*13fx, cy+my*13fx) 
        end
        if explode then 
            pewpew.customizable_entity_start_exploding(id, 30)
            pewpew.create_explosion(cx, cy, 0xff0000ff, 17fx/10fx, 75) 
            pewpew.entity_destroy(cback)
        end
    end)
end

function discos.new(x,y,angle,speed,player)
    local id = pewpew.new_customizable_entity(x,y)
    pewpew.customizable_entity_set_mesh(id, "/dynamic/enemies/discos/mesh.lua", 0)
    pewpew.customizable_entity_set_position_interpolation(id, true)
    pewpew.customizable_entity_configure_music_response(id,{scale_x_start = 1fx,scale_x_end = 15fx/10fx,scale_y_start = 1fx,scale_y_end = 15fx/10fx,scale_z_start = 1fx,scale_z_end = 15fx/10fx})
    pewpew.entity_set_radius(id,26fx)
    gh.add()
    
    local callback = pewpew.new_customizable_entity(x,y)
    local z = -1fx;local y = 1fx
    local scale_down = false
    local HP = 13; local active = false; local time = 0
    local frozen = false; local once = true
    local duration = 120
    pewpew.entity_set_update_callback(callback, function()
        if not frozen then
        time = time + 1 end
        if frozen and duration >= 1 then 
            duration = duration - 1
        elseif frozen and duration < 1 then
            frozen = false
            duration = 100
        end
        local roll = (speed)/50fx
        if time > 30 then active = true end
        local ex, ey = pewpew.entity_get_position(id)
        --stuff for the granada 
        local ra = fmath.random_fixedpoint(0fx, fmath.tau())
        local offset = fmath.random_fixedpoint(10fx, 100fx)
        local e = pewpew.get_entities_colliding_with_disk(ex, ey, 500fx)
        --movement
        my,mx = fmath.sincos(angle)
        if active and HP >= 1 and not frozen then 
            pewpew.entity_set_position(id, ex+mx*(speed), ey+my*(speed)) end
        --making the goofy rotation
        if not frozen then
            if z < -1fx then scale_down = false elseif z > 1fx then scale_down = true end
            if not scale_down then
                z = z + 1fx/20fx;y = y - 1fx/20fx
            else  z = z - 1fx/20fx;y = y + 1fx/20fx end
            if active then pewpew.customizable_entity_add_rotation_to_mesh(id, roll, 1fx, y, z) end
        end
        --if dead
        if HP < 1 and once then 
            pewpew.entity_destroy(callback)
            pewpew.customizable_entity_start_exploding(id, 25); 
            pewpew.create_explosion(ex, ey, 0x0000ffff, 13fx/10fx, 45) 
            pewpew.create_explosion(ex, ey, 0xff0000ff, 1fx, 50)
            pewpew.play_sound("/dynamic/enemies/discos/sfx.lua", 1, ex, ey)
            pewpew.increase_score_of_player(0, 200)
            gh.sub()
            once = false
        end
        --shoot grenada every so often at the player
        for i = 1, #e do
            if e[i] == player then
                if time % 50 == 0 and not frozen then
                    if pewpew.entity_get_is_alive(player) then
                        px, py = pewpew.entity_get_position(player)
                    end
                    local sin, cos = fmath.sincos(ra)
                    new_granada(ex,ey,px+cos*offset,py+sin*offset)
                end
            end
        end
    end)
    pewpew.customizable_entity_set_weapon_collision_callback(id, function(entity_id, player_index, weapon_type)
        if weapon_type == pewpew.WeaponType.BULLET then
            if active then HP = HP - 1; end
            if HP > 1 and active then change_mesh(id,"/dynamic/enemies/discos/mesh.lua", 0,1)
                pewpew.increase_score_of_player(0, 20)
                local ex, ey = pewpew.entity_get_position(id)
                pewpew.play_sound("/dynamic/enemies/discos/sfx.lua", 0, ex, ey)
                return true 
            end
        elseif weapon_type == pewpew.WeaponType.FREEZE_EXPLOSION then
            if active then frozen = true end
        elseif weapon_type == pewpew.WeaponType.ATOMIZE_EXPLOSION then
            if active then HP = 0 end
        end
    end)
    pewpew.customizable_entity_configure_wall_collision(id,true,function(entity_id, wall_normal_x, wall_normal_y)
        local dot_product_move = ((wall_normal_x * mx) + (wall_normal_y * my)) * 2fx; 
        mx = mx - (wall_normal_x * dot_product_move)
        my = my - (wall_normal_y * dot_product_move)
        angle = fmath.atan2(my,mx)
    end)
    pewpew.customizable_entity_set_player_collision_callback(id, function(entity_id, player_index, ship_entity_id)
        pewpew.add_damage_to_player_ship(ship_entity_id, 1)
        HP = 0
        pewpew.increase_score_of_player(0, 200)
    end)
    return id
end

return discos