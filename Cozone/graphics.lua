local gfx = require'/dynamic/helpers/graphics_helpers.lua'
local ch = require'/dynamic/helpers/color_helpers.lua'
require'/dynamic/gv.lua'

local obstacle_data = {
    {
        vertexes = {{X/2.5,0},{X/2.5-Y/7,Y/7}}
    },
    {
        vertexes = {{X-X/8,Y},{X-X/8,Y-Y/3},{X,Y-Y/3-X/8}}
    }
}

local color = 0xffffffff

local z_step = 40

local ref_mesh =  {
    vertexes = {{0,0},{X,0},{X,Y},{0,Y},
    {X//2.5,0},{X//2.5-Y//7,Y//7},{0,Y//7},--bottom left
    {X-X//8,Y},{X-X//8,Y-Y//3},{X,Y-Y//3-X//8},--top right
    },
    segments = {{3,7,8,9,1,4,5,6,3}},
    colors = {color,color,color,color,color,color,color,color,color,color}
}

meshs = {}

local steps = 3
for i = 1, steps do 
    table.insert(meshs,gfx.copy(ref_mesh))
    -- local t = gfx.invLerp(1,steps,i)
    -- local r,g,b,a = gfx.lerp(ar,er,t)//1,gfx.lerp(ag,eg,t)//1,gfx.lerp(ab,eb,t)//1,gfx.lerp(aa,ea,t)//1
    -- print(" {"..r..", "..g..", "..b..", "..a.."} ")
    -- for j = 1, #meshs[i].colors do
    --     meshs[i].colors[j] = ch.make_color(r,g,b,a)
    -- end

    for j = 1, #meshs[i].vertexes do 
        meshs[i].vertexes[j][3] = (i-1)*z_step
    end
    --print(i)
end

-- local bottom_verts = meshs[1].vertexes
-- local init_len = #bottom_verts
-- gfx.add_line_to_mesh(meshs[1],{bottom_verts[7],{-X//16,Y//7-X//16,-X//12}},{color,color},false)
-- gfx.add_line_to_mesh(meshs[1],{bottom_verts[init_len+1],{,-X//12}},{color,color},false)

meshes = meshs

return obstacle_data