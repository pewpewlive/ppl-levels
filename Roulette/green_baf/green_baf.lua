local baf = {}

function baf.green(x, y, ship, angle)
    local baf = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(baf,"/static/graphics/enemies/baf.lua",0)
    pewpew.customizable_entity_set_mesh_color(baf,0x00ff00ff)
    pewpew.customizable_entity_set_position_interpolation(baf,true)
    pewpew.entity_set_radius(baf,15fx)
    pewpew.customizable_entity_set_mesh_angle(baf,angle,0fx,0fx,1fx)


    local time = 0
    local dead = false
    local activate = false
    local move_y, move_x = fmath.sincos(angle)
    local speed = 1fx
    local rolling_angle = 0fx
    local count = 0
    pewpew.entity_set_update_callback(baf,function()
        time = time + 1

        if time > 30 then
            activate = true
            rolling_angle = rolling_angle + 0.409fx
        end

        if activate then
            local x, y = pewpew.entity_get_position(baf)
            if speed < 8fx then
                speed = speed + 2fx/10fx
            end
            if not dead then
                pewpew.entity_set_position(baf, x + (move_x*speed), y + (move_y*speed))
                pewpew.customizable_entity_set_mesh_angle(baf, rolling_angle, 1fx, 0fx, 0fx)
                pewpew.customizable_entity_add_rotation_to_mesh(baf, angle, 0fx, 0fx, 1fx)
            end
        end
        if dead then
            pewpew.customizable_entity_start_exploding(baf,20)
            count = count + 1
        end
        if count > 7 then
            activate = false
        end
    end)

    pewpew.customizable_entity_configure_wall_collision(baf,true,function(entity_id,wall_normal_x,wall_normal_y)
        if wall_normal_x == -1fx or wall_normal_x == 1fx then
            move_x = -move_x
            move_y = -move_y 
          end
        if wall_normal_y == -1fx or wall_normal_y == 1fx then
            move_y = -move_y 
            move_x = -move_x
        end
        angle = fmath.atan2(move_y, move_x)
        speed = 1fx
    end)

    pewpew.customizable_entity_set_weapon_collision_callback(baf, function(entity_id, player_index, weapon_type)
        if weapon_type == pewpew.WeaponType.BULLET and activate and not dead then
            dead = true
            pewpew.increase_score_of_player(0,10)
            local ex, ey = pewpew.entity_get_position(baf)
            pewpew.create_explosion(ex, ey, 0x00ff00ff,7/10fx,20)
            pewpew.play_sound("/dynamic/green_baf/baf_sfx.lua",0,ex,ey)
        end
        if weapon_type == pewpew.WeaponType.ATOMIZE_EXPLOSION then
            pewpew.entity_destroy(baf)
        end
        if activate then
            return true
        end
    end)

    pewpew.customizable_entity_set_player_collision_callback(baf,function(entity_id, player_index, ship_entity_id)
        pewpew.add_damage_to_player_ship(ship,2)
        pewpew.customizable_entity_start_exploding(baf,20)
        dead = true
    end)
end

return baf