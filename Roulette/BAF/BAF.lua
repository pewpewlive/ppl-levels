local color_helpers = require("/dynamic/helpers/color_helpers.lua")

local BAF = {}

function BAF.new(x,y,ship,speed,angle)
    local baf = pewpew.new_customizable_entity(x,y)
    pewpew.customizable_entity_set_mesh(baf,"/dynamic/BAF/meshes.lua",0)
    pewpew.entity_set_radius(baf,11fx)
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
        roll = roll + 0.609fx
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
            b = b - 2
        elseif coloring then
            b = b + 2
        end
        if b > 250 then
            coloring = false
        end
        if b < 100 then
            coloring = true
        end


        local r = 0
        local g = 255
        local a = 255
        pewpew.customizable_entity_set_mesh_color(baf,  color_helpers.make_color(r,g,b,a))
    end)
    pewpew.customizable_entity_configure_wall_collision(baf,true,function(entity_id, wall_normal_x, wall_normal_y)
        if wall_normal_x == -1fx or wall_normal_x == 1fx then --this is basically: if the wall is vertical then make the number move_x from a positive to a negative, and from a negative to a positive
            move_x = -move_x
          end
        if wall_normal_y == -1fx or wall_normal_y == 1fx then --this is basically: if the wall is horizontal then make the number move_y from a positive to a negative, and from a negative to a positive
            move_y = -move_y 
        end
        angle = fmath.atan2(move_y,move_x)
    end)
    pewpew.customizable_entity_set_weapon_collision_callback(baf, function(entity_id, player_index, weapon_type)
        if weapon_type == pewpew.WeaponType.ATOMIZE_EXPLOSION then
          pewpew.entity_destroy(baf)
        end
        if weapon_type == pewpew.WeaponType.ATOMIZE_EXPLOSION then
            pewpew.entity_destroy(baf)
        end
        return true
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