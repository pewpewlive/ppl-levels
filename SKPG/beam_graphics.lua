local gv = require("/dynamic/global_vars.lua")
local gfx = require("/dynamic/graphics_helper.lua")
local hh = gv[2][2]/2
local hw = gv[2][1]/2
local hh2 = gv[2][2]
local hw2 = gv[2][1]

meshes = {
    {
        vertexes = 
        {
            {7,-hh-10},{34,-hh-44}, {6,-hh-22},{12,-hh-36}, {-4,-hh-12},{-30,-hh-46}, {-21,-hh-27},{-37,-hh-32}, {0,-hh-28},{-2,-hh-110},{0,-hh-100},{-1.5,-hh-90}, {1,-hh-140},{-1,-hh-150},
        },
        segments = 
        {
            {0,1},{2,3},{4,5},{6,7},{8,9,10,11},{12,13},
            {0,1},{2,3},{4,5},{6,7},{8,9,10,11},{12,13},
        },
        colors = {0x000000ff,0x0000ffff,0x000000ff,0x0000ffff,0x000000ff,0xff0000ff,0x000000ff,0xff0000ff,0x000000ff,0x0000ffff,0x0000ffff,0x0000ffff,0x0000ffff,0x0000ffff,
        0x000000ff,0x0000ffff,0x000000ff,0x0000ffff,0x000000ff,0xff0000ff,0x000000ff,0xff0000ff,0x000000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff}
    },
    {
        vertexes = 
        {
            {-hw,6},{-hw-5,16}, {-hw-5,3},{-hw-25,15}, {-hw-19,0},{-hw-120,2},{-hw-107,0},{-hw-90,1}, {-hw-12,-6},{-hw-21,-9}, {-hw,-3},{-hw-3,-8}, {-hw-7,-13},{-hw-17,-25},{-hw-16,-23}, {-hw-150,-1},{-hw-160,1}
        },
        segments = 
        {
            {0,1},{2,3},{4,5,6,7},{8,9},{10,11},{12,13,14},{15,16},
            {0,1},{2,3},{4,5,6,7},{8,9},{10,11},{12,13,14},{15,16}
        },
        colors = {0x000000ff,0xff0000ff,0x000000ff,0xff0000ff,0x000000ff,0xff0000ff,0x000000ff,0xff0000ff,0x000000ff,0xff0000ff,0x000000ff,0xff0000ff,0x000000ff,0xff0000ff,0xff0000ff,0xff0000ff,0xff0000ff,
        0x000000ff,0x0000ffff,0x000000ff,0x0000ffff,0x000000ff,0x0000ffff,0x000000ff,0x0000ffff,0x000000ff,0x0000ffff,0x000000ff,0x0000ffff,0x000000ff,0x0000ffff,0x0000ffff,0x0000ffff,0x0000ffff}
    }
}

dif_vertexes = {  {7,-hh-10},{34,-hh-44}, {6,-hh-22},{12,-hh-36}, {-4,-hh-12},{-30,-hh-46}, {-21,-hh-27},{-37,-hh-32}, {0,-hh-28},{-2,-hh-110},{0,-hh-100},{-1.5,-hh-90}, {1,-hh-140},{-1,-hh-150},}
dif_vertexes2 = {{-hw,6},{-hw-5,16}, {-hw-5,3},{-hw-25,15}, {-hw-19,0},{-hw-120,2},{-hw-107,0},{-hw-90,1}, {-hw-12,-6},{-hw-21,-9}, {-hw,-3},{-hw-3,-8}, {-hw-7,-13},{-hw-17,-25},{-hw-16,-23}, {-hw-150,-1},{-hw-160,1}}

for i = 1, #dif_vertexes do
    dif_vertexes[i][2] = -dif_vertexes[i][2]
    table.insert(meshes[1].vertexes,dif_vertexes[i])
end

for i = 1, #meshes[1].segments/2 do
    for i2 = 1, #meshes[1].segments[i] do
        meshes[1].segments[i][i2] = meshes[1].segments[i][i2] + 14
    end
end

for i = 1, #dif_vertexes2 do
    dif_vertexes2[i][1] = -dif_vertexes2[i][1]
    table.insert(meshes[2].vertexes,dif_vertexes2[i])
end

for i = 1, #meshes[2].segments/2 do
    for i2 = 1, #meshes[2].segments[i] do
        meshes[2].segments[i][i2] = meshes[2].segments[i][i2] + 17
    end
end
