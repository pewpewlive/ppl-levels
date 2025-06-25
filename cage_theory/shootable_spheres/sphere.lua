spheres = {}

function sphere_tick(entity_id)
  local sphere_entity = spheres[entity_id]
  if pewpew.entity_get_is_alive(sphere_entity) then
    local temp_x, temp_y = pewpew.entity_get_position(sphere_entity)

    pewpew.entity_set_position(entity_id, temp_x, temp_y)
  else
    pewpew.entity_destroy(entity_id)
  end
end

function sphere_bullet_collide(entity_id, player_index, weapon_type)
  if blockloop == true then
    local sphere_entity = spheres[entity_id]
    local temp_x, temp_y = pewpew.entity_get_position(sphere_entity)

    pewpew.entity_react_to_weapon(sphere_entity,
      { type = pewpew.WeaponType.ATOMIZE_EXPLOSION, x = temp_x, y = temp_y, player_index = player_index })
    pewpew.entity_destroy(entity_id)
  end
end

function sphere_new(x, y, angle, speed)
  local hitbox = pewpew.new_customizable_entity(x, y)
  spheres[hitbox] = pewpew.new_rolling_sphere(x, y, angle, speed)

  pewpew.entity_set_radius(hitbox, 33fx)
  pewpew.customizable_entity_set_position_interpolation(hitbox, true)

  pewpew.customizable_entity_set_weapon_collision_callback(hitbox, sphere_bullet_collide)
  pewpew.entity_set_update_callback(hitbox, sphere_tick)
end
