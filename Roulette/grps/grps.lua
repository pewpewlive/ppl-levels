local rps = {}


function rps.green(x, y, angle, ship)
    local grps = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(grps, "/dynamic/grps/grps5.lua", 0)
    pewpew.customizable_entity_set_mesh_color(grps, 0x00ff00ff)
    pewpew.customizable_entity_set_position_interpolation(grps, true)
    --setting variables moment
    local radius = 24fx
    pewpew.entity_set_radius(grps, radius)
    local move_y, move_x = fmath.sincos(angle)
    local scale = 1fx
    local rolling_angle = fmath.tau() 
    local speed = 3fx
    local time = 0
    --doing the magic
    pewpew.entity_set_update_callback(grps,function()
      time = time + 1
      local x, y = pewpew.entity_get_position(grps)
      if time > 30 then
        pewpew.entity_set_position(grps, x + (move_x*speed), y + (move_y*speed))
      end
      rolling_angle = rolling_angle + 0.709fx
      if time == 2 then
        pewpew.customizable_entity_set_mesh_angle(grps, rolling_angle, 0fx, 1fx, 0fx)
      end
      if time > 30 then
        pewpew.customizable_entity_set_mesh_angle(grps, rolling_angle, 0fx, 1fx, 0fx)
        pewpew.customizable_entity_add_rotation_to_mesh(grps, angle, 0fx, 0fx, 1fx)
      end
      if time % 4 == 0 then 
        pewpew.customizable_entity_set_mesh_color(grps, 0x00ff00ff)--check line 208 - 210 to see why i put this
      end
    end)
    pewpew.customizable_entity_configure_wall_collision(grps, true, function(entity_id, wall_normal_x, wall_normal_y)
      if wall_normal_x == -1fx or wall_normal_x == 1fx then --this is basically: if the wall is vertical then make the number move_x from a positive to a negative, and from a negative to a positive
        move_x = -move_x
      end
      if wall_normal_y == -1fx or wall_normal_y == 1fx then --this is basically: if the wall is horizontal then make the number move_y from a positive to a negative, and from a negative to a positive
        move_y = -move_y 
      end
      --from 187 - 192, it is essential for any rolling sphere replica, as it is basically telling it how it should bounce whne hit to a wall
      angle = fmath.atan2(move_y, move_x)
      scale = scale - 1fx / 10fx
      pewpew.customizable_entity_set_mesh_scale(grps, scale)
      radius = radius - 25fx / 10fx
      pewpew.entity_set_radius(grps, radius)
      speed = speed - 0.5fx --this is why i made the variables, if i didnt make them like this it wouldnt work
      if scale <= 40fx / 100fx then
        pewpew.customizable_entity_start_exploding(grps, 10)
      end
    end)
    pewpew.customizable_entity_set_player_collision_callback(grps, function()
      pewpew.add_damage_to_player_ship(ship, 2) 
      pewpew.customizable_entity_start_exploding(grps, 10)
    end)
    pewpew.customizable_entity_set_weapon_collision_callback(grps, function(entity_id, player_index, weapon_type)
      local x, y = pewpew.entity_get_position(grps)
      if weapon_type == pewpew.WeaponType.BULLET then
        pewpew.customizable_entity_set_mesh_color(grps, 0xffffffff)
      end
      if weapon_type == pewpew.WeaponType.ATOMIZE_EXPLOSION then
        pewpew.entity_destroy(grps)
      end
      return true
    end)
end

return rps