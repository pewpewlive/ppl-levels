local gfx = require'/dynamic/helpers/graphics_helpers.lua'

meshes = {
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
    gfx.new_mesh(),
}

for i = 1, #meshes do
    gfx.add_flat_poly_angle(meshes[i],{0,0,0},20,0xffffffff,7,0)
    gfx.add_flat_poly_angle(meshes[i],{0,0,3},20,0xffffff90,3,0)
end