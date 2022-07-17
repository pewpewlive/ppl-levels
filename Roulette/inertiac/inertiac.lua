local inertic = {}

local function random()
    return fmath.random_int(150,250)
end

function inertic.inertic(x, y, player_id)
    local parts = {
        inertic,
        inertic2,
        inertic3,
        inerticore,
        inerticore2
    }

    parts.inertic1 = pewpew.new_customizable_entity(x, y)
    parts.inertic2 = pewpew.new_customizable_entity(x, y)
    parts.inertic3 = pewpew.new_customizable_entity(x, y)
    parts.inerticore = pewpew.new_customizable_entity(x, y)
    parts.inerticore2 = pewpew.new_customizable_entity(x, y)

    pewpew.customizable_entity_set_mesh_color(parts.inertic1, 0x00ff00ff)
    pewpew.customizable_entity_set_mesh_color(parts.inertic2, 0x00ff00ff)
    pewpew.customizable_entity_set_mesh_color(parts.inertic3, 0x00ff00ff)
    pewpew.customizable_entity_set_mesh_color(parts.inerticore, 0x0000ffff)
    pewpew.customizable_entity_set_mesh_color(parts.inerticore2, 0x0000ffff)

    pewpew.customizable_entity_set_mesh(parts.inertic1, "/dynamic/inertiac/inertiac_mesh.lua", 0)
    pewpew.customizable_entity_set_mesh(parts.inertic2, "/dynamic/inertiac/inertiac_mesh.lua", 0)
    pewpew.customizable_entity_set_mesh(parts.inertic3, "/dynamic/inertiac/inertiac_mesh.lua", 0)
    pewpew.customizable_entity_set_mesh(parts.inerticore, "/dynamic/inertiac/inertiac_mesh_core.lua", 0)
    pewpew.customizable_entity_set_mesh(parts.inerticore2, "/dynamic/inertiac/inertiac_mesh_core.lua", 0)

    pewpew.customizable_entity_set_position_interpolation(parts.inertic1, true)
    pewpew.customizable_entity_set_position_interpolation(parts.inertic2, true)
    pewpew.customizable_entity_set_position_interpolation(parts.inertic3, true)
    pewpew.customizable_entity_set_position_interpolation(parts.inerticore, true)
    pewpew.customizable_entity_set_position_interpolation(parts.inerticore2, true)

    pewpew.entity_set_radius(parts.inertic1, 23fx)

    local health = 100
    local vx, vy = 0, 0
    local time = 0
    local number = false
    local count = 0
    local m = random()
    local alive = true
    pewpew.entity_set_update_callback(parts.inertic1, function()
        count = count + 1
        local x1, y1 = pewpew.entity_get_position(parts.inertic1)
        local x2, y2 = pewpew.entity_get_position(player_id)

        local dx, dy = x2 - x1, y2 - y1
        local length = fmath.sqrt((dx * dx) + (dy * dy))
        vx, vy = vx + dx / length, vy + dy / length
        vx, vy = vx * 930fx/1000fx, vy * 930fx/1000fx 
        
        if count % m == 0 then
            vx = -vx
            vy = -vy
        end

        if health > 0 then
            pewpew.entity_set_position(parts.inertic1, x1 + vx, y1 + vy)
            pewpew.entity_set_position(parts.inertic2, x1 + vx, y1 + vy)
            pewpew.entity_set_position(parts.inertic3, x1 + vx, y1 + vy)
            pewpew.entity_set_position(parts.inerticore, x1 + vx, y1 + vy)
            pewpew.entity_set_position(parts.inerticore2, x1 + vx, y1 + vy)

            pewpew.customizable_entity_add_rotation_to_mesh(parts.inertic1, fmath.tau()/14fx, 0fx, 1fx, 1fx)
            pewpew.customizable_entity_add_rotation_to_mesh(parts.inertic2, fmath.tau()/18fx, 1fx, 0fx, 1fx)
            pewpew.customizable_entity_add_rotation_to_mesh(parts.inertic3, fmath.tau()/24fx, 1fx, 1fx, 0fx)
            pewpew.customizable_entity_add_rotation_to_mesh(parts.inerticore, fmath.tau()/14fx, 1fx, 0fx, 0fx)
            pewpew.customizable_entity_add_rotation_to_mesh(parts.inerticore2, fmath.tau()/20fx, 0fx, 1fx, 0fx)
        end

        if number then
            time = time + 1
        end

        if time >= 3 and number and health > 0 then
            number = false
            pewpew.customizable_entity_set_mesh_color(parts.inertic1, 0x00ff00ff)
            pewpew.customizable_entity_set_mesh_color(parts.inertic2, 0x00ff00ff)
            pewpew.customizable_entity_set_mesh_color(parts.inertic3, 0x00ff00ff)
            pewpew.customizable_entity_set_mesh_color(parts.inerticore, 0x0000ffff)
            pewpew.customizable_entity_set_mesh_color(parts.inerticore2, 0x0000ffff)
            vx, vy = vx * 930fx/1000fx, vy * 930fx/1000fx 
            time = 0
        elseif time > 1 and time < 3 then 
            vx, vy = vx * 935fx/1150fx, vy * 935fx/1150fx 
        end
    end)

    pewpew.customizable_entity_set_weapon_collision_callback(parts.inertic1, function(entity_id, player_index, weapon_type)
        if weapon_type == pewpew.WeaponType.BULLET and number == false then
            health = health - 1
          pewpew.customizable_entity_set_mesh_color(parts.inertic1, 0xffff00ff)
          pewpew.customizable_entity_set_mesh_color(parts.inertic2, 0xffff00ff)
          pewpew.customizable_entity_set_mesh_color(parts.inertic3, 0xffff00ff)
          pewpew.customizable_entity_set_mesh_color(parts.inerticore, 0xff0000ff)
          pewpew.customizable_entity_set_mesh_color(parts.inerticore2, 0xff0000ff)
          number = true
          if health == 0 then
            pewpew.customizable_entity_set_mesh_color(parts.inertic1, 0x00ff00ff)
            pewpew.customizable_entity_set_mesh_color(parts.inertic2, 0x00ff00ff)
            pewpew.customizable_entity_set_mesh_color(parts.inertic3, 0x00ff00ff)
            pewpew.customizable_entity_set_mesh_color(parts.inerticore, 0x0000ffff)
            pewpew.customizable_entity_set_mesh_color(parts.inerticore2, 0x0000ffff)
            pewpew.customizable_entity_start_exploding(parts.inertic,30)
            pewpew.customizable_entity_start_exploding(parts.inertic2,30)
            pewpew.customizable_entity_start_exploding(parts.inertic3,30)
            pewpew.customizable_entity_start_exploding(parts.inerticore,30)
            pewpew.customizable_entity_start_exploding(parts.inerticore2,30)
          end
        end
        if health > 0 then
            return true
        end
    end)

    pewpew.customizable_entity_set_player_collision_callback(parts.inertic1, function(entity_id, player_index, weapon_type)
        pewpew.add_damage_to_player_ship(player_id,3)
        pewpew.customizable_entity_start_exploding(parts.inertic1,30)
        pewpew.customizable_entity_start_exploding(parts.inertic2,30)
        pewpew.customizable_entity_start_exploding(parts.inertic3,30)
        pewpew.customizable_entity_start_exploding(parts.inerticore,30)
        pewpew.customizable_entity_start_exploding(parts.inerticore2,30)
        pewpew.customizable_entity_set_mesh_color(parts.inertic1, 0x00ff00ff)
        pewpew.customizable_entity_set_mesh_color(parts.inertic2, 0x00ff00ff)
        pewpew.customizable_entity_set_mesh_color(parts.inertic3, 0x00ff00ff)
        pewpew.customizable_entity_set_mesh_color(parts.inerticore, 0x0000ffff)
        pewpew.customizable_entity_set_mesh_color(parts.inerticore2, 0x0000ffff)
        health = 0
    end)

    pewpew.customizable_entity_configure_wall_collision(parts.inertic1,true,function()
        vx = -vx
        vy = -vy
    end)

    return parts
end

function inertic.die(partss)
    if pewpew.entity_get_is_alive(partss.inertic1) then 
        pewpew.customizable_entity_start_exploding(partss.inertic1,10)
        pewpew.customizable_entity_start_exploding(partss.inertic2,10)
        pewpew.customizable_entity_start_exploding(partss.inertic3,10)
        pewpew.customizable_entity_start_exploding(partss.inerticore,10)
        pewpew.customizable_entity_start_exploding(partss.inerticore2,10)
    end
end

return inertic