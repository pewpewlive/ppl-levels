
require'/dynamic/mesh_helpers.lua'

meshes = {}

rgba_min = {192, 255, 64, 128}
rgba_max = {255, 0, 0, 192}
rgba_d = {}
for i = 1, 4 do
  rgba_d[i] = rgba_max[i] - rgba_min[i]
end
function get_color(i, layer_amount)
  return make_color(
    (rgba_min[1] + rgba_d[1] * i / layer_amount) // 1,
    (rgba_min[2] + rgba_d[2] * i / layer_amount) // 1,
    (rgba_min[3] + rgba_d[3] * i / layer_amount) // 1,
    (rgba_min[4] + rgba_d[4] * i / layer_amount) // 1
  )
end

require(meshes_path .. 'star_main.lua')
param = require(ASSETS_PATH .. 'star_trail/animation.lua')

frame_amount = param.frame_amount
da_min = rgba_min[4] // frame_amount
da_max = rgba_max[4] // frame_amount

for i = 0, frame_amount - 1 do
  table.insert(meshes, def_mesh())
  rgba_min[4] = rgba_min[4] - da_min
  rgba_max[4] = rgba_max[4] - da_max
  rgba_d[4] = rgba_max[4] - rgba_min[4]
  create_star_mesh(meshes[#meshes], get_color)
end
