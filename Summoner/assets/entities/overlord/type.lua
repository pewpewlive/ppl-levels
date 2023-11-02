local OVERLORD_STATE_SPAWNING = 1
local OVERLORD_STATE_ALIVE = 2

return {
	union = 'enemy',
	
	hp = 64,
	collision = 100fx,
	spawn_time = 120,
	max_acceleration = 0.768fx,
	friction = 0.3600fx,
	
	weapons = {'overlord_laser', 'mortar'},
	
	constructor = function(entity, args)
		
		entity.hp = entity.type.hp
		entity.invulnerable = false
		entity.ax = 0fx
		entity.ay = 0fx
		entity.dx = 0fx
		entity.dy = 0fx
		entity.angle = 0fx
		entity.tick = 0
		entity.state = OVERLORD_STATE_SPAWNING
		entity.damaged = 0
		entity.reward = false
		
		entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
		entity:start_spawning(entity.type.spawn_time)
		
		entity:configure_wall_collision(true, function()
			local ex, ey = entity:get_position()
			if ex + entity.dx < 0fx or ex + entity.dx > LEVEL_WIDTH then
				entity.dx = entity.dx * entity.type.friction
			end
			if ey + entity.dy < 0fx or ey + entity.dy > LEVEL_HEIGTH then
				entity.dy = entity.dy * entity.type.friction
			end
		end)
		
	end,
	
	destructor = function(entity)
		entity.type.hp = entity.type.hp + 2
		local ex, ey = entity:get_position()
		pewpew.play_sound(entity.type.path .. 'sound.lua', 0, ex, ey)
		entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
		entity:start_exploding(90)
		if entity.reward then
			pewpew.increase_score_of_player(0, 64)
		end
	end,
	
	ai = function(entity)
		
		if entity.damaged > 0 then
			entity.damaged = entity.damaged - 1
			if entity.damaged == 0 then
				entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
			end
		end
		if entity.state == OVERLORD_STATE_SPAWNING then
			
			entity.tick = entity.tick + 1
			if entity.tick == entity.type.spawn_time then
				entity.state = OVERLORD_STATE_ALIVE
			end
			
		elseif entity.state == OVERLORD_STATE_ALIVE then
			
			local px, py = PLAYER:get_position()
			local ex, ey = entity:get_position()
			
			entity.ax = px - ex
			entity.ay = py - ey
			
			local av = fmath.sqrt(entity.ax * entity.ax + entity.ay * entity.ay)
			if av > entity.type.max_acceleration then
				local k = av / entity.type.max_acceleration
				if k == 0fx then
					entity.ax, entity.ay = 0fx, 0fx
				else
					entity.ax, entity.ay = entity.ax / k, entity.ay / k
				end
			end
			entity.dx, entity.dy = entity.dx + entity.ax, entity.dy + entity.ay
			entity:set_position(ex + entity.dx, ey + entity.dy)
			entity.angle = entity.angle + pplaf.fxmath.length(entity.dx, entity.dy) / 128fx
			entity:set_mesh_angle(entity.angle, 0fx, 0fx, 1fx)
			
			if entity.invulnerable then
				
				for id, owo in ipairs(OWO) do
					local ox, oy = owo:get_position()
					if pplaf.fxmath.abs(ox - ex) < OVERLORD_OWO_COLLISION and pplaf.fxmath.abs(oy - ey) < OVERLORD_OWO_COLLISION and owo.state == 2 then
						owo.destroy()
					end
				end
				
			else
				
				if pplaf.fxmath.abs(px - ex) < OVERLORD_PLAYER_COLLISION and pplaf.fxmath.abs(py - ey) < OVERLORD_PLAYER_COLLISION then
					pewpew.add_damage_to_player_ship(PLAYER.id, 1)
					entity.damaged = 6
					entity:set_mesh(entity.type.path .. 'mesh.lua', 1)
					entity.hp = entity.hp - 24
					if entity.hp <= 0 then
						entity.reward = true
						entity:destroy()
						ACHIEVEMENT_PROGRESS_DESTROY_OVERLORD_BY_MELEE = true
						return nil
					end
				end
				for id, owo in ipairs(OWO) do
					local ox, oy = owo:get_position()
					if pplaf.fxmath.abs(ox - ex) < OVERLORD_OWO_COLLISION and pplaf.fxmath.abs(oy - ey) < OVERLORD_OWO_COLLISION and owo.state == 2 then
						owo.destroy()
						entity.damaged = 6
						entity:set_mesh(entity.type.path .. 'mesh.lua', 1)
						entity.hp = entity.hp - 1
						if entity.hp <= 0 then
							entity.reward = true
							entity:destroy()
							return nil
						end
					end
				end
				
			end
			
		end
		
	end
}