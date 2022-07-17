local color_helpers = require("/dynamic/helpers/color_helpers.lua")

local spring = {}

function spring.spawn(anchor, eqm_length, springiness, dampening, player_id, style)
    local spring_parts = {
        anchor_id,
        spring_id,
    }

    local velocity = 0fx
    spring_parts.anchor_id = pewpew.new_customizable_entity(anchor[1], anchor[2])
    pewpew.customizable_entity_set_mesh(spring_parts.anchor_id, "/dynamic/anchor/spring_meshes.lua", 0)
    pewpew.customizable_entity_set_position_interpolation(spring_parts.anchor_id, true)
    pewpew.customizable_entity_set_mesh_color(spring_parts.anchor_id, 0xffff00ff)
    pewpew.entity_set_radius(spring_parts.anchor_id, 5fx)
    pewpew.customizable_entity_start_spawning(spring_parts.anchor_id,5)

    local function spring_callback()
        local px, py = pewpew.entity_get_position(player_id)
        local dx, dy = px - anchor[1], py - anchor[2]
        local d_length = fmath.sqrt(dx * dx + dy * dy)
        local angle = fmath.atan2(dy, dx)
        local F = (-springiness) * (d_length - eqm_length)

        velocity = velocity + F
        velocity = velocity * dampening

        local move_y, move_x = fmath.sincos(angle)
        pewpew.entity_set_position(player_id, px + move_x * velocity, py + move_y * velocity)
        
        pewpew.customizable_entity_set_mesh_angle(spring_parts.spring_id, angle, 0fx, 0fx, 1fx)

        px, py = pewpew.entity_get_position(player_id)
        dx, dy = px - anchor[1], py - anchor[2]
        d_length = fmath.sqrt(dx * dx + dy * dy)

        pewpew.customizable_entity_set_mesh_xyz_scale(spring_parts.spring_id, d_length / eqm_length, 18fx/10fx - d_length / eqm_length, 1fx)
        pewpew.customizable_entity_set_mesh_color(spring_parts.spring_id, color_helpers.make_fx_color(255fx, 255fx * d_length / 300fx, 0fx, 255fx))
    end

    local function rotating_callback()
        pewpew.customizable_entity_add_rotation_to_mesh(spring_parts.anchor_id, fmath.tau() / 128fx, 0fx, 0fx, 1fx)
    end
    pewpew.entity_set_update_callback(spring_parts.anchor_id, rotating_callback)
    
    pewpew.customizable_entity_set_player_collision_callback(spring_parts.anchor_id, function()
        pewpew.entity_set_update_callback(spring_parts.anchor_id, spring_callback)
        pewpew.customizable_entity_set_mesh(spring_parts.anchor_id, "/dynamic/anchor/spring_meshes.lua", 1)
        spring_parts.spring_id = pewpew.new_customizable_entity(anchor[1], anchor[2])
        pewpew.customizable_entity_set_position_interpolation(spring_parts.spring_id, true)
        if style == "pewpew2" then
            pewpew.customizable_entity_set_mesh(spring_parts.spring_id, "/dynamic/anchor/spring_meshes.lua", 2)
        elseif style == "real" then
            pewpew.customizable_entity_set_mesh(spring_parts.spring_id, "/dynamic/anchor/spring_meshes.lua", 3)
        end

        pewpew.customizable_entity_set_player_collision_callback(spring_parts.anchor_id, nil)
    end)

    return spring_parts
end

function spring.dispose(parts)
    if pewpew.entity_get_is_alive(parts.anchor_id) then pewpew.entity_destroy(parts.anchor_id) end
    if pewpew.entity_get_is_alive(parts.spring_id) then pewpew.entity_destroy(parts.spring_id) end
end

return spring