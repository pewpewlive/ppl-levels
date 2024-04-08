
-- fmath is fine, but
-- literally copies half of fmath

pplaf.fmath = {
  
  abs = function(a) -- abs_fixedpoint
    return a < 0fx and -a or a
  end,
  
  floor = function(a)
    return a // 1fx
  end,
  
  ceil = function(a)
    return (a + 1fx) // 1fx
  end,
  
  round = function(a)
    return (a + 0.2048fx) // 1fx
  end,
  
  fraction = function(a)
    return a % 1fx
  end,
  
  random = __DEF_FMATH_RANDOM_FX,
  
  sqrt = __DEF_FMATH_SQRT,
  
  sincos = __DEF_FMATH_SINCOS,
  
  atan2 = __DEF_FMATH_ATAN2,
  
  to_int = __DEF_FMATH_TO_INT, -- int part of fx to number
  
  to_number = function(a) -- fx to number
    return __DEF_FMATH_TO_INT(a * 4096fx) / 4096
  end,
  
  to_fx = function(a) -- to_fixedpoint works only with int numbers, to_fx works with double numbers
    return __DEF_FMATH_TO_FX(a // 1) + __DEF_FMATH_TO_FX((4096 * (a % 1)) // 1) / 4096fx
  end,
  
  length = function(...)
    local args = {...}
    if #args == 2 then -- dx, dy
      return __DEF_FMATH_SQRT(args[1] * args[1] + args[2] * args[2])
    end
    if #args == 4 then -- x1, y1, x2, y2
      local a, b = args[3] - args[1], args[4] - args[2]
      return __DEF_FMATH_SQRT(a * a + b * b)
    end
  end,
  
  sqlen = function(...) -- squared length
    local args = {...}
    if #args == 2 then -- dx, dy
      return args[1] * args[1] + args[2] * args[2]
    end
    if #args == 4 then -- x1, y1, x2, y2
      local a, b = args[3] - args[1], args[4] - args[2]
      return a * a + b * b
    end
  end,
  
}
