local gv = require("/dynamic/gv.lua")
--local gfx = require("/dynamic/graphics_helper.lua")

local hw,hh = gv[2][1]/2,gv[2][2]/2

meshes = {
    {
    vertexes = {{-hw,-hh},{hw,-hh},{hw,hh},{-hw,hh}},
    segments = {{0,1,2,3,0}}
    }
}