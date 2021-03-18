local gfx = require("/dynamic/graphics_helpers.lua")

function make_cage_mesh()
  local mesh = gfx.new_mesh()
  local color = 0x888888ff
  for i = - 40, 40, 5 do
    gfx.add_line_to_mesh(mesh, {{i, -40, -60}, {i, -40, 60}}, {color, color})
    gfx.add_line_to_mesh(mesh, {{i, 40, -60}, {i, 40, 60}}, {color, color})
    gfx.add_line_to_mesh(mesh, {{-40, i, -60}, {-40, i, 60}}, {color, color})
    gfx.add_line_to_mesh(mesh, {{40, i, -60}, {40, i, 60}}, {color, color})
  end
  return mesh
end

meshes = {make_cage_mesh()}