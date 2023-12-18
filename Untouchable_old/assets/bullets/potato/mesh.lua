
require'/dynamic/mesh_helpers.lua'

def_meshes()

r = 5

vertex_amount = 5
figure_amount = 4
offset = 1.75
color = 0xff8020ff

mesh = meshes[1]

for i = 0, figure_amount - 1 do
  create_circle(mesh, #mesh.vertexes, r + offset * i, vertex_amount, 0)
  for n = 1, vertex_amount do
    table.insert(mesh.colors, color)
  end
end
