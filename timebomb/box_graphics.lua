local gfx = require("/dynamic/helpers/mesh_helpers.lua")

meshes = {gfx.new_mesh(), gfx.new_mesh(), gfx.new_mesh(), gfx.new_mesh()}

gfx.add_cube_to_mesh(meshes[1], {0, 0, 15}, 30, 0x00ff00ff)
gfx.add_cube_to_mesh(meshes[2], {0, 0, 0}, 12, 0x00ff00ff)
gfx.add_cube_to_mesh(meshes[3], {0, 0, 15}, 30, 0xffff00ff)
gfx.add_cube_to_mesh(meshes[4], {0, 0, 0}, 12, 0xffff00ff)