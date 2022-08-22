local gv = require("/dynamic/global_vars.lua")
local hh = gv[2][2]/2
local hw = gv[2][1]/2

meshes = {
    {
        vertexes = {--bottom-right
        {83,-hh-21},{40,-hh-8},{49,-hh-22},{28,-hh-20},{18,-hh-2},{54,-hh+10},{102,-hh+3},
        {54,-hh},{64,-hh-5}, {68,-hh-7},{120,-hh+3},{159,-hh+2},{185,-hh-9},{213,-hh+4},
        {215,-hh-2},{206,-hh-10}, {219,-hh-4},{225,-hh-16}, {218,-hh+1},{255,-hh-1},{288,-hh+7--[[segment 20]]},{310,-hh+5},
        --[[continuing from segment 20]]{295,-hh-7},--[[divergent path 1]]{265,-hh-5},--[[divergent path 2]]{355,-hh+4},{390,-hh},{385,-hh-7},{365,-hh-4},
        {392,-hh-5},{392,-hh-17}, {399,-hh-8},{395,-hh+3},{410,-hh},{hw,-hh+15--[[segment33]]},--this last one is the start of right-bottom
        --right-bottom
        --[[line continues from segment 33]]{hw+4,-275},{hw-8,-260},{hw-10,-220},{hw+8,-185--[[segment 37]]},
        --[[continuing from segment 37]]{hw+12,-150}, {hw+7.5,-130},{hw+12,-145},{hw+17,-139}, {hw+16,-148},{hw+29,-152},--[[divergent path 1]]{hw-5,-170},{hw-1,-125},{hw-16,-115},--[[divergent path 2]]
        --[[small lines, exist close to segment 36]]{hw,-208},{hw-5,-221},{hw+12,-224}, {hw-5,-226},{hw+3,-235},
        {hw-18,-105},{hw-5,-90--[[segment 53]]},{hw+4,-120}, --[[continuing from segment 53-->]]{hw,-50},{hw+11,-41},{hw-8,-35},{hw-4,-16},
        --[[small lines, exist close to segment 56]]{hw+12,-45},{hw+13,-58}, {hw+15,-42},{hw+21,-46},
        },
        segments = {{0,1,2,3,4,5,6}, 
        {7,8},{9,10,11,12,13}, 
        {14,15},{16,17},{18,19,20,21},{20,22,23},{22,24,25,26,27},
        {28,29},{30,31,32,33,--[[right-bottom]]34,35,36,37,38},{39,40,41},{42,43},{37,44,45,46},{47,48,49},{50,51},
        {52,53,54},{53,55,56,57,58},{59,60},{61,62},
        {0,1,2,3,4,5,6}, 
        {7,8},{9,10,11,12,13}, 
        {14,15},{16,17},{18,19,20,21},{20,22,23},{22,24,25,26,27},
        {28,29},{30,31,32,33,--[[right-bottom]]34,35,36,37,38},{39,40,41},{42,43},{37,44,45,46},{47,48,49},{50,51},
        {52,53,54},{53,55,56,57,58},{59,60},{61,62},
        },
        colors = {0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffff00,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffff00,0xffffffff,0xffffff00,0xffffffff,
        0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffff00,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,
        0xffffffff,0xffffffff,0xffffffff,0xffffff00,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffff00,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffff00,0xffffffff,
        0xffffff00,0xffffffff,
        0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffff00,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffff00,0xffffffff,0xffffff00,0xffffffff,
        0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffff00,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,
        0xffffffff,0xffffffff,0xffffffff,0xffffff00,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffff00,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffffff,0xffffff00,0xffffffff,
        0xffffff00,0xffffffff}
    }
}

local dif_vertexes = {{83,-hh-21},{40,-hh-8},{49,-hh-22},{28,-hh-20},{18,-hh-2},{54,-hh+10},{102,-hh+3},
{54,-hh},{64,-hh-5}, {68,-hh-7},{120,-hh+3},{159,-hh+2},{185,-hh-9},{213,-hh+4},
{215,-hh-2},{206,-hh-10}, {219,-hh-4},{225,-hh-16}, {218,-hh+1},{255,-hh-1},{288,-hh+7--[[segment 20]]},{310,-hh+5},
--[[continuing from segment 20]]{295,-hh-7},--[[divergent path 1]]{265,-hh-5},--[[divergent path 2]]{355,-hh+4},{390,-hh},{385,-hh-7},{365,-hh-4},
{392,-hh-5},{392,-hh-17}, {399,-hh-8},{395,-hh+3},{410,-hh},{hw,-hh+15--[[segment33]]},--this last one is the start of right-bottom
--right-bottom
--[[line continues from segment 33]]{hw+4,-275},{hw-8,-260},{hw-10,-220},{hw+8,-185--[[segment 37]]},
--[[continuing from segment 37]]{hw+12,-150}, {hw+7.5,-130},{hw+12,-145},{hw+17,-139}, {hw+16,-148},{hw+29,-152},--[[divergent path 1]]{hw-5,-170},{hw-1,-125},{hw-16,-115},--[[divergent path 2]]
--[[small lines, exist close to segment 36]]{hw,-208},{hw-5,-221},{hw+12,-224}, {hw-5,-226},{hw+3,-235},
{hw-18,-105},{hw-5,-90--[[segment 53]]},{hw+4,-120}, --[[continuing from segment 53-->]]{hw,-50},{hw+11,-41},{hw-8,-35},{hw-4,-16},
--[[small lines, exist close to segment 56]]{hw+12,-45},{hw+13,-58}, {hw+15,-42},{hw+21,-46}}

for i = 1, #dif_vertexes do
    dif_vertexes[i][2] = -dif_vertexes[i][2]
    table.insert(meshes[1].vertexes,dif_vertexes[i])
end

for i = 1, #meshes[1].segments/2 do
    for i2 = 1, #meshes[1].segments[i] do
        meshes[1].segments[i][i2] = meshes[1].segments[i][i2] + 63
    end
end


