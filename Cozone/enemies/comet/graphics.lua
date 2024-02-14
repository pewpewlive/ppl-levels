local gfx = require("/dynamic/helpers/graphics_helpers.lua")

local size = 0.1
meshes = {
    {
        vertexes = {{0,-size},{0,size},{-size,0},{size,0}},
        segments = {{0,1},{2,3}},
        colors = {0xffffffff,0xffffffff,0xffffffff,0xffffffff}
    },
    gfx.new_mesh(),--sphere
}
gfx.add_circle(meshes[1],{0,0,0},0xffffffff,20)
gfx.add_sphere(meshes[2], {0,0,0}, 0xffffffff, 20)