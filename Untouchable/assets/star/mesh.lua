
require'/dynamic/mesh_helpers.lua'

meshes = {
  def_mesh(),
  def_mesh(),
}

rgba_min = {192, 255, 64, 192}
rgba_max = {255, 0, 0, 255}
rgba_d = {}
for i = 1, 4 do
  rgba_d[i] = rgba_max[i] - rgba_min[i]
end
function get_color(i, layer_amount)
  return make_color(
    rgba_min[1] + rgba_d[1] * i // layer_amount,
    rgba_min[2] + rgba_d[2] * i // layer_amount,
    rgba_min[3] + rgba_d[3] * i // layer_amount,
    rgba_min[4] + rgba_d[4] * i // layer_amount
  )
end

require(meshes_path .. 'star_main.lua')(meshes[1], get_color)
require(meshes_path .. 'star_main.lua')(meshes[2], function()
  return 0xd0d0d0f0
end)
