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

--Ping Pong Mesh
gfx.add_filled_rectangle(meshes[1], {0,0,0}, 30, 2, 0xffffffff)

--Ping Pong Ball Mesh
gfx.add_disk(meshes[2], {0,0,0}, 6, 0xffffffff)

--Ceiling Mesh
gfx.add_filled_rectangle2(meshes[3], {0,0,0}, 3, 450, 0xffffffff)

--Wall Mesh
gfx.add_filled_rectangle(meshes[4], {0,0,0}, 264, 3, 0xffffffff)

--Slime Mesh
local radius = 25
gfx.add_cube_to_mesh(meshes[5], {0,0,radius}, radius, 0xffffffff)

--BAF Mesh
local multiplier = 2
local forward = 10 * multiplier
local backward = 5 * multiplier
local upward = 8 * multiplier
gfx.add_BAF_Right(meshes[6],{0,0,0},0xffffffff,forward,backward,upward)
gfx.add_BAF_Left(meshes[7],{0,0,0},0xffffffff,forward,backward,upward)
gfx.add_BAF_Up(meshes[8],{0,0,0},0xffffffff,forward,backward,upward)
gfx.add_BAF_Down(meshes[9],{0,0,0},0xffffffff,forward,backward,upward)

--DoomBox Mesh

gfx.add_poly2(meshes[10], {0,0,0}, 8, 0xffffffff, 50, 10)
gfx.add_sphere2(meshes[11], {0,0,0}, 0xffffffff, 5)