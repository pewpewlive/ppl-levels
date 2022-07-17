local revolver = {}

function revolver.new()
    local revolver = pewpew.new_customizable_entity(375fx, 25500fx)
    pewpew.customizable_entity_set_mesh(revolver, "/dynamic/revolver.lua", 0)
    local yeah = pewpew.new_customizable_entity(375fx, 25500fx)
    pewpew.customizable_entity_set_mesh(yeah, "/dynamic/revolver.lua", 2)
    pewpew.customizable_entity_start_spawning(revolver, 0)
    pewpew.customizable_entity_start_spawning(yeah, 0)

    local counter = 0
    local time = 0
    local once = true
    pewpew.entity_set_update_callback(revolver, function()
        time = time + 1
        local angle = fmath.tau() / 90fx
        

        if time > 0 and time <= 35 then
            counter = counter + 1
            if counter < 15 and pewpew.entity_get_is_alive(revolver) then 
                pewpew.customizable_entity_add_rotation_to_mesh(revolver, -angle, 0fx, 0fx, 1fx)
            end
            if counter >= 15 and counter <= 20 and pewpew.entity_get_is_alive(revolver) then 
                pewpew.customizable_entity_add_rotation_to_mesh(revolver, angle, 0fx, 0fx, 1fx)
            end
            if counter > 20 and counter <= 27 and pewpew.entity_get_is_alive(revolver) then 
                pewpew.customizable_entity_add_rotation_to_mesh(revolver, -angle, 0fx, 0fx, 1fx)
            end
        end
        if time == 35 then
            time = -900
        end
        if time < 0 then
            pewpew.customizable_entity_set_mesh(revolver, "/dynamic/revolver.lua", 1)
        else
            pewpew.customizable_entity_set_mesh(revolver, "/dynamic/revolver.lua", 0)
        end--my life please

        if counter == 35 then 
            counter = 0
        end

    end)
end

return revolver