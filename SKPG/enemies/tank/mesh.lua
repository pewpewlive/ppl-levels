local gfx = require("/dynamic/graphics_helper.lua")
local color_helpers = require("/dynamic/helpers/color_helpers.lua")

meshes = {
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh()
}

for i2 = 1, 7 do
    local rs = 0
    local z = 0
    for i = 1, 5 do
        gfx.add_flat_poly_angle(meshes[i2],{0,0,z},40,0xffff00ff,(25-rs)-i2*2,0)
        rs = rs + 5
        z = z + 17-i*4
    end
end

for i = 1, 7 do gfx.add_flat_poly_angle(meshes[i],{0,0,0},40,0xffaf008b,140,0) end