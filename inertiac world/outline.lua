local gfx = require("/dynamic/helpers/mesh_helpers.lua")

meshes = {gfx.new_mesh()}

gfx.add_horizontal_regular_polygon_to_mesh(meshes[1], {0,0,0}, 750, 8, 0xf5c85dff, 0)