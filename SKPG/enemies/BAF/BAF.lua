local eh = require("/dynamic/helpers/enemy_helpers.lua")
local color_helpers = require("/dynamic/helpers/color_helpers.lua")

local BAF = {}

function BAF.new(x,y,ship,speed,angle)
    local baf = pewpew.new_customizable_entity(x,y)
    eh.add_entity_to_type(eh.types.BAF, baf)
    pewpew.customizable_entity_set_mesh(baf,"/dynamic/enemies/BAF/meshes.lua",0)
    pewpew.entity_set_radius(baf,12fx)
    pewpew.customizable_entity_set_position_interpolation(baf,true)

    local time = 0
    local move_y, move_x = fmath.sincos(angle)
    local roll = fmath.tau()
    local dead = false
    local activated = false
    local b = 99
    local coloring = true
    pewpew.entity_set_update_callback(baf,function()
        time = time + 1
        roll = roll + speed/25fx
        local ex, ey = pewpew.entity_get_position(baf)
        if time == 30 then
            activated = true
        end
        if time == 1 then
            pewpew.customizable_entity_add_rotation_to_mesh(baf, angle, 0fx, 0fx, 1fx)
        end

        if not dead and activated then
            pewpew.entity_set_position(baf, ex+(move_x*speed),ey+(move_y*speed))
            pewpew.customizable_entity_set_mesh_angle(baf,roll,0fx,1fx,0fx)
            pewpew.customizable_entity_add_rotation_to_mesh(baf, angle, 0fx, 0fx, 1fx)
        end

        if not coloring then
            b = b - 1
        elseif coloring then
            b = b + 1
        end
        if b > 130 then
            coloring = false
        end
        if b < 50 then
            coloring = true
        end


        local r = 0
        local g = 255
        local a = 255
        pewpew.customizable_entity_set_mesh_color(baf,  color_helpers.make_color(r,g,b,a))
    end)
    pewpew.customizable_entity_configure_wall_collision(baf,true,function(entity_id, wall_normal_x, wall_normal_y)
        local dot_product_move = ((wall_normal_x * move_x) + (wall_normal_y * move_y)) * 2fx; 
        move_x = move_x - (wall_normal_x * dot_product_move)
        move_y = move_y - (wall_normal_y * dot_product_move); 
        angle = fmath.atan2(move_y,move_x)
    end)
    pewpew.customizable_entity_set_weapon_collision_callback(baf, function(entity_id, player_index, weapon_type)
        if weapon_type == pewpew.WeaponType.ATOMIZE_EXPLOSION then
            pewpew.customizable_entity_start_exploding(baf, 30)
        end
        if weapon_type == pewpew.WeaponType.ATOMIZE_EXPLOSION then
            pewpew.entity_destroy(baf)
        end
        if not dead then
        return true
        end
    end)
    pewpew.customizable_entity_set_player_collision_callback(baf, function()
        if activated then
            pewpew.add_damage_to_player_ship(ship, 1) 
            pewpew.customizable_entity_start_exploding(baf, 30)
            dead = true
        end
    end)
end

return BAF