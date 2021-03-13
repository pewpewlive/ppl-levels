local gfx = require("/dynamic/BossPack/graphics_helpers.lua")
meshes = {

    gfx.new_mesh(), --index 0
    gfx.new_mesh(), --index 1
    gfx.new_mesh(), --index 2
    gfx.new_mesh(), --index 3
    gfx.new_mesh(), --index 4
    gfx.new_mesh(), --index 5

    gfx.new_mesh(), --index 6
    gfx.new_mesh(), --index 7
    gfx.new_mesh(), --index 8
    gfx.new_mesh(), --index 9
    gfx.new_mesh(), --index 10
    gfx.new_mesh(), --index 11
    gfx.new_mesh(), --index 12
    gfx.new_mesh(), --index 13
    gfx.new_mesh(), --index 14
    gfx.new_mesh(), --index 15
    gfx.new_mesh(), --index 16
    gfx.new_mesh(), --index 17
    gfx.new_mesh(), --index 18
    gfx.new_mesh(), --index 19
    gfx.new_mesh(), --index 20

}
--BOSS1 MESH
gfx.add_poly2(meshes[1], {0, 0, 15}, 15, 0xffffffff, 90, 40)
gfx.add_poly2(meshes[2], {0, 0, 15}, 10, 0xffffffff, 70, 37)
gfx.add_poly2(meshes[3], {0, 0, 15}, 5, 0xffffffff, 50, 35)
gfx.add_exstar(meshes[4], {0, 0, 15}, 0xffffffff, 120, 20)
--BOSS1 BULLET
gfx.add_ball(meshes[5], {0,0,0}, {0x00aa22ff}, 5)
--BOSS1 ORBITER
gfx.add_poly2(meshes[6], {0, 0, 40}, 6, 0xffffffff, 52, 25)

--BOSS2 MESH
local Boss2Color = 0x546df7ff
local Boss2Color2 = 0x9450d9ff
local ColorList = {Boss2Color, Boss2Color2}
local HurtColors = {0xff5852ff, 0xff5252ff}
gfx.add_ball(meshes[7], {0,0,0}, ColorList, 5)
gfx.add_ball(meshes[15], {0,0,0}, {0xaa2200ff}, 5)

gfx.add_poly2(meshes[8], {0, 0, 15}, 20, 0x3250a8ff, 60, 20)
gfx.add_poly2(meshes[9], {0, 0, 15}, 15, 0x5f32a8ff, 50, 20)
gfx.add_poly2(meshes[10], {0, 0, 15}, 10, 0x5f32a8ff, 40, 20)
gfx.add_poly2(meshes[11], {0, 0, 15}, 10, 0x9232a8ff, 30, 20)

--BOSS2 BULLET
gfx.add_poly2(meshes[12], {0, 0, 0}, 40, 0xfa32a8ff, 10, 2)
gfx.add_poly2(meshes[12], {0, 0, 0}, 40, 0xfa32a8ff, 4, 2)

--BOSS2 RAIN
gfx.add_sphere2(meshes[13], {0,0,0}, 0xf79b54ff, 20)
gfx.add_poly2(meshes[14], {0, 0, 0}, 40, 0xff3333ff, 60, 2)

--BOSS2 ENEMY BULLET
gfx.add_3D_diamond(meshes[16], {0, 0, 15}, 0xffffffff, 10)

--BOSS2 PROJECTILE
gfx.add_sphere(meshes[17], {0,0,0}, 0xffffffff, 10)

--BOSS3 ORBITER
gfx.add_poly2(meshes[18], {0, 0, 0}, 4, 0xffffffff, 20, 5, 2)

--BOSS3 BULLET
gfx.add_sphere2(meshes[19], {0,0,0}, 0x4abaffff, 5)
gfx.add_poly2(meshes[19], {0, 0, 0}, 40, 0x4abaffff, 35, 2)
-- gfx.add_poly2(meshes[19], {0, 0, 0}, 40, 0x9019ffff, 15, 2)

--BOSS3 STAR

gfx.add_exstar(meshes[20], {0, 0, 0}, 0xffffffff, 30, 5)

--DODGE MESH
gfx.add_exstar(meshes[21], {0, 0, 15}, 0xffffffff, 90, 40)



