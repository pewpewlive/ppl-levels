local gfx = require("/dynamic/graphics_helper.lua")

meshes = {gfx.new_mesh(),gfx.new_mesh()}

gfx.blue_theme_wall(meshes[1],{0,0,0},0,0,255,255)
gfx.blue_theme_wall(meshes[2],{0,0,0},0,0,0,0)