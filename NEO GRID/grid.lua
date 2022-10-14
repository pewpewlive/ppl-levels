local gv = require("/dynamic/gv.lua")
local gfx = require("/dynamic/graphics_helper.lua")

local hw,hh = gv[2][1],gv[2][2]
local l_amount = 6
local starting_point = 0

local frames = {}

meshes = frames

local x_inc = hw/l_amount;local y_inc = hh/l_amount
for i = 1, 88 do
    table.insert(frames, gfx.new_mesh())
    for x = starting_point, hw, x_inc do
        gfx.add_line_to_mesh(meshes[i],{{x,0},{x,hh}},{0xffffffff,0xffffffff}) 
    end
    for y = starting_point, hh, y_inc do
        gfx.add_line_to_mesh(meshes[i],{{0,y},{hw,y}},{0xffffffff,0xffffffff}) 
    end
    starting_point = starting_point + 2.5
end