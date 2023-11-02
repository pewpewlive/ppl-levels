return {
	union = 'enemy_bullets',
	
	max_speed = 2fx,
	
	constructor = function(entity, args)
		
		entity.dy, entity.dx = fmath.sincos(args[1])
		entity.dy, entity.dx = entity.dy * entity.type.max_speed, entity.dx * entity.type.max_speed
		entity.color = args[2]
		
		entity:configure_wall_collision(true, function()
			entity:destroy()
		end)
		
		entity:set_mesh_angle(pplaf.fxmath.random(0fx, TAU_FX), pplaf.fxmath.random(0fx, TAU_FX), pplaf.fxmath.random(0fx, TAU_FX), pplaf.fxmath.random(0fx, TAU_FX))
		entity:set_mesh_color(args[2])
		entity:start_spawning(0)
		entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
		
	end,
	destructor = function(entity)
		pewpew.entity_destroy(entity.id)
		local x, y = entity:get_position()
		pewpew.create_explosion(x, y, entity.color, 0.1024fx, 6)
	end,
	ai = function(entity)
		
		local ex, ey = entity:get_position()
		entity:set_position(ex + entity.dx, ey + entity.dy)
		entity:add_rotation_to_mesh(0.512fx, entity.dx, entity.dy, 0fx)
		
		local px, py = PLAYER:get_position()
		if pplaf.fxmath.abs(px - ex) < PLAYER_COLLISION2 and pplaf.fxmath.abs(py - ey) < PLAYER_COLLISION2 then
			pewpew.add_damage_to_player_ship(PLAYER.id, 1)
			entity:destroy()
			return nil
		end
		for id, owo in ipairs(OWO) do
			local ox, oy = owo:get_position()
			if pplaf.fxmath.abs(ox - ex) < OWO_COLLISION2 and pplaf.fxmath.abs(oy - ey) < OWO_COLLISION2 and owo.state == 2 then
				owo.destroy()
				entity:destroy()
				return nil
			end
		end
		
	end
}