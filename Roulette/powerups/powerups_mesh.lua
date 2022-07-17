local gfx = require("/dynamic/graphics_helper.lua")

meshes = ({gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh(),gfx.new_mesh()})

gfx.add_poly3(meshes[1], {0,0,0}, 8, 0xff7f00ff, 22, 22, 30)
gfx.add_poly3(meshes[2], {0,0,0}, 14, 0xffff00ff, 24, 24, 11)
gfx.add_3D_diamond(meshes[3], {0,0,0}, 0xff500080, 11)
gfx.add_3D_diamond(meshes[4], {0,0,0}, 0x00000000, 11)

gfx.add_poly3(meshes[5], {0,0,0}, 8, 0x00ff009f, 22, 22, 30)
gfx.add_poly3(meshes[6], {0,0,0}, 14, 0x00ff00ff, 24, 24, 11)
gfx.add_3D_diamond(meshes[7], {0,0,0}, 0x00ff0070, 11)