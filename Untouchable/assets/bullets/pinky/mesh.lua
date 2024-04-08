
require'/dynamic/mesh_helpers.lua'

def_meshes()

m = 3 ^ 0.5 / 2
a = 9
b = 2

color = 0xff30a0ff

meshes[1].vertexes = {
  {b, a / 2}, {b + a * m, 0}, {b, -a / 2},
  {-b, a / 2}, {-b - a * m, 0}, {-b, -a / 2},
}
meshes[1].segments = {
  {0, 1, 2, 0}, {3, 4, 5, 3},
}
for i = 1, #meshes[1].vertexes do
  table.insert(meshes[1].colors, color)
end
