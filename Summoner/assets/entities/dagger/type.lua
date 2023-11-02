local DAGGER_STATE_SPAWNING = 1
local DAGGER_STATE_RECHARGING = 2
local DAGGER_STATE_DASH = 3

return {
	union = 'enemy',
	
	hp = 3,
	collision = 40fx,
	recharge = 60fx,
	spawn_time = 60fx,
	max_speed = 20fx,
	stop_time = 60fx,
	
	constructor = function(entity, args)
		
		entity.hp = entity.type.hp
		entity.dx = 0fx
		entity.dy = 0fx
		entity.tick = 0fx
		entity.angle = 0fx
		entity.recharge = 0fx
		entity.state = DAGGER_STATE_SPAWNING
		entity.damaged = 0
		entity.reward = false
		
		entity:configure_wall_collision(true, function()
			local ex, ey = entity:get_position()
			if ex + entity.dx < 0fx or ex + entity.dx > LEVEL_WIDTH then
				entity.dx = -entity.dx
			end
			if ey + entity.dy < 0fx or ey + entity.dy > LEVEL_HEIGTH then
				entity.dy = -entity.dy
			end
		end)
		
		local px, py = PLAYER:get_position()
		local ex, ey = entity:get_position()
		
		entity:set_mesh_angle(fmath.atan2(py - ey, px - ex), 0fx, 0fx, 1fx)
		entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
		entity:start_spawning(pplaf.fxmath.to_int(entity.type.spawn_time))
		
	end,
	destructor = function(entity)
		local ex, ey = entity:get_position()
		pewpew.play_sound(entity.type.path .. 'sound.lua', 0, ex, ey)
		entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
		entity:start_exploding(30)
		if entity.reward then
			pewpew.increase_score_of_player(0, 3)
			ACHIEVEMENT_PROGRESS_DESTROY_25_DAGGERS = ACHIEVEMENT_PROGRESS_DESTROY_25_DAGGERS + 1
		end
	end,
	ai = function(entity)
		
		if entity.damaged > 0 then
			entity.damaged = entity.damaged - 1
			if entity.damaged == 0 then
				entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
			end
		end
		local ex, ey = entity:get_position()
		
		if entity.state == DAGGER_STATE_SPAWNING then
			
			entity.tick = entity.tick + 1fx
			if entity.tick == entity.type.spawn_time then
				entity.tick = 0fx
				entity.state = DAGGER_STATE_RECHARGING
			end
			
		elseif entity.state == DAGGER_STATE_RECHARGING then
			
			entity.recharge = entity.recharge + 1fx
			entity.angle = entity.angle + 0.64fx
			entity:add_rotation_to_mesh(entity.angle, 0fx, 0fx, 1fx)
			if entity.recharge == entity.type.recharge then
				entity.recharge = 0fx
				entity.state = DAGGER_STATE_DASH
				local px, py = PLAYER:get_position()
				entity.dx, entity.dy = px - ex, py - ey
				local v = fmath.sqrt(entity.dx * entity.dx + entity.dy * entity.dy)
				if v > entity.type.max_speed then
					local k = entity.type.max_speed / v
					entity.dx, entity.dy = entity.dx * k, entity.dy * k
				end
			end
			
		elseif entity.state == DAGGER_STATE_DASH then
			
			entity.tick = entity.tick + 1fx
			local k = 1fx - entity.tick / entity.type.stop_time
			entity:set_position(ex + entity.dx * k, ey + entity.dy * k)
			entity:add_rotation_to_mesh(entity.angle * k, 0fx, 0fx, 1fx)
			if entity.tick == entity.type.stop_time then
				entity.tick = 0fx
				entity.angle = 0fx
				entity.state = DAGGER_STATE_RECHARGING
			end
			
		end
		
		if entity.state ~= DAGGER_STATE_SPAWNING then
			
			local px, py = PLAYER:get_position()
			if pplaf.fxmath.abs(px - ex) < DAGGER_PLAYER_COLLISION and pplaf.fxmath.abs(py - ey) < DAGGER_PLAYER_COLLISION then
				entity.reward = true
				pewpew.add_damage_to_player_ship(PLAYER.id, 1)
				entity:destroy()
				return nil
			end
			for id, owo in ipairs(OWO) do
				local ox, oy = owo:get_position()
				if pplaf.fxmath.abs(ox - ex) < DAGGER_OWO_COLLISION and pplaf.fxmath.abs(oy - ey) < DAGGER_OWO_COLLISION and owo.state == 2 then
					owo.destroy()
					entity.damaged = 6
					entity:set_mesh(entity.type.path .. 'mesh.lua', 1)
					entity.hp = entity.hp - 1
					if entity.hp == 0 then
						entity.reward = true
						entity:destroy()
						return nil
					end
				end
			end
			
		end
		
	end
}