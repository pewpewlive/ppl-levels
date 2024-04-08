
-- math because somebody decided to just remove it from this Lua environment

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
  
  fraction = function(a)
    return a % 1
  end,
  
  random = __DEF_FMATH_RANDOM_INT,
  
  sqrt = function(a)
    return a ^ 0.5
  end,
  
  length = function(...)
    local args = {...}
    if #args == 2 then -- dx, dy
      return (args[1] ^ 2 + args[2] ^ 2) ^ 0.5
    end
    if #args == 4 then -- x1, y1, x2, y2
      return ((args[3] - args[1]) ^ 2 + (args[4] - args[2]) ^ 2) ^ 0.5
    end
  end,
  
  sqlen = function(...) -- squared length
    local args = {...}
    if #args == 2 then -- dx, dy
      return args[1] ^ 2 + args[2] ^ 2
    end
    if #args == 4 then -- x1, y1, x2, y2
      return (args[3] - args[1]) ^ 2 + (args[4] - args[2]) ^ 2
    end
  end,
  
}
