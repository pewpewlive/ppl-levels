local HEXO_STATE_SPAWNING = 1
local HEXO_STATE_ALIVE = 2

return {
	union = 'enemy',
	
	hp = 10,
	collision = 48fx,
	spawn_time = 60,
	rotation_speed = 0.256fx,
	
	weapons = {'laser'},
	
	constructor = function(entity, args)
		
		entity.hp = entity.type.hp
		entity.invulnerable = false
		entity.tick = 0
		entity.angle = 0fx
		entity.rotation_speed = entity.type.rotation_speed
		entity.state = HEXO_STATE_SPAWNING
		entity.damaged = 0
		entity.reward = false
		
		entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
		entity:start_spawning(entity.type.spawn_time)
		
	end,
	
	destructor = function(entity)
		local ex, ey = entity:get_position()
		pewpew.play_sound(entity.type.path .. 'sound.lua', 0, ex, ey)
		entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
		entity:start_exploding(40)
		if entity.reward then
			pewpew.increase_score_of_player(0, 6)
		end
	end,
	
	ai = function(entity)
		
		if entity.damaged > 0 then
			entity.damaged = entity.damaged - 1
			if entity.damaged == 0 then
				entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
			end
		end
		local px, py = PLAYER:get_position()
		local ex, ey = entity:get_position()
		
		if entity.state == HEXO_STATE_SPAWNING then
			
			entity.tick = entity.tick + 1
			if entity.tick == entity.type.spawn_time then
				entity.state = HEXO_STATE_ALIVE
			end
			
		elseif entity.invulnerable then
			
			for id, owo in ipairs(OWO) do
				local ox, oy = owo:get_position()
				if pplaf.fxmath.abs(ox - ex) < HEXO_OWO_COLLISION and pplaf.fxmath.abs(oy - ey) < HEXO_OWO_COLLISION and owo.state == 2 then
					owo.destroy()
				end
			end
			
		else
			
			if pplaf.fxmath.abs(px - ex) < HEXO_PLAYER_COLLISION and pplaf.fxmath.abs(py - ey) < HEXO_PLAYER_COLLISION then
				entity.reward = true
				pewpew.add_damage_to_player_ship(PLAYER.id, 1)
				entity:destroy()
				return nil
			end
			for id, owo in ipairs(OWO) do
				local ox, oy = owo:get_position()
				if pplaf.fxmath.abs(ox - ex) < HEXO_OWO_COLLISION and pplaf.fxmath.abs(oy - ey) < HEXO_OWO_COLLISION and owo.state == 2 then
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
		
		local angle_change = fmath.atan2(py - ey, px - ex) - entity.angle % TAU_FX
		
		if angle_change > PI_FX then
			angle_change = PI_FX - angle_change
		elseif angle_change < -PI_FX then
			angle_change = -PI_FX - angle_change
		end
		if angle_change > entity.rotation_speed then
			angle_change = entity.rotation_speed
		elseif angle_change < -entity.rotation_speed then
			angle_change = -entity.rotation_speed
		end
		entity.angle = entity.angle + angle_change
		
		entity:set_mesh_angle(entity.angle, 0fx, 0fx, 1fx)
		
	end
}