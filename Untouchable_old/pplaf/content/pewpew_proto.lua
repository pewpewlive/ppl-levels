
-- entity prototype with PewPew functions

local proto = {}

function proto:get_position()
	return pewpew.entity_get_position(self.id)
end
function proto:set_position(x, y)
	return pewpew.entity_set_position(self.id, x, y)
end
function proto:get_is_alive()
	return pewpew.entity_get_is_alive(self.id)
end
function proto:get_is_started_to_be_destroyed()
	return pewpew.entity_get_is_started_to_be_destroyed(self.id)
end
function proto:set_radius(r)
	return pewpew.entity_set_radius(self.id, r)
end
function proto:set_update_callback(callback)
	return pewpew.entity_set_update_callback(self.id, callback)
end
function proto:destroy()
	return pewpew.entity_destroy(self.id)
end
function proto:set_position_interpolation(b)
	return pewpew.customizable_entity_set_position_interpolation(self.id, b)
end
function proto:set_mesh(path, index)
	return pewpew.customizable_entity_set_mesh(self.id, path, index)
end
function proto:set_mesh_xyz(x, y, z)
	return pewpew.customizable_entity_set_mesh_xyz(self.id, x, y, z)
end
function proto:set_mesh_z(z)
	return pewpew.customizable_entity_set_mesh_z(self.id, z)
end
function proto:skip_mesh_attributes_interpolation()
	return pewpew.customizable_entity_skip_mesh_attributes_interpolation(self.id)
end
function proto:set_flipping_meshes(path, i1, i2)
	return pewpew.customizable_entity_set_flipping_meshes(self.id, path, i1, i2)
end
function proto:set_mesh_color(color)
	return pewpew.customizable_entity_set_mesh_color(self.id, color)
end
function proto:set_string(str)
	return pewpew.customizable_entity_set_string(self.id, str)
end
function proto:set_mesh_scale(scale)
	return pewpew.customizable_entity_set_mesh_scale(self.id, scale)
end
function proto:set_mesh_xyz_scale(x, y, z)
	return pewpew.customizable_entity_set_mesh_xyz_scale(self.id, x, y, z)
end
function proto:set_mesh_angle(angle, vx, vy, vz)
	return pewpew.customizable_entity_set_mesh_angle(self.id, angle, vx, vy, vz)
end
function proto:add_rotation_to_mesh(angle, vx, vy, vz)
	return pewpew.customizable_entity_add_rotation_to_mesh(self.id, angle, vx, vy, vz)
end
function proto:configure_music_response(color1, color2, xs1, xs2, ys1, ys2, zs1, zs2)
	return pewpew.customizable_entity_configure_music_response(self.id, {color1, color2, xs1, xs2, ys1, ys2, zs1, zs2})
end
function proto:set_visibility_radius(r)
	return pewpew.customizable_entity_set_visibility_radius(self.id, r)
end
function proto:configure_wall_collision(collide_with_walls, collision_callback)
	return pewpew.customizable_entity_configure_wall_collision(self.id, collide_with_walls, collision_callback)
end
function proto:set_player_collision_callback(collision_callback)
	return pewpew.customizable_entity_set_player_collision_callback(self.id, collision_callback)
end
function proto:set_player_weapon_collision_callback(collision_callback)
	return pewpew.customizable_entity_set_player_weapon_collision_callback(self.id, collision_callback)
end
function proto:start_spawning(time)
	return pewpew.customizable_entity_start_spawning(self.id, time)
end
function proto:start_exploding(time)
	return pewpew.customizable_entity_start_exploding(self.id, time)
end

return proto
