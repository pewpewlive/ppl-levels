local proto = {}

function proto:damage(x)
	return pewpew.add_damage_to_player_ship(self.id, x)
end
function proto:add_arrow_to_player_ship(target_id, color)
	return pewpew.add_arrow_to_player_ship(self.id, target_id, color)
end
function proto:remove_arrow_from_player_ship(arrow_id)
	return pewpew.remove_arrow_from_player_ship(self.id, arrow_id)
end
function proto:make_transparent(time)
	return pewpew.make_player_ship_transparent(self.id, time)
end
function proto:set_speed(m, v, duration)
	return pewpew.set_player_ship_speed(self.id, m, v, duration)
end
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
function proto:set_radius(x)
	return pewpew.entity_set_radius(self.id, x)
end
function proto:set_update_callback(f)
	return pewpew.entity_set_update_callback(self.id, f)
end
function proto:destroy()
	return pewpew.entity_destroy(self.id)
end

pplaf.player.prototype = proto