local gfx = require("/dynamic/graphics_helper.lua")

meshes = {gfx.new_mesh{},gfx.new_mesh{}}

local times = 5; local e_radius = 30; local inc = e_radius/times
for i = 0, times-1 do
    if i % 2 == 0 then
        gfx.add_cube_to_mesh(meshes[1], {0,0,0}, inc, 0xff0000ff)
        gfx.add_cube_to_mesh(meshes[2], {0,0,0}, inc, 0x0000ffff)
    else 
        gfx.add_cube_to_mesh(meshes[1], {0,0,0}, inc, 0x0000ffff)
        gfx.add_cube_to_mesh(meshes[2], {0,0,0}, inc, 0xff0000ff) 
    end
    inc = inc + inc-i*2
end
