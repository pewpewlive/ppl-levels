local LASER_STATE_RECHARGING = 1
local LASER_STATE_PREPARING = 2
local LASER_STATE_SHOOTING = 3

return {
	recharge = 180,
	prepare_time = 80,
	shooting_time = 42,
	speed_penalty = 0.3810fx,
	constructor = function(weapon, args)
		
		weapon.recharge = -weapon.entity.type.spawn_time
		weapon.prepare_timer = 0
		weapon.shooting_timer = 0
		
		weapon.state = LASER_STATE_RECHARGING
		
	end,
	ai = function(weapon)
		
		if weapon.state == LASER_STATE_RECHARGING then
			
			weapon.recharge = weapon.recharge + 1
			if weapon.recharge == weapon.type.recharge then
				weapon.recharge = 0
				weapon.state = LASER_STATE_PREPARING
				local x, y = weapon.entity:get_position()
				for i = 1fx, 6fx, 1fx do
					pplaf.entity.create(x, y, 'laser', weapon, PI_FX * (i / 3fx + 1fx / 6fx))
				end
				pewpew.play_sound('/dynamic/assets/weapons/overlord_laser_sound.lua', 0, x, y)
				weapon.entity.invulnerable = true
			end
			
		elseif weapon.state == LASER_STATE_PREPARING then
			
			weapon.prepare_timer = weapon.prepare_timer + 1
			weapon.entity.dx = weapon.entity.dx * weapon.type.speed_penalty
			weapon.entity.dy = weapon.entity.dy * weapon.type.speed_penalty
			if weapon.prepare_timer == weapon.type.prepare_time then
				weapon.prepare_timer = 0
				weapon.state = LASER_STATE_SHOOTING
			end
			
		elseif weapon.state == LASER_STATE_SHOOTING then
			
			weapon.shooting_timer = weapon.shooting_timer + 1
			weapon.entity.dx = weapon.entity.dx * weapon.type.speed_penalty
			weapon.entity.dy = weapon.entity.dy * weapon.type.speed_penalty
			if weapon.shooting_timer == weapon.type.shooting_time then
				weapon.shooting_timer = 0
				weapon.state = LASER_STATE_RECHARGING
				weapon.entity.rotation_speed = weapon.entity.type.rotation_speed
				weapon.entity.invulnerable = false
			end
			
		end
		
	end
}