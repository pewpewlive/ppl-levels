local helpers = require("/dynamic/helpers/mesh_helpers.lua")

function create_box(color)
  local mesh = helpers.new_mesh()
  helpers.add_cube_to_mesh(mesh, {0,0,0}, 40, color)
  return mesh
end

meshes = {
  create_box(0xffffffff),
}

