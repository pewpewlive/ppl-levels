
require'/dynamic/mesh_helpers.lua'

r = 100
offset_r = -1.25
layer_amount = 8
vertex_amount = 24

meshes = {}
mesh = def_mesh()
for i = 0, layer_amount - 1 do
  create_circle(mesh, #mesh.vertexes, r + i * offset_r, vertex_amount, 0)
end
table.insert(meshes, mesh)
