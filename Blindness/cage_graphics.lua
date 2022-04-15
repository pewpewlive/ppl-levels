local gfx = require("/dynamic/graphics_helpers.lua")

function make_cage_mesh()
  local mesh = gfx.new_mesh()
  local color = 0x888888ff
  for i = -40, 40, 4 do
    gfx.add_line_to_mesh(mesh, {{i, -100, -30}, {i, -100, 30}}, {color, color})
    gfx.add_line_to_mesh(mesh, {{i, 100, -30}, {i, 100, 30}}, {color, color})
    gfx.add_line_to_mesh(mesh, {{-100, i, -30}, {-100, i, 30}}, {color, color})
    gfx.add_line_to_mesh(mesh, {{100, i, -30}, {100, i, 30}}, {color, color})
  end
  return mesh
end

meshes = {make_cage_mesh()}