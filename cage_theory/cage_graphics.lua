local gfx = require("/dynamic/graphics_helpers.lua")

function make_cage_mesh()
  local mesh = gfx.new_mesh()
  local color = 0x888888ff
  local cage_height = 200
  for i = -63, 63, 7 do
    gfx.add_line_to_mesh(mesh, {{i, -65, -cage_height}, {i, -65, cage_height}}, {color, color})
    gfx.add_line_to_mesh(mesh, {{i, 65, -cage_height}, {i, 65, cage_height}}, {color, color})
    gfx.add_line_to_mesh(mesh, {{-65, i, -cage_height}, {-65, i, cage_height}}, {color, color})
    gfx.add_line_to_mesh(mesh, {{65, i, -cage_height}, {65, i, cage_height}}, {color, color})
  end
  return mesh
end

meshes = {make_cage_mesh()}