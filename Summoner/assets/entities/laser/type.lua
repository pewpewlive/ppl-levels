local LASER_STATE_ALIVE = 1
local LASER_STATE_DYING = 2

return {
	union = 'enemy',
	
	max_alpha = 210,
	fade_time = 30,
	
	constructor = function(entity, args)
		
		entity.milestone = false
		entity.parent = args[1]
		entity.alpha = 0
		if args[2] then
			entity.angle_offset = args[2]
		else
			entity.angle_offset = 0fx
		end
		entity.angle = 0fx
		entity.tick = 0
		entity.state = LASER_STATE_ALIVE
		
		entity:start_spawning(0)
		entity:set_mesh(entity.type.path .. 'mesh.lua', 0)
		entity:set_mesh_color(0x00000000)
		
	end,
	
	destructor = function(entity)
		pewpew.entity_destroy(entity.id)
	end,
	
	ai = function(entity)
		
		if entity.state == LASER_STATE_ALIVE then
			
			entity.angle = entity.parent.entity.angle + entity.angle_offset
			entity:set_mesh_angle(entity.angle, 0fx, 0fx, 1fx)
			entity:set_position(entity.parent.entity:get_position())
			if entity.parent.state == 2 then
				entity:set_mesh_color(make_color(255, 31, 31, pplaf.math.floor(entity.parent.prepare_timer / entity.parent.type.prepare_time * entity.type.max_alpha)))
			elseif entity.parent.state == 3 then
				if not entity.milestone then
					entity:set_mesh_color(0xffffffff)
					entity:set_mesh(entity.type.path .. 'mesh.lua', 1)
					entity.milestone = true
				end
				
				local ex, ey = entity:get_position()
				local px, py = PLAYER:get_position()
				
				local dx, dy = px - ex, py - ey
				local ang = fmath.atan2(dy, dx) - entity.angle
				local sin = fmath.sincos(ang)
				if not PLAYER.invulnerable_b and pplaf.fxmath.abs(ang % TAU_FX) <= PI_FX / 2fx and pplaf.fxmath.abs(fmath.sqrt(dx * dx + dy * dy) * sin) < PLAYER_RADIUS then
					pewpew.add_damage_to_player_ship(PLAYER.id, 1)
					PLAYER.invulnerable = 30
					PLAYER.invulnerable_b = true
				end
				
				for id, owo in ipairs(OWO) do
					local ox, oy = owo:get_position()
					local dx, dy = ox - ex, oy - ey
					local ang = fmath.atan2(dy, dx) - entity.angle
					local sin = fmath.sincos(ang)
					if owo.state == 2 and pplaf.fxmath.abs(ang % TAU_FX) <= PI_FX / 2fx and pplaf.fxmath.abs(fmath.sqrt(dx * dx + dy * dy) * sin) < OWO_RADIUS then
						owo.destroy()
					end
				end
				
			elseif entity.parent.state == 1 then
				entity.state = LASER_STATE_DYING
			end
			
		else
			
			entity.tick = entity.tick + 1
			entity:set_mesh_color(make_color(255, 255, 255, pplaf.math.floor((1 - entity.tick / entity.type.fade_time) * entity.type.max_alpha)))
			if entity.tick == entity.type.fade_time then
				entity:destroy()
			end
			
		end
		
	end
}