local gfx = require("/dynamic/graphics_helper.lua")

meshes = {gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh()}

gfx.add_star2(meshes[1], 750, 600, 12, 10, {0x000050ff,0x000050ff})
gfx.add_squares(meshes[2], 750, 600, 12, 10, {0x151500ff,0x151500ff})
gfx.add_squares(meshes[3], 750, 600, 10, 10, {0x00000000,0x00000000})