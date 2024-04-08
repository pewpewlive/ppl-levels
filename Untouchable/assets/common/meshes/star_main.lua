
local t = 5
local _t = t * 2
local tau = math.pi * 2
local da = tau / _t

local min_r1 = 6
local min_r2 = 9
local offset_r = 4
local mod_r1 = 1
local mod_r2 = 2
local layer_amount = 4
local z = 3

function create_star_mesh(mesh, get_color)
  local v, s, c = def_vsc(mesh)
  local index = 0
  for i = 0, layer_amount - 1 do
    local color = get_color(i, layer_amount)
    local segment = {}
    for n = 1, _t do
      local r = n % 2 == 0 and min_r1 or min_r2
      local mod = n % 2 == 0 and mod_r1 or mod_r2
      r = r + offset_r * i * mod
      table.insert(v, {r * math.cos(da * n), r * math.sin(da * n), (n % 2 * 2 + layer_amount - i - 2) * z})
      table.insert(c, color)
      table.insert(segment, index + n - 1)
    end
    table.insert(segment, index)
    table.insert(s, segment)
    index = index + _t
  end
end

return create_star_mesh
