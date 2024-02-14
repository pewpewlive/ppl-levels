return {
	
	recharge = 60,
	
	constructor = function(weapon, args)
		
		weapon.tick = -1
		weapon.state = 1
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
		
		weapon.entity.state = 3
		local px, py = PLAYER:get_position()
		local ex, ey = weapon.entity:get_position()
		
		if			weapon.state == 1 then -- 1
		
			if weapon.tick % 15 == 0 then
				local offset = fmath.to_fixedpoint(weapon.tick) / 9fx
				for i = 1fx, 6fx, 1fx do
					pplaf.entity.create(ex, ey, 'hBeta', TAU_FX / 6fx * (i + offset), 0xee9922dd)
				end
			end
			if weapon.tick == 45 then
				weapon.tick = -1
				weapon.recharge = weapon.type.recharge
				weapon.state = weapon.state + 1
				weapon.entity.state = 2
			end
			
		elseif	weapon.state == 2 then -- 2
		
			if weapon.tick % 20 == 0 then
				local offset = fmath.to_fixedpoint(weapon.tick) / 40fx
				for i = 1fx, 16fx, 1fx do
					pplaf.entity.create(ex, ey, 'hBeta', TAU_FX / 16fx * (i + offset), 0x33ee33dd)
				end
			end
			if weapon.tick == 20 then
				weapon.tick = -1
				weapon.recharge = weapon.type.recharge
				weapon.state = weapon.state + 1
				weapon.entity.state = 2
			end
			
		elseif	weapon.state == 3 then -- 3
		
			if weapon.tick % 30 == 0 then
				local offset = fmath.to_fixedpoint(weapon.tick) / 60fx
				for h = 1fx, 3fx, 1fx do
					local k = 18fx * (h + offset)
					for i = 1fx, 6fx, 1fx do
						pplaf.entity.create(ex, ey, 'hBeta', TAU_FX / 54fx * (i + k), 0xdd33ddff)
					end
				end
			end
			if weapon.tick == 30 then
				weapon.recharge = 30
				weapon.state = weapon.state + 1
			end
			
		elseif	weapon.state == 4 then -- 4
		
			for i = 1fx, 28fx, 1fx do
				pplaf.entity.create(ex, ey, 'hBeta', TAU_FX / 28fx * i, 0x6666ddff)
			end
			weapon.tick = -1
			weapon.recharge = weapon.type.recharge
			weapon.state = weapon.state + 1
			weapon.entity.state = 2
			
		elseif	weapon.state == 5 then -- 6
		
			if weapon.tick % 5 == 0 then
				pplaf.entity.create(ex, ey, 'hAlpha', TAU_FX / 35fx * (fmath.to_fixedpoint(weapon.tick)), 0xff4444dd)
			end
			if weapon.tick == 30 then
				weapon.tick = -1
				weapon.recharge = weapon.type.recharge
				weapon.state = weapon.state + 1
				weapon.entity.state = 2
			end
			
		elseif	weapon.state == 6 then -- 7
		
			if weapon.tick % 10 == 0 then
				local offset = fmath.to_fixedpoint(weapon.tick) / 13fx
				for i = 1fx, 8fx, 1fx do
					pplaf.entity.create(ex, ey, 'hBeta', TAU_FX / 8fx * (i + offset), 0xaaaa33ff)
				end
			end
			if weapon.tick == 90 then
				weapon.tick = -1
				weapon.recharge = weapon.type.recharge
				weapon.state = 1
				weapon.entity.state = 2
			end
			
		end
		
		weapon.tick = weapon.tick + 1
		
	end
}