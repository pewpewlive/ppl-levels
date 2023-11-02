local MORTAR_STATE_RECHARGING = 1
local MORTAR_STATE_SPAWNING = 2
local MORTAR_STATE_PREPARING = 3

return {
	recharge = 10,
	spawn_time = 15,
	prepare_time = 35,
	constructor = function(weapon, args)
		
		weapon.recharge = -weapon.entity.type.spawn_time
		weapon.spawn_timer = 0
		weapon.prepare_timer = 0
		
		weapon.state = MORTAR_STATE_RECHARGING
		
	end,
	ai = function(weapon)
		
		if weapon.state == MORTAR_STATE_RECHARGING then
			
			weapon.recharge = weapon.recharge + 1
			if weapon.recharge == weapon.type.recharge then
				weapon.recharge = 0
				weapon.state = MORTAR_STATE_SPAWNING
				local x, y = weapon.entity:get_position()
				pplaf.entity.create(x, y, 'mine', weapon)
			end
			
		elseif weapon.state == MORTAR_STATE_SPAWNING then
			
			weapon.spawn_timer = weapon.spawn_timer + 1
			if weapon.spawn_timer == weapon.type.spawn_time then
				weapon.spawn_timer = 0
				weapon.state = MORTAR_STATE_PREPARING
			end
			
		elseif weapon.state == MORTAR_STATE_PREPARING then
			
			weapon.prepare_timer = weapon.prepare_timer + 1
			if weapon.prepare_timer == weapon.type.prepare_time then
				weapon.prepare_timer = 0
				weapon.state = MORTAR_STATE_RECHARGING
			end
			
		end
		
	end
}