local gfx = require'/dynamic/helpers/graphics_helpers.lua'

meshes = {
    gfx.new_mesh(),
    gfx.new_mesh()
}

local sides = 12

gfx.add_flat_poly_angle_verts(meshes[1], {0,0,0}, sides, 0xffffff66, 25, 0)

gfx.add_flat_poly_angle_verts(meshes[1], {0,0,20}, sides, 0xffffffff, 15, 0.11)

for i = 0, sides-1 do
    table.insert(meshes[1].segments,{i,i+sides})
end

gfx.add_flat_poly_angle_verts(meshes[2], {0,0,0}, sides, 0xffffff66, 40, 0)

gfx.add_flat_poly_angle_verts(meshes[2], {0,0,20}, sides, 0xffffffaa, 27, -0.11)

for i = 0, sides-1 do
    table.insert(meshes[2].segments,{i,i+sides})
end