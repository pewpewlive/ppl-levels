local MINE_STATE_SPAWNING = 1
local MINE_STATE_PREPARING = 2
local MINE_STATE_DASH = 3

return {
	union = 'enemy',
	
	hp = 4,
	collision = 24fx,
	max_speed = 14fx,
	friction = 0.3870fx,
	lifetime = 600,
	
	constructor = function(entity, args)
		
		entity.hp = entity.type.hp
		entity.dx = 0fx
		entity.dy = 0fx
		entity.rotation = 0fx
		entity.lifetime = entity.type.lifetime
		entity.parent = args[1]
		entity.state = MINE_STATE_SPAWNING
		entity.damaged = 0
		
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
		entity:start_spawning(pplaf.fxmath.to_int(entity.parent.type.spawn_time))
		
	end,
	destructor = function(entity)
		entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
		pewpew.customizable_entity_start_exploding(entity.id, 30)
	end,
	ai = function(entity)
		
		if entity.damaged > 0 then
			entity.damaged = entity.damaged - 1
			if entity.damaged == 0 then
				entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
			end
		end
		if not is_alive(entity.parent.entity.id) then
			entity:destroy()
		end
		
		local ex, ey = entity:get_position()
		local px, py = PLAYER:get_position()
		if entity.state == MINE_STATE_SPAWNING then
			
			entity:set_position(entity.parent.entity:get_position())
			if entity.parent.state == 3 then
				entity.state = MINE_STATE_PREPARING
			end
			
		elseif entity.state == MINE_STATE_PREPARING then
			
			entity:set_position(entity.parent.entity:get_position())
			entity.rotation = entity.rotation - 0.128fx
			entity:add_rotation_to_mesh(entity.rotation, 0fx, 0fx, 1fx)
			if entity.parent.state == 1 then
				entity.state = MINE_STATE_DASH
				entity.dx, entity.dy = px - ex, py - ey
				local v = fmath.sqrt(entity.dx * entity.dx + entity.dy * entity.dy)
				if v > entity.type.max_speed then
					local k = entity.type.max_speed / v
					entity.dx, entity.dy = entity.dx * k, entity.dy * k
				end
			end
			
		elseif entity.state == MINE_STATE_DASH then
			
			entity:set_position(ex + entity.dx, ey + entity.dy)
			entity.dx = entity.dx * entity.type.friction
			entity.dy = entity.dy * entity.type.friction
			entity.rotation = entity.rotation * entity.type.friction
			entity:add_rotation_to_mesh(entity.rotation, 0fx, 0fx, 1fx)
			if entity.dx == 0fx and entity.dy == 0fx then
				entity.state = MINE_STATE_DEPLOYED
				entity:configure_wall_collision(false)
			end
			
		elseif entity.state == MINE_STATE_DEPLOYED then
			
			entity.lifetime = entity.lifetime - 1
			if entity.lifetime == 0 then
				entity.state = MINE_STATE_DEAD
				entity:destroy()
			end
			
		end
		
		if entity.state ~= MINE_STATE_SPAWNING then
			
			if pplaf.fxmath.abs(px - ex) < WARDEN_MINE_PLAYER_COLLISION and pplaf.fxmath.abs(py - ey) < WARDEN_MINE_PLAYER_COLLISION then
				pewpew.add_damage_to_player_ship(PLAYER.id, 1)
				entity:destroy()
				return nil
			end
			for id, owo in ipairs(OWO) do
				local ox, oy = owo:get_position()
				if pplaf.fxmath.abs(ox - ex) < WARDEN_MINE_OWO_COLLISION and pplaf.fxmath.abs(oy - ey) < WARDEN_MINE_OWO_COLLISION and owo.state == 2 then
					owo.destroy()
					entity.damaged = 6
					entity:set_mesh(entity.type.path .. 'mesh.lua', 1)
					entity.hp = entity.hp - 1
					if entity.hp == 0 then
						entity:destroy()
						return nil
					end
				end
			end
			
		end
		
	end
}