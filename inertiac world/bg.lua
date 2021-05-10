local gfx = require("/dynamic/helpers/mesh_helpers.lua")

meshes = {gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh()}

gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {0,0,0}, 700, 8, 0xf5c85ddd, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[2], {0,0,0}, 650, 8, 0xf5c85dbb, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[3], {0,0,0}, 600, 8, 0xf5c85d99, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[4], {0,0,0}, 550, 8, 0xf5c85d77, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[5], {0,0,0}, 500, 8, 0xf5c85d55, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[6], {0,0,0}, 450, 8, 0xf5c85d33, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[12], {0,0,0}, 400, 8, 0xf5c85d33, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[7], {0,0,0}, 350, 5, 0xfc7e5e99, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[8], {0,0,0}, 300, 5, 0xfc7e5e88, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[9], {0,0,0}, 250, 5, 0xfc7e5e77, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[10], {0,0,0}, 200, 5, 0xfc7e5e66, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[11], {0,0,0}, 150, 5, 0xfc7e5e55, 0)

