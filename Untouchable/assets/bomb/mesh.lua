
require'/dynamic/mesh_helpers.lua'

a = 20
b1 = 10
b2 = 2

meshes = {}

function add_triangle(mesh, index_offset, a, b, rx, ry, rz)
  for i = 1, 3 do
    local x, y, z = rotate_vector3f(b, a * math.sin(i / 3 * tau), a * math.cos(i / 3 * tau), rx, ry, rz)
    table.insert(mesh.vertexes, {x, y, z})
  end
  table.insert(mesh.segments, {index_offset, index_offset + 1, index_offset + 2, index_offset})
end

local q = 1 / 3
local f = tau / 3
local figure_amount = 3
local offset = -8
function create_bomb_mesh(mesh, index_offset, b1, b2, b3, b4)
  for i = 0, figure_amount - 1 do
    add_triangle(mesh, index_offset + i * 12    , a + i * offset, b1, 0, q, f)
    add_triangle(mesh, index_offset + i * 12 + 3, a + i * offset, b2, 0, q, f * 2)
    add_triangle(mesh, index_offset + i * 12 + 6, a + i * offset, b3, 0, q, f * 3)
    add_triangle(mesh, index_offset + i * 12 + 9, a + i * offset, b4, pi, -pi / 2, 0)
  end
end

param = require(ASSETS_PATH .. 'bomb/animation.lua')

frame_amount = param.frame_amount

for i = 0, frame_amount - 1 do
    local k = math.sin(i / frame_amount * tau) * b2
    local mesh = def_mesh()
    create_bomb_mesh(mesh, 0,
      b1 + k,
      b1 + k,
      b1 + k,
      b1 + k
    )
    table.insert(meshes, mesh)
  end
