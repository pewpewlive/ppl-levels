local mesh_helper = require("/dynamic/helpers/mesh_helpers.lua")

meshes = {  
  mesh_helper.new_mesh(),
  mesh_helper.new_mesh(),
  mesh_helper.new_mesh(),
  mesh_helper.new_mesh(),
  mesh_helper.new_mesh(),
  mesh_helper.new_mesh()
}

mesh_helper.add_vertical_cylinder_to_mesh(meshes[1], {0,0,0}, 1, 30, 5, 0xff150cff) 
mesh_helper.add_vertical_cylinder_to_mesh(meshes[2], {0,0,0}, 1, 33, 5, 0xff150cff) 
mesh_helper.add_vertical_cylinder_to_mesh(meshes[3], {0,0,0}, 1, 45, 8, 0xff7e05ff) 
mesh_helper.add_vertical_cylinder_to_mesh(meshes[4], {0,0,0}, 1, 46, 8, 0xff7e05ff) 
mesh_helper.add_vertical_cylinder_to_mesh(meshes[5], {0,0,0}, 1, 47, 8, 0xff7e05ff) 
mesh_helper.add_vertical_cylinder_to_mesh(meshes[6], {0,0,0}, 1, 48, 8, 0xff7e05ff) 
 
 