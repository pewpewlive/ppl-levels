local Color = {}

function Color.MakeColor(r, g, b, a)
    local color = r * 256 + g
    color = color * 256 + b
    color = color * 256 + a
    return color
  end
  
  function Color.ColorWithAlpha(color, new_alpha)
    local alpha = color % 256
    color = color - alpha + new_alpha
    return color
  end
  
  function Color.InterpolateColor(color1, color2, percentage)
    local r1 = (color1 >> 24) & 0xff
    local g1 = (color1 >> 16) & 0xff
    local b1 = (color1 >> 8) & 0xff
    local a1 = (color1) & 0xff
  
    local r2 = (color2 >> 24) & 0xff
    local g2 = (color2 >> 16) & 0xff
    local b2 = (color2 >> 8) & 0xff
    local a2 = (color2) & 0xff
  
    local r3 = r1 + (r2 - r1) * percentage
    local g3 = g1 + (g2 - g1) * percentage
    local b3 = b1 + (b2 - b1) * percentage
    local a3 = a1 + (a2 - a1) * percentage
  
    return Color.MakeColor(r3, g3, b3, a3)
  end
  
  function Color.ColorToString(color)
    local s = string.format("%x", color)
    while string.len(s) < 8 do
      s = "0" .. s
    end
    return "#" .. s
  end

  return Color