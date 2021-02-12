local gfx = require("/dynamic/helpers/mesh_helpers.lua")

local w = 100

function new_bullet(frame)
  local mesh = gfx.new_mesh()

  local angle_offset = 6.28318530718 * frame / 32
  for y_loop = -1,1,1 do
    local y_offset = y_loop * 13
    local vertexes = {}
    local colors = {}
    for x=-20,20, 3 do
      local y = 10 * math.cos(angle_offset + (x / 5))
      table.insert(vertexes, {x, y + y_offset})
      table.insert(colors, 0x00ffffff)
    end
    gfx.add_line_to_mesh(mesh, vertexes, colors, false)
  end
  return mesh
end

meshes = {}

for i=1,32 do
  table.insert(meshes, new_bullet(i))
end

