
require'/dynamic/mesh_helpers.lua'

meshes = {}

a = 24
b = 8
c = 28
d = 4
z1 = 40
z2 = 25

function copy_figure(mesh, index_offset, mod_x, mod_y)
  copy_vertexes(__v, mesh.vertexes, function(vertex)
    return {vertex[1] * mod_x, vertex[2] * mod_y, vertex[3]}
  end)
  copy_segments(__s, mesh.segments, index_offset)
end

param = require(ASSETS_PATH .. 'sentry/animation.lua')
frame_amount = param.frame_amount
offset_d = 2

for i = 0, frame_amount - 1 do
  local mesh = def_mesh()
  local offset = offset_d * math.sin(i / frame_amount * tau)
  __v = {
    {b, b, z1}, {b, a + b, 0}, {a + b, b, 0},
    {b + c + offset, b + d + offset, z2}, {b + d + offset, b + c + offset, z2}, {b + c + offset, b + c + offset, z2},
  }
  __s = {
    {0, 1, 2, 0}, {3, 4, 5, 3},
  }
  copy_figure(mesh, #mesh.vertexes,  1,  1)
  copy_figure(mesh, #mesh.vertexes,  1, -1)
  copy_figure(mesh, #mesh.vertexes, -1,  1)
  copy_figure(mesh, #mesh.vertexes, -1, -1)
  table.insert(meshes, mesh)
end
