local DIAMOND_STATE_SPAWNING = 1
local DIAMOND_STATE_MOVING = 2
local DIAMOND_STATE_SHOOTING = 3

return {
	union = 'enemy',
	
	hp = 12,
	collision = 54fx,
	spawn_time = 60,
	max_speed = 3fx,
	
	weapons = {'cannon'},
	
	constructor = function(entity, args)
		
		entity.hp = entity.type.hp
		entity.dy, entity.dx = fmath.sincos(args[1])
		entity.dy, entity.dx = entity.dy * entity.type.max_speed, entity.dx * entity.type.max_speed
		entity.angle = 0fx
		entity.tick = 0
		entity.state = DIAMOND_STATE_SPAWNING
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
		local ex, ey = entity:get_position()
		pewpew.play_sound(entity.type.path .. 'sound.lua', 0, ex, ey)
		entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
		entity:start_exploding(40)
		if entity.reward then
			pewpew.increase_score_of_player(0, 8)
			ACHIEVEMENT_PROGRESS_DESTROY_10_DIAMONDS = ACHIEVEMENT_PROGRESS_DESTROY_10_DIAMONDS + 1
		end
	end,
	
	ai = function(entity)
		
		if entity.damaged > 0 then
			entity.damaged = entity.damaged - 1
			if entity.damaged == 0 then
				entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
			end
		end
		entity.angle = entity.angle + 0.512fx
		entity:set_mesh_angle(entity.angle, 0fx, 0fx, -1fx)
		
		if entity.state == DIAMOND_STATE_MOVING then
			
			local ex, ey = entity:get_position()
			entity:set_position(ex + entity.dx, ey + entity.dy)
			
			local px, py = PLAYER:get_position()
			if pplaf.fxmath.abs(px - ex) < DIAMOND_PLAYER_COLLISION and pplaf.fxmath.abs(py - ey) < DIAMOND_PLAYER_COLLISION then
				entity.reward = true
				pewpew.add_damage_to_player_ship(PLAYER.id, 1)
				entity:destroy()
				return nil
			end
			for id, owo in ipairs(OWO) do
				local ox, oy = owo:get_position()
				if pplaf.fxmath.abs(ox - ex) < DIAMOND_OWO_COLLISION and pplaf.fxmath.abs(oy - ey) < DIAMOND_OWO_COLLISION and owo.state == 2 then
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
			
		elseif entity.state == DIAMOND_STATE_SPAWNING then
			
			entity.tick = entity.tick + 1
			if entity.tick == entity.type.spawn_time then
				entity.state = DIAMOND_STATE_MOVING
			end
			
		end
		
	end
}