
-- entity prototype with PewPew functions

local proto = {}

function proto:get_position()
	return pewpew.entity_get_position(self[i_id])
end
function proto:set_position(x, y)
	return pewpew.entity_set_position(self[i_id], x, y)
end
function proto:get_is_alive()
	return pewpew.entity_get_is_alive(self[i_id])
end
function proto:get_is_started_to_be_destroyed()
	return pewpew.entity_get_is_started_to_be_destroyed(self[i_id])
end
function proto:destroy()
	return pewpew.entity_destroy(self[i_id])
end
function proto:set_position_interpolation(b)
	return pewpew.customizable_entity_set_position_interpolation(self[i_id], b)
end
function proto:set_mesh(path, index)
	return pewpew.customizable_entity_set_mesh(self[i_id], path, index)
end
function proto:set_flipping_meshes(path, i1, i2)
	return pewpew.customizable_entity_set_flipping_meshes(self[i_id], path, i1, i2)
end
function proto:set_mesh_color(color)
	return pewpew.customizable_entity_set_mesh_color(self[i_id], color)
end
function proto:set_string(str)
	return pewpew.customizable_entity_set_string(self[i_id], str)
end
function proto:set_mesh_scale(scale)
	return pewpew.customizable_entity_set_mesh_scale(self[i_id], scale)
end
function proto:set_mesh_xyz_scale(x, y, z)
	return pewpew.customizable_entity_set_mesh_xyz_scale(self[i_id], x, y, z)
end
function proto:set_mesh_angle(angle, vx, vy, vz)
	return pewpew.customizable_entity_set_mesh_angle(self[i_id], angle, vx, vy, vz)
end
function proto:add_rotation_to_mesh(angle, vx, vy, vz)
	return pewpew.customizable_entity_add_rotation_to_mesh(self[i_id], angle, vx, vy, vz)
end
function proto:configure_music_response(color1, color2, xs1, xs2, ys1, ys2, zs1, zs2)
	return pewpew.customizable_entity_configure_music_response(self[i_id], {color1, color2, xs1, xs2, ys1, ys2, zs1, zs2})
end
function proto:set_visibility_radius(r)
	return pewpew.customizable_entity_set_visibility_radius(self[i_id], r)
end
function proto:configure_wall_collision(collide_with_walls, collision_callback)
	return pewpew.customizable_entity_configure_wall_collision(self[i_id], collide_with_walls, collision_callback)
end
function proto:start_spawning(time)
	return pewpew.customizable_entity_start_spawning(self[i_id], time)
end
function proto:start_exploding(time)
	return pewpew.customizable_entity_start_exploding(self[i_id], time)
end
function proto:destroyA(...)
  if self[i_type].destructor then
    self[i_type].destructor(self, ...)
  end
  pplaf.entity.get_group(self[i_type].group)[self[i_id]] = nil
end

return proto
