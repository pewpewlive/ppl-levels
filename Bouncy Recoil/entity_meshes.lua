local gfx = require("/dynamic/graphics_helpers.lua")

meshes = {
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(), 
    gfx.new_mesh(), 
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh()
}


--Slime Mesh
local radius = 25
--gfx.add_cube_to_mesh(meshes[5], {0,0,radius}, radius, 0xffffffff)
gfx.add_square(meshes[1],{0,0,0},radius,0xffffffff)

--Bounce Mesh
gfx.add_poly2(meshes[2], {0,0,0}, 40, 0xffffffff, 15, 2)

--Animation Mesh
gfx.add_poly2(meshes[3], {0,0,0}, 10, 0xffffffff, 10, 3)
--add_poly2(mesh, center, sides, color, radius, height)

--Small Slime Mesh
gfx.add_square(meshes[4],{0,0,0},radius,0xffffffff)
gfx.add_square(meshes[4],{0,0,0},radius/2,0xffffffff)
