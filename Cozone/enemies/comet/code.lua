

local comet = {}

local size = 5fx

local function spawn_comet(circle_id,speed,radius)
    local x,y = pewpew.entity_get_position(circle_id)
    local max_z = 1000fx
    local co = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh_z(co, max_z)
    pewpew.customizable_entity_set_mesh_scale(co, (size*radius)/4fx)
    pewpew.customizable_entity_set_mesh_color(co, 0xddccff79)
    pewpew.customizable_entity_set_mesh(co, "/dynamic/enemies/comet/graphics.lua", 1)
    pewpew.customizable_entity_set_position_interpolation(co, true)

    local function die()
        pewpew.entity_set_update_callback(co, nil)
        pewpew.customizable_entity_start_exploding(co, 20)
        pewpew.customizable_entity_start_exploding(circle_id, 20)
        pewpew.create_explosion(x, y, 0xddccffc9, 2fx+1fx/2fx, 90)
    end

    local function pcc(entity_id, player_index, ship_entity_id)
        pewpew.add_damage_to_player_ship(ship_entity_id, 1)
        die()
    end

    local z_step = speed
    local current_z = max_z
    local once,once2 = false,false
    local ax,bx,by = fmath.random_fixedpoint(-1fx, 1fx), fmath.random_fixedpoint(-1fx, 1fx), fmath.random_fixedpoint(-1fx, 1fx)
    local function euc(entity_id)
        pewpew.customizable_entity_set_mesh_z(entity_id, current_z)
        current_z = current_z - z_step
        pewpew.customizable_entity_add_rotation_to_mesh(entity_id, fmath.tau()/40fx, ax,bx,by)
        if current_z <= z_step*30fx and not once then
            pewpew.new_asteroid(x, y)
            once = true
        end
        if current_z <= z_step*5fx and not once2 then
            pewpew.customizable_entity_set_player_collision_callback(circle_id, pcc)
            once2 = true
        end
        if current_z <= 0fx and not pewpew.entity_get_is_started_to_be_destroyed(co) then
            die()
        end
    end

    pewpew.entity_set_update_callback(co, euc)
end

function comet.new(x,y,speed,radius)
    local id = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh_color(id, 0xddccff40)
    pewpew.customizable_entity_set_mesh(id, "/dynamic/enemies/comet/graphics.lua", 0)
    pewpew.customizable_entity_set_position_interpolation(id, true)
    pewpew.customizable_entity_set_mesh_scale(id, size*radius)
    pewpew.entity_set_radius(id, 95fx*radius)
    spawn_comet(id,speed,radius)
    return id
end

return comet