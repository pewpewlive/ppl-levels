local HOLEY_STATE_SPAWNING = 1
local HOLEY_STATE_ALIVE = 2

return {
	union = 'enemy',
	
	hp = 36,
	collision = 72fx,
	spawn_time = 75,
	max_speed = 2fx,
	
	weapons = {'holey_cannon'},
	
	constructor = function(entity, args)
		
		entity.hp = entity.type.hp
		entity.dy, entity.dx = fmath.sincos(args[1])
		entity.dy, entity.dx = entity.dy * entity.type.max_speed, entity.dx * entity.type.max_speed
		entity.tick = 0
		entity.state = HOLEY_STATE_SPAWNING
		entity.damaged = 0
		entity.reward = false
		
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
		entity.type.hp = entity.type.hp + 1
		local ex, ey = entity:get_position()
		pewpew.play_sound(entity.type.path .. 'sound.lua', 0, ex, ey)
		entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
		entity:start_exploding(60)
		if entity.reward then
			pewpew.increase_score_of_player(0, 24)
			ACHIEVEMENT_DESTROY_HOLEY = true
		end
	end,
	
	ai = function(entity)
		
		if entity.damaged > 0 then
			entity.damaged = entity.damaged - 1
			if entity.damaged == 0 then
				entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
			end
		end
		entity:add_rotation_to_mesh(0.512fx, 0fx, 0fx, 1fx)
		local ex, ey = entity:get_position()
		local px, py = PLAYER:get_position()
		
		if entity.state == HOLEY_STATE_ALIVE then
			
			entity:set_position(ex + entity.dx, ey + entity.dy)
			
		elseif entity.state == HOLEY_STATE_SPAWNING then
			
			entity.tick = entity.tick + 1
			if entity.tick == entity.type.spawn_time then
				entity.state = HOLEY_STATE_ALIVE
			end
			
		end
		
		if entity.state ~= HOLEY_STATE_SPAWNING then
			
			local px, py = PLAYER:get_position()
			if pplaf.fxmath.abs(px - ex) < HOLEY_PLAYER_COLLISION and pplaf.fxmath.abs(py - ey) < HOLEY_PLAYER_COLLISION then
				pewpew.add_damage_to_player_ship(PLAYER.id, 1)
				entity.hp = entity.hp - 12
				if entity.hp <= 0 then
					entity.reward = true
					entity:destroy()
					return nil
				end
			end
			for id, owo in ipairs(OWO) do
				local ox, oy = owo:get_position()
				if pplaf.fxmath.abs(ox - ex) < HOLEY_OWO_COLLISION and pplaf.fxmath.abs(oy - ey) < HOLEY_OWO_COLLISION and owo.state == 2 then
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
}