local gfx = require("/dynamic/helpers/graphics_helpers.lua")
local ch = require("/dynamic/helpers/color_helpers.lua")
local mesh_info = require("/dynamic/zone/mesh_info.lua")
require("/dynamic/gv.lua")

local meshs = {}

local prototype = {
    vertexes = {},
    segments = {{0,1,2,3,0},{4,5,6,7,4},{8,9,10,11,8},{12,13,14,15,12}},
    colors = {0xffffff99,0xffffff99,0xffffff99,0xffffff99,
    0xffffffff,0xffffffff,0xffffffff,0xffffffff,
    0xffffffff,0xffffffff,0xffffffff,0xffffffff,
    0xffffff99,0xffffff99,0xffffff99,0xffffff99}
}

local function elevated_circles(mesh,radius_start,zs)
    local steps = (zs[3]-zs[1])//zs[2]

    for i = 1, steps do
        local z = (i-1)*zs[2]
        local t = gfx.invLerp(zs[1],zs[3],z)
        local radius = 0
        local alpha = 0
        --print(i.. " | "..z.." | "..z_off)
        radius = gfx.lerp(radius_start,0,t)
        alpha = gfx.lerp(205,0,t)
        
        if alpha < 0 then
            alpha = 0
        end
        --print(t)
        gfx.add_flat_poly_angle(mesh, {0, 0, z}, 30, ch.make_color_with_alpha(0xffffff00,alpha), radius, 0)
    end

    for i = 2, steps do
        local z = -(i-1)*zs[2]
        local t = gfx.invLerp(zs[1],-zs[3],z)
        local radius = 0
        local alpha = 0
        --print(i.. " | "..z.." | "..z_off)
        radius = gfx.lerp(radius_start,0,t)
        alpha = gfx.lerp(205,0,t)
        
        if alpha < 0 then
            alpha = 0
        end
        --print(t)
        gfx.add_flat_poly_angle(mesh, {0, 0, z}, 30, ch.make_color_with_alpha(0xffffff00,alpha), radius, 0)
    end
end

for i = 1, #mesh_info do
    local new_prototype = gfx.copy(prototype)
    new_prototype.vertexes = mesh_info[i]
    elevated_circles(new_prototype,5,{0,30,120})
    table.insert(meshs,new_prototype)
end

meshes = meshs

return mesh_info