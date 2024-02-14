local CUBE_STATE_SPAWNING = 1
local CUBE_STATE_ALIVE = 2

return {
	union = 'enemy',
	
	collision = 40fx,
	spawn_time = 60,
	
	constructor = function(entity, args)
		
		entity.dx, entity.dy = args[1], args[2]
		entity.turn_angle = fmath.sqrt(entity.dx * entity.dx + entity.dy * entity.dy) / TAU_FX / 6fx
		entity.tick = 0
		entity.state = CUBE_STATE_SPAWNING
		entity.reward = false
		
		entity:set_mesh_angle(fmath.atan2(entity.dy, entity.dx), 0fx, 0fx, 1fx)
		entity:set_mesh_color(args[3])
		entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
		entity:start_spawning(entity.type.spawn_time)
		
		entity:configure_wall_collision(true, function()
			local ex, ey = entity:get_position()
			if ex + entity.dx < 0fx or ex + entity.dx > LEVEL_WIDTH then
				entity.dx = -entity.dx
			end
			if ey + entity.dy < 0fx or ey + entity.dy > LEVEL_HEIGTH then
				entity.dy = -entity.dy
			end
		end)
		
	end,
	
	destructor = function(entity)
		local ex, ey = entity:get_position()
		pewpew.play_sound(entity.type.path .. 'sound.lua', 0, ex, ey)
		entity:start_exploding(20)
		if entity.reward then
			pewpew.increase_score_of_player(0, 1)
			ACHIEVEMENT_PROGRESS_DESTROY_50_CUBES = ACHIEVEMENT_PROGRESS_DESTROY_50_CUBES + 1
		end
	end,
	
	ai = function(entity)
		
		if entity.state == CUBE_STATE_ALIVE then
			
			local ex, ey = entity:get_position()
			entity:set_position(ex + entity.dx, ey + entity.dy)
			entity:add_rotation_to_mesh(entity.turn_angle, -entity.dy, entity.dx, 0fx)
			
			local px, py = PLAYER:get_position()
			if pplaf.fxmath.abs(px - ex) < CUBE_PLAYER_COLLISION and pplaf.fxmath.abs(py - ey) < CUBE_PLAYER_COLLISION then
				entity.reward = true
				pewpew.add_damage_to_player_ship(PLAYER.id, 1)
				entity:destroy()
				return nil
			end
			for id, owo in ipairs(OWO) do
				local ox, oy = owo:get_position()
				if pplaf.fxmath.abs(ox - ex) < CUBE_OWO_COLLISION and pplaf.fxmath.abs(oy - ey) < CUBE_OWO_COLLISION and owo.state == 2 then
					entity.reward = true
					owo.destroy()
					entity:destroy()
					return nil
				end
			end
			
		elseif entity.state == CUBE_STATE_SPAWNING then
			
			entity.tick = entity.tick + 1
			if entity.tick == entity.type.spawn_time then
				entity.state = CUBE_STATE_ALIVE
			end
			
		end
		
	end
}