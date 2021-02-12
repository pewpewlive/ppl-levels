local gfx = require("/dynamic/helpers/mesh_helpers.lua")

local band_color = 0xffffffff
local radius = 25


function f1(angle)
  return 25 * math.cos(2*angle)-- + math.sin(3 * angle))
end

function mesh_from_polar_function(f)
  computed_vertexes = {}
  local index = 0
  local line = {}
  local colors = {}
  for angle = 0, math.pi * 2, 0.2 do
    local r = f(angle + 1)
    local x = math.cos(angle) * r
    local y = math.sin(angle) * r
    table.insert(computed_vertexes, {x, y, 2 * radius + 2 * math.abs(r)})
    table.insert(line, index)
    table.insert(colors, band_color)
    index = index + 1
  end
  -- Close the loop
  table.insert(line, 0)
  return  {
    vertexes = computed_vertexes,
    segments = {line},
    colors = colors
  }
end

mesh = mesh_from_polar_function(f1)

for i = -1, 1, 1 do
  gfx.add_line_to_mesh(mesh, {{-radius, i, 0}, {radius, i, 0}, {radius, i, radius * 2}, {-radius, i, radius * 2}}, {band_color, band_color, band_color, band_color}, true)
  gfx.add_line_to_mesh(mesh, {{i, -radius, 0}, {i, radius, 0}, {i, radius, radius * 2}, {i, -radius, radius * 2}}, {band_color, band_color, band_color, band_color}, true)
end

local cube_mesh = gfx.new_mesh()
gfx.add_cube_to_mesh(cube_mesh, {0,0,radius}, radius * 2, 0xffffffff)


meshes = {cube_mesh, mesh}
