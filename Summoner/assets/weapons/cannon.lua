return {
	
	recharge = 60,
	
	constructor = function(weapon, args)
		
		weapon.recharge = weapon.type.recharge
		
	end,
	ai = function(weapon)
		
		if weapon.entity.state == 1 then
			return nil
		end
		
		if weapon.recharge > 0 then
			weapon.recharge = weapon.recharge - 1
			return nil
		end
		
		local ex, ey = weapon.entity:get_position()
		for i = 1fx, 4fx, 1fx do
			pplaf.entity.create(ex, ey, 'hBeta', TAU_FX / 4fx * i + weapon.entity.angle, 0x44eeaaff)
			pplaf.entity.create(ex, ey, 'hBeta', TAU_FX / 4fx * i + TAU_FX / 8fx + weapon.entity.angle, 0x88eeeeff)
		end
		
		weapon.recharge = weapon.type.recharge
		
	end
}