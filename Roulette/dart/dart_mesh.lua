local gfx = require("/dynamic/graphics_helper.lua")

meshes = {gfx.new_mesh()}

gfx.add_poly2(meshes[1], {0,0,0}, 6, 0x999999ff, 17,16, 20)
gfx.add_ex(meshes[1],{0,0,0},0x898989ff,12,12)