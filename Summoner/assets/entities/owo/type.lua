local OWO_STATE_SPAWNING = 1
local OWO_STATE_ALIVE = 2

local color_presets = {
	function()
		return {pplaf.math.random(190, 240), pplaf.math.random(40 , 80 ), pplaf.math.random(40 , 80 ), 0}
	end,
	function()
		return {pplaf.math.random(40 , 80 ), pplaf.math.random(190, 240), pplaf.math.random(40 , 80 ), 0}
	end,
	function()
		return {pplaf.math.random(40 , 80 ), pplaf.math.random(40 , 80 ), pplaf.math.random(190, 240), 0}
	end,
	function()
		return {pplaf.math.random(190, 240), pplaf.math.random(100, 150), pplaf.math.random(20 , 40 ), 0}
	end
}

return {
	union = 'player',
	
	collision = 24fx,
	attack_radius = 300fx,
	turn_ratio = 30fx,
	max_acceleration = 2fx,
	max_speed = 16fx,
	respawn_time = 45,
	respawn_time_ifx = 1fx / 45fx,
	
	constructor = function(entity, args)
		
		entity.ax = 0fx
		entity.ay = 0fx
		entity.dx = 0fx
		entity.dy = 0fx
		entity.size = 0fx
		entity.rgba = color_presets[pplaf.math.random(1, #color_presets)]()
		entity.color = make_color(entity.rgba[1], entity.rgba[2], entity.rgba[3], 255)
		entity.tick = 0
		entity.state = OWO_STATE_SPAWNING
		
		entity:set_mesh_color(0x00000000)
		entity:set_mesh('/dynamic/assets/entities/owo/mesh.lua', 0)
		table.insert(OWO, entity)
		
		entity:configure_wall_collision(true, function()
			local ex, ey = entity:get_position()
			if ex + entity.dx < 0fx or ex + entity.dx > LEVEL_WIDTH then
				entity.dx = -entity.dx
			end
			if ey + entity.dy < 0fx or ey + entity.dy > LEVEL_HEIGTH then
				entity.dy = -entity.dy
			end
		end)
		
		function entity.destroy()
			entity.state = OWO_STATE_SPAWNING
			local x, y = entity:get_position()
			pewpew.play_sound(entity.type.path .. 'sound.lua', 0, x, y)
			pewpew.create_explosion(x, y, entity.color, 0.2048fx, 12)
			entity.tick = 0
			entity.size = 0fx
			entity.rgba[4] = 0
		end
		
	end,
	ai = function(entity)
		
		local ex, ey = entity:get_position()
		local px, py = PLAYER:get_position()
		
		entity.ax = px - ex
		entity.ay = py - ey
		
		if entity.state == OWO_STATE_SPAWNING then
		
			entity.tick = entity.tick + 1
			entity.size = entity.size + entity.type.respawn_time_ifx
			entity.rgba[4] = entity.rgba[4] + 255 / entity.type.respawn_time
			entity:set_mesh_color(make_color(entity.rgba[1], entity.rgba[2], entity.rgba[3], pplaf.math.floor(entity.rgba[4])))
			entity:set_mesh_scale(entity.size)
			if entity.tick >= entity.type.respawn_time then
				entity.rgba[4] = 0
				entity.state = OWO_STATE_ALIVE
			end
			
		elseif entity.state == OWO_STATE_ALIVE then
			
			if pplaf.player.shoot_distance ~= 0fx then
				local ty, tx = fmath.sincos(pplaf.player.shoot_angle)
				local k = pplaf.player.shoot_distance * entity.type.attack_radius
				entity.ay, entity.ax = entity.ay + ty * k, entity.ax + tx * k
			end
			
		end
		
		for _, target_entity in ipairs(OWO) do
			if target_entity.id ~= entity.id then
				local tx, ty = target_entity:get_position()
				local rx, ry = tx - ex, ty - ey
				if pplaf.fxmath.abs(rx) < entity.type.collision and pplaf.fxmath.abs(ry) < entity.type.collision then
					entity.ax, entity.ay = - rx, - ry
					break
				end
			end
		end
		
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
		local v = fmath.sqrt(entity.dx * entity.dx + entity.dy * entity.dy)
		if v > entity.type.max_speed then
			local k = v / entity.type.max_speed
			if k == 0fx then
				entity.dx, entity.dy = 0fx, 0fx
			else
				entity.dx, entity.dy = entity.dx / k, entity.dy / k
			end
		end
		entity:set_position(ex + entity.dx, ey + entity.dy)
		entity:add_rotation_to_mesh(v / entity.type.turn_ratio, -entity.dy, entity.dx, 0fx)
		
	end
}