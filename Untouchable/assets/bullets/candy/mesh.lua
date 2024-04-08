
require'/dynamic/mesh_helpers.lua'

def_meshes()

m = 3 ^ 0.5 / 2
a = 8

__v = {
  {-a * m / 3, a / 2}, {a * m / 3 * 2, 0}, {-a * m / 3, -a / 2},
}
__s = {0, 1, 2, 0}

triangle_amount = 2
offset = 4
color = 0xffff20ff

index = 0
mesh = meshes[1]

for i = 1, triangle_amount do
  local k = (a + offset * i) / a
  for n = 1, #__v do
    table.insert(mesh.vertexes, {__v[n][1] * k, __v[n][2] * k})
    table.insert(mesh.colors, color)
  end
  local segment = {}
  for n = 1, #__s do
    table.insert(segment, __s[n] + index)
  end
  table.insert(mesh.segments, segment)
  index = index + #__v
end
