local gfx = require("/dynamic/helpers/mesh_helpers.lua")
local color_helper = require("/dynamic/helpers/color_helpers.lua")

local w = 900
local h = 700


local mesh = gfx.new_mesh()

-- Stars
local a = 30
local b = 6
local c = 0xff000030
for x = 0, 8 do
  for y = 0, 6 do
    if (x + y) % 2 == 0 then
      local center_x = 50 + 100 * x
      local center_y = 50 + 100 * y
      gfx.add_line_to_mesh(mesh, {{center_x + a,center_y},{center_x + b,center_y+b},{center_x + 0,center_y+a},{center_x-b,center_y+b},{center_x-a,center_y},{center_x-b,center_y-b},{center_x,center_y-a},{center_x+b,center_y-b}}, {c,c,c,c,c,c,c,c}, true)
    end
  end
end

-- Lines
local green = 0
for z=0,100,10 do
  local c2 = color_helper.make_color(255, green, 0, 255)
  green = green + 10


  gfx.add_segments_to_mesh(mesh, {{0, 0, z}, {0, h, z}}, {c2, c2})
  gfx.add_segments_to_mesh(mesh, {{w, 0, z}, {w, h, z}}, {c2, c2})

  gfx.add_segments_to_mesh(mesh, {{0, 0, z}, {w, 0, z}}, {c2, c2})
  gfx.add_segments_to_mesh(mesh, {{0, h, z}, {w, h, z}}, {c2, c2})
end


local z = 100
for i=-10,-100,-10 do
  local c2 = color_helper.make_color(255, green, 0, 255)
  green = green + 10

  gfx.add_segments_to_mesh(mesh, {{i, 0, z}, {i, h, z}}, {c2, c2})
  gfx.add_segments_to_mesh(mesh, {{w-i, 0, z}, {w-i, h, z}}, {c2, c2})

  gfx.add_segments_to_mesh(mesh, {{0, h-i, z}, {w, h-i, z}}, {c2, c2})

  gfx.add_segments_to_mesh(mesh, {{0, i, z}, {w, i, z}}, {c2, c2})
end

gfx.add_cube_to_mesh(mesh, {-50,-50,50}, 100, 0xffff00ff)

gfx.add_cube_to_mesh(mesh, {w+50,-50,50}, 100, 0xffff00ff)
gfx.add_cube_to_mesh(mesh, {w+50,h+50,50}, 100, 0xffff00ff)
gfx.add_cube_to_mesh(mesh, {-50,h+50,50}, 100, 0xffff00ff)

meshes = {
  mesh,
}
