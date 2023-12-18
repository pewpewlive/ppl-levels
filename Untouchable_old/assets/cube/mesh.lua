
require'/dynamic/mesh_helpers.lua'

a = 100
b = 100
offset1 = -2
square_amount1 = 5
c = 40
d = 40
offset2 = -10
square_amount2 = 4

meshes = {}

function add_suare(mesh, a, b, rx, ry, rz)
  local index = #mesh.vertexes
  table.insert(mesh.segments, {index, index + 1, index + 2, index + 3, index})
  for i = 1, 4 do
    local x, y, z = rotate_vector3f(b, a * math.sin(i / 4 * tau), a * math.cos(i / 4 * tau), rx, ry, rz)
    table.insert(mesh.vertexes, {x, y, z})
  end
end

function create_cube_mesh(mesh, a, b, offset, square_amount)
  for i = 0, square_amount - 1 do
    for n = 0, 3 do
      add_suare(mesh, a + i * offset, b, 0, 0, n * pi / 2)
    end
    for n = 0, 1 do
      add_suare(mesh, a + i * offset, b, 0, n * pi + pi / 2, 0)
    end
  end
end

param = require(ASSETS_PATH .. 'cube/animation.lua')

frame_amount = param.frame_amount

rx = math.random() / 2
ry = math.random() / 2
rz = math.random() / 2

for i = 0, frame_amount - 1 do
  local k = math.sin(i / frame_amount * tau) * 4
  local mesh = def_mesh()
  create_cube_mesh(mesh, a, b, offset1, square_amount1)
  local index = #mesh.vertexes
  create_cube_mesh(mesh, c, d, offset2, square_amount2)
  for n = index + 1, #mesh.vertexes do
    local x, y, z = table.unpack(mesh.vertexes[n])
    x, y, z = rotate_vector3f(x, y, z, rx * k, ry * k, rz * k)
    mesh.vertexes[n] = {x, y, z}
  end
  table.insert(meshes, mesh)
end
