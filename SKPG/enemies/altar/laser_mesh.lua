local gfx = require("/dynamic/graphics_helper.lua")

local frames = {}

meshes = frames

local line_inc = 1
local line_inc2 = 0
local y = 0
local y2 = 0
for i = 1, 60 do
    table.insert(frames,gfx.new_mesh())


    for i2 = 1, line_inc do
        gfx.add_line_to_mesh(meshes[i], {{0,y},{1500,y}}, {0x6000ff15,0x6000ff15},false)
        gfx.add_line_to_mesh(meshes[i], {{0,-y},{1500,-y}}, {0x6000ff15,0x6000ff15},false)
        y = y + 0.5
    end
    if i > 18 then
        for i3 = 1, line_inc2 do
            gfx.add_line_to_mesh(meshes[i], {{0,y2},{1500,y2}}, {0x8000ffc0,0x8000ffc0},false)
            gfx.add_line_to_mesh(meshes[i], {{0,-y2},{1500,-y2}}, {0x8000ffc0,0x8000ffc0},false)
            y2 = y2 + 1
        end
    end
    y = 0
    y2 = 0
    if i < 30 then
        line_inc = line_inc + 0.5
    elseif i == 30 then
        line_inc2 =9
        line_inc = 27
    elseif i > 30 then
        line_inc2 = line_inc2 - 1.5
        line_inc = line_inc - 3
    end
end