local gfx = require'/dynamic/helpers/graphics_helpers.lua'
local ch = require'/dynamic/helpers/color_helpers.lua'

meshes = {
    gfx.new_mesh()
}
local color = 0x1020aa00
gfx.add_cave(meshes[1],{0,0,0},0x1020aa00,8,16,-1500,100,100,260,90)

local max_dist = 90*8
local aa,ae = 0,150
local dx,dy
local tx,ty = 0,0
local dist 
local t 
local a
for i = 1, #meshes[1].vertexes do
    dx,dy = meshes[1].vertexes[i][1]-tx,meshes[1].vertexes[i][2]-ty
    dist = math.sqrt((dx*dx)+(dy*dy))
    t = gfx.invLerp(90*2.5,max_dist,dist)
    a = gfx.lerp(aa,ae,t)//1
    if a < 0 then
        a = 0 
    end
    meshes[1].colors[i] = ch.make_color_with_alpha(color,a)
end