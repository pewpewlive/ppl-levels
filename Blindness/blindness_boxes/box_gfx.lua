local helpers = require("/dynamic/blindness_boxes/mesh_helpers.lua")

function create_box(color)
  local mesh = helpers.new_mesh()
  helpers.add_vertical_cylinder_to_mesh(mesh, {0,0,0}, 40, 22, 7, color)
  return mesh
end

function create_eye(c)
  return {
    vertexes = {{13,15},{1,10},{23,3},{29,10},{17,15},{10,12},{10,8},{13,5},{17,5},{20,8},{20,12},{7,3},{15,1},{8,17},{15,19},{22,17}},
    segments = {{5,6,7,8,9,10,4,0,5},{3,2,12,11,1,13,14,15,3}},
    color = {c, c, c, c, c, c, c, c, c, c, c, c, c, c, c, c}
  }
end
meshes = {
  create_box(0xffffff99),
  create_eye(0xffffff70)
}
