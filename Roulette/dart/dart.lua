local dart = {}

function dart.new(player_id)
    local rc = fmath.random_int(1,4)
    local px, py = pewpew.entity_get_position(player_id)
    local a = fmath.random_fixedpoint(60fx,140fx)
    local b = fmath.random_fixedpoint(60fx,140fx)
    if rc == 1 then
        x, y = px - a, py - b
    elseif rc == 2 then
        x, y = px + a, py - b
    elseif rc == 3 then
        x, y = px + a, py + b
    elseif rc == 4 then
        x, y = px - a, py + b
    end
    local dart = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(dart, "/dynamic/dart/dart_mesh.lua",0)
    pewpew.customizable_entity_skip_mesh_attributes_interpolation(dart)
    pewpew.customizable_entity_start_spawning(dart, 0)
    pewpew.customizable_entity_set_mesh_color(dart, 0x000000ff)
    pewpew.entity_set_radius(dart, 8fx)

    local tx, ty = pewpew.entity_get_position(dart)
    if tx > 700fx or tx < 0fx then
        pewpew.entity_destroy(dart)
    end
    if ty > 600fx or ty < 0fx then
        pewpew.entity_destroy(dart)
    end
    local scale = 1fx/10fx
    local time = 0
    local hit = false
    pewpew.entity_set_update_callback(dart, function()
        time = time + 1

        if time > 2 then
            pewpew.customizable_entity_set_mesh_color(dart, 0x0000ffff)
        end

        pewpew.customizable_entity_set_mesh_scale(dart, scale)
        if time <= 20 then
            scale = scale + 1fx/2fx/10fx
        end
        if time == 20 then
            hit = true
        end
        if time > 35 then
            pewpew.customizable_entity_start_exploding(dart, 30)
        end

        if time > 20 and time <= 24 then
            pewpew.customizable_entity_set_mesh_color(dart, 0xff0000ff)
        elseif time > 24 and time <= 28 then
            pewpew.customizable_entity_set_mesh_color(dart, 0x6000ffff)
        elseif time > 28 and time <= 32 then
            pewpew.customizable_entity_set_mesh_color(dart, 0x0000ffff)
        end

    end)

    pewpew.customizable_entity_set_player_collision_callback(dart, function (entity_id, player_index, ship_entity_id)
        if hit then
            pewpew.add_damage_to_player_ship(ship_entity_id, 1)
            hit = false
        end
    end)
end

return dart