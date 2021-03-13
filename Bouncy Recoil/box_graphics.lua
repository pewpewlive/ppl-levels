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

colors = {0xee332235,0xfffd6e35,0x2a37eb35,0xee332235,0xee332235}
--Triple Meshes
gfx.add_poly(meshes[1], {0, 0, 15}, 8, 0xffffffff, 20)
gfx.add_plus(meshes[2], {0, 0, 0}, 0x00ffffff, 8)
--Shield Meshes
gfx.add_poly(meshes[3], {0, 0, 15}, 8, 0xffff00ff, 20)
gfx.add_big_plus(meshes[4], {0, 0, 0}, 0xffff00ff, 3)
--Double Swipe Meshes
gfx.add_poly(meshes[5], {0, 0, 15}, 8, 0xffffffff, 20)
gfx.add_poly(meshes[6], {0, 0, 0}, 6, 0xff1122ff, 5)
--Hemisphere Meshes
gfx.add_poly(meshes[7], {0, 0, 15}, 8, 0xffffffff, 20)
gfx.add_semi_circle(meshes[8], {0, 0, 0}, 0xffff00ff, 10)
--AK Meshes
gfx.add_poly(meshes[9], {0, 0, 15}, 8, 0xffffffff, 20)
gfx.add_multi_lines(meshes[10], {0, 0, 0}, 0x992299ff, 10)
--Ball Mesh
gfx.add_ball(meshes[11], {0,0,0}, colors, 100)
--Burst Meshes
gfx.add_poly(meshes[12], {0, 0, 15}, 8, 0xffffffff, 20)
gfx.add_semi_circle(meshes[13], {0, 0, 0}, 0xffff00ff, 10)
gfx.add_semi_circle(meshes[13], {0, -5, 0}, 0xffff00ff, 8)
gfx.add_semi_circle(meshes[13], {0, -10, 0}, 0xffff00ff, 6)
--Invincibility Meshes
gfx.add_poly(meshes[14], {0, 0, 15}, 20, 0xf542ddff, 20)
gfx.add_poly(meshes[15], {0, 0, 0}, 50, 0xf542ddff, 5)
--Multiplier Meshes
gfx.add_poly(meshes[16], {0, 0, 15}, 20, 0x03f4fcff, 20)
gfx.add_big_plus(meshes[17], {0, 0, 0}, 0x03f4fcff, 3)