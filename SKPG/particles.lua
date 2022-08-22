local color_helpers = require("/dynamic/helpers/color_helpers.lua")

meshes = {
    {
        vertexes = {{-1, -1}, {-1, 1}, {1, 1}, {1, -1}},
        segments = {{0, 1, 2, 3, 0}}
    }
}

local particles = {}

function particles.new(x, y, duration)
    local particle_id = pewpew.new_customizable_entity(x, y)
    local index = fmath.random_int(0, 1)
    pewpew.customizable_entity_start_spawning(particle_id, 0)
    pewpew.customizable_entity_set_mesh_scale(particle_id, fmath.random_fixedpoint(1fx, 2.5fx))
    pewpew.customizable_entity_set_mesh_angle(particle_id, fmath.random_fixedpoint(0fx, fmath.tau()), 0fx, 0fx, 1fx)

    local fade = 255 // duration
    local current_alpha = 255
    local time = 0
    pewpew.entity_set_update_callback(particle_id, function(entity_id)
        time = time + 1
        if time == duration then pewpew.entity_destroy(entity_id) end

        current_alpha = current_alpha - fade
        if index == 0 then
            pewpew.customizable_entity_set_mesh_color(entity_id, color_helpers.make_color_with_alpha(0x00ffff90, current_alpha))
        else
            pewpew.customizable_entity_set_mesh_color(entity_id, color_helpers.make_color_with_alpha(0x00ffddff, current_alpha))
        end
    end)
    pewpew.customizable_entity_set_mesh(particle_id, "/dynamic/particles.lua", 0)

end

return particles