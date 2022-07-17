local gfx = require("/dynamic/helpers/mesh_helpers.lua")

meshes = {gfx.new_mesh()}

gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {0,0,0}, 50, 25, 0xffffffff, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {0,0,0}, 45, 25, 0x898989ff, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {0,0,0}, 41, 25, 0x696969ff, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {0,0,0}, 38, 25, 0x393939ff, 0)
gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {0,0,0}, 35, 25, 0x191919ff, 0)