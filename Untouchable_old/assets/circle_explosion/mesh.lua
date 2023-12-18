
require'/dynamic/mesh_helpers.lua'

r = 3000
offset_r = 10
layer_amount = 12
vertex_amount = 48

meshes = {}

rgba_max = {128, 208, 208, 255}
rgba_min = {128, 208, 208, 0}
rgba_d = {}
for i = 1, 4 do
  rgba_d[i] = rgba_max[i] - rgba_min[i]
end
function get_color(i, layer_amount)
  local k = i / (layer_amount - 1)
  return make_color(
    (rgba_min[1] + rgba_d[1] * k) // 1,
    (rgba_min[2] + rgba_d[2] * k) // 1,
    (rgba_min[3] + rgba_d[3] * k) // 1,
    (rgba_min[4] + rgba_d[4] * k) // 1
  )
end

for q = 1, 2 do
  local mesh = def_mesh()
  for n = 0, layer_amount - 1 do
    create_circle(mesh, #mesh.vertexes, r + n * offset_r, vertex_amount, 0)
    for j = 1, #mesh.vertexes do
      table.insert(mesh.colors, get_color(n + 1, layer_amount))
    end
  end
  table.insert(meshes, mesh)
  
  rgba_max = {255, 144, 160, 255}
  rgba_min = {255, 144, 160, 0}
  for i = 1, 4 do
    rgba_d[i] = rgba_max[i] - rgba_min[i]
  end
end

