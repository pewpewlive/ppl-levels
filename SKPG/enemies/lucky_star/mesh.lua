--[[gfx.add_star(meshes[1], {0,0,0}, 0xffffffff, 25,0.95)
gfx.add_flat_poly_angle(meshes[1],{0,0,30},5,0xffffffff,10,0.3)]]

local gfx = require("/dynamic/graphics_helper.lua")
local color = require("/dynamic/helpers/color_helpers.lua")

local frames = {}

meshes = frames

-- gfx.new_mesh()

local yes = 0
local z  = 0
local z2  = 60
local z3 = 120
for i = 1, 36 do
    table.insert(frames,gfx.new_mesh())
    gfx.add_star(meshes[i], {0,0,0}, 0x00ffffff, 22,0.95)
    gfx.add_star(meshes[i], {0,0,0}, 0x00ffffff, 22,0.95)
    gfx.add_flat_poly_angle(meshes[i],{0,0,0},5,color.make_color(0,255,255,225),7,0.3)

    if z < 180 then
        z = z + 10
    else
        z = 0
    end
    gfx.add_flat_poly_angle(meshes[i],{0,0,z},5,color.make_color(0,255,255,225-z),10-z/20,0.3)
    gfx.add_flat_poly_angle(meshes[i],{0,0,-z},5,color.make_color(0,255,255,225-z),10-z/20,0.3)


    gfx.add_flat_poly_angle(meshes[i],{0,0,z2},5,color.make_color(0,255,255,225-z2),10-z2/20,0.3)
    gfx.add_flat_poly_angle(meshes[i],{0,0,-z2},5,color.make_color(0,255,255,225-z2),10-z2/20,0.3)
    if z2 < 180 then
        z2 = z2 + 10
    else
        z2 = 0
    end

    gfx.add_flat_poly_angle(meshes[i],{0,0,z3},5,color.make_color(0,255,255,225-z3),10-z3/20,0.3)
    gfx.add_flat_poly_angle(meshes[i],{0,0,-z3},5,color.make_color(0,255,255,225-z3),10-z3/20,0.3)
    if z3 < 180 then
        z3 = z3 + 10
    else
        z3 = 0
    end
end
