local ch = require("/dynamic/helpers/color_helpers.lua")
local gfx = require("/dynamic/helpers/graphics_helpers.lua")

local function make_pine_tower(mesh, radius_start, alpha_start, zs, z_off, angle, alternating_colors)--TODO: Make circles fade in
    local totalSteps = 0
    if zs[2] ~= 0 then
        totalSteps = (zs[3]-zs[1])//zs[2]
    else
        totalSteps = 1
    end

    local extraSteps = 0

    if zs[2] ~= 0 then
        extraSteps = z_off//zs[2]
    end
    --print(extraSteps)
    local minus_z = -60
    local alternateI = 0
    if extraSteps ~= 0 then
        alternateI = extraSteps % #alternating_colors
    end
    local offy,offx = math.sincos(angle)
    for i = 1, totalSteps+extraSteps+(-minus_z//zs[2]) do
        alternateI = alternateI + 1
        if alternateI > #alternating_colors then
            alternateI = 1
        end
        local z = (i-1)*zs[2]+(z_off-(extraSteps*zs[2]))+minus_z
        local t = gfx.invLerp(zs[1],zs[3],z)
        local minus_t = gfx.invLerp(zs[1]-minus_z,zs[1],z)
        local radius = 0
        local alpha = 0
        --print(i.. " | "..z.." | "..z_off)
        if z < 0 then
            radius = gfx.lerp(radius_start,radius_start/1.5,math.abs(minus_t-1))
            alpha = gfx.lerp(alpha_start,0,math.abs(minus_t-1))
        else
            radius = gfx.lerp(radius_start,0,t)
            alpha = gfx.lerp(alpha_start,0,t)
        end
        if alpha < 0 then
            alpha = 0
        end
        local offset = gfx.lerp(0,radius_start,t)
        --print(t)
        gfx.add_flat_poly_angle(mesh, {offx*offset, offy*offset, z}, 30, ch.make_color_with_alpha(alternating_colors[alternateI],alpha), radius, 0)
    end
end

local frames = {}
local frame_Amount = 60
local zOffset = 0
local z_step = 1

local angle = 0
for i = 1, frame_Amount do
    local mesh = gfx.new_mesh()

    make_pine_tower(mesh, 75, 170, {0,30,300}, zOffset, angle, {0xcc904000,0x2049cc00})
    zOffset = zOffset + z_step
    table.insert(frames,mesh)
end

meshes = frames