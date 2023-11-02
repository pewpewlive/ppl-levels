
pplaf.player = {
	
	move_angle = 0fx,
	move_distance = 0fx,
	shoot_angle = 0fx,
	shoot_distance = 0fx,
	
	create = function(x, y, args)
		local id = pewpew.new_player_ship(x, y, 0)
		local player = {
										id = id,
										type = pplaf.entity.type.pewpew_player
										}
		--player.weapons = pplaf.weapon.create(player, 'pewpew_player')
		if pplaf.entity.type.pewpew_player.constructor then
			pplaf.entity.type.pewpew_player.constructor(player, args)
		end
		if pplaf.entity.type.pewpew_player.destructor then
			function player:destroy()
				pplaf.entity.type.pewpew_player.destructor(self)
				pplaf.entities[self.union][self.id] = nil
			end
		end
		if pplaf.settings.copy_ppl_methods_to_player then
			setmetatable(player, {__index = pplaf.player.prototype})
		end
		return player
	end,
	
	main = function()
		pplaf.player.move_angle, pplaf.player.move_distance,
		pplaf.player.shoot_angle, pplaf.player.shoot_distance = pewpew.get_player_inputs(0)
	end,
	
	get_inputs = function()
		return 	pplaf.player.move_angle, pplaf.player.move_distance,
						pplaf.player.shoot_angle, pplaf.player.shoot_distance
	end,
	
	get_move_inputs = function()
		return pplaf.player.move_angle, pplaf.player.move_distance
	end,
	
	get_shoot_inputs = function()
		return pplaf.player.shoot_angle, pplaf.player.shoot_distance
	end
	
}
