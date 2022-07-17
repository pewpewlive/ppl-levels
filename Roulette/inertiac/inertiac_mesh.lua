local helpers = require("/dynamic/helpers/mesh_helpers.lua")

function create_box(color)
  local mesh = helpers.new_mesh()
  helpers.add_vertical_cylinder_to_mesh(mesh, {0,0,0}, 0, 24, 6, color)
  return mesh
end

meshes = {
  create_box(0xffffffff),
  create_box(0x000000ff)
}