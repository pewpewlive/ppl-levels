
pplaf.math = {
	
	abs = function(a)
		return a < 0 and -a or a
	end,
	
	floor = function(a)
		return a // 1
	end,
	
	ceil = function(a)
		return (a + 1) // 1
	end,
	
	round = function(a)
		return (a + 0.5) // 1
	end,
	
	random = fmath.random_int,
	
	sqrt = function(a)
		return a ^ 0.5
	end,
	
	min = function(a, b)
		if a > b then
			return b
		end
		return a
	end,
	
	max = function(a, b)
		if a > b then
			return a
		end
		return b
	end,
	
	length = function(...)
		local args = {...}
		if #args == 2 then return pplaf.math.sqrt(args[1] ^ 2 + args[2] ^ 2) end --dx, dy
		if #args == 4 then --x1, y1, x2, y2
			return pplaf.math.sqrt((args[3] - args[1]) ^ 2 + (args[4] - args[2]) ^ 2)
		end
	end
	
}
