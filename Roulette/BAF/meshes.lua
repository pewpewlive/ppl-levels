local gfx = require("/dynamic/graphics_helper.lua")

meshes = {
    gfx.new_mesh()
}

gfx.add_circle(meshes[1],{0,0,0},0xffffffff,20)
gfx.add_circle2(meshes[1],{0,0,0},0xffffffff,20)
gfx.add_circle3(meshes[1],{0,0,0},0x696969ff,20)