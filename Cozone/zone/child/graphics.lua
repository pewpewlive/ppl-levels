local gfx = require'/dynamic/helpers/graphics_helpers.lua'
local ch = require'/dynamic/helpers/color_helpers.lua'

meshs = {}

local function elevated_circles(mesh,radius,zs,alpha_start,alpha_end,ripple_steps,ripple_radius)
    local steps = (zs[3]-zs[1])//zs[2]
    local zmax = ripple_steps*zs[2]
    local zmin = zs[1]
    local tt = 1
    for i = 1, steps do
        if i/tt > ripple_steps then
            tt = tt + 1
            zmax = tt*ripple_steps*zs[2]
            zmin = zmax-ripple_steps*zs[2]
        end
        local z = (i-1)*zs[2]
        local t = gfx.invLerp(zs[1],zs[3],z)
        local alpha = 0
        local rt = gfx.invLerp(zmin,zmax,z)
        --print("zmin: "..zmin..", zmax: "..zmax..", z: "..z.. ", rt: "..rt)

        local tradius
        if rt < 0.5 then
            tradius = gfx.lerp(radius,ripple_radius,rt)
        elseif rt >= 0.5 then
            tradius = gfx.lerp(ripple_radius,radius,rt)
        end
        --print(i.. " | "..z.." | "..z_off)
        alpha = gfx.lerp(alpha_start,alpha_end,t)
        if alpha < 0 then alpha = 0 end
        
        if alpha < 0 then
            alpha = 0
        end
        --print(t)
        gfx.add_flat_poly_angle(mesh, {0, 0, z}, 30, ch.make_color_with_alpha(0xffffff00,alpha), tradius, 0)
    end
    tt = 1
    zmax = ripple_steps*-zs[2]
    zmin = zs[1]
    for i = 1, steps do
        if i/tt > ripple_steps then
            tt = tt + 1
            zmax = tt*ripple_steps*-zs[2]
            zmin = zmax+ripple_steps*zs[2]
        end
        local z = -(i-1)*zs[2]
        local t = gfx.invLerp(zs[1],-zs[3],z)
        local alpha = 0
        local rt = gfx.invLerp(zmin,zmax,z)
        --print("zmin: "..zmin..", zmax: "..zmax..", z: "..z.. ", rt: "..rt)
        local tradius
        if rt < 0.5 then
            tradius = gfx.lerp(radius,ripple_radius,rt)
        elseif rt >= 0.5 then
            tradius = gfx.lerp(ripple_radius,radius,rt)
        end
        --print(i.. " | "..z.." | "..z_off)
        alpha = gfx.lerp(alpha_start,alpha_end,t)
        if alpha < 0 then alpha = 0 end
        
        if alpha < 0 then
            alpha = 0
        end
        --print(t)
        gfx.add_flat_poly_angle(mesh, {0, 0, z}, 30, ch.make_color_with_alpha(0xffffff00,alpha), tradius, 0)
    end
end

local frames = 60
local wait_time = 10
local finish_line = 15
local step = finish_line/frames*2
local current = 0
for i = 1, frames+wait_time do 
    local mesh = gfx.new_mesh()
    --print(current)
    elevated_circles(mesh,100-finish_line+current,{0,25,125},105,0,2,100+finish_line-current)
    if i >= wait_time and i < frames/2+wait_time then
        current = current + step
    elseif i >= frames/2+wait_time then
        current = current - step
    end
    table.insert(meshs,mesh)
end

meshes = meshs