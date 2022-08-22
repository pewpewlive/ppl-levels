local gv = require("/dynamic/global_vars.lua")
local gfx = require("/dynamic/graphics_helper.lua")
local hh = gv[2][2]/2
local hw = gv[2][1]/2
local hh2 = gv[2][2]
local hw2 = gv[2][1]


meshes = {
    {
        vertexes = {},
        segments = {},
        colors = {}
    },
    {
        vertexes = {},
        segments = {},
        colors = {}
    }
}


gfx.add_stars(meshes[1],{-hw2*2,-hh2*2,-hw2*4},hw2*2,hh2*2,500,500)