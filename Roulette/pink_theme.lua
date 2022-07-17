local create = require("/dynamic/helpers/mesh_helpers.lua").add_horizontal_regular_rectangular_polygon_to_mesh
local new = require("/dynamic/helpers/mesh_helpers.lua").new_mesh

meshes = {new()}

local tau = math.pi * 2

local offset = tau / 8

local height = 458
local width = 567
local height_increase = 35
local width_increase = 35

for j = 0, 250 do
  create(meshes[1], {0,0,-j*j}, width + (width_increase * (j - 1)), height + (height_increase * (j - 1)), 4, 0xff00ff60, offset - ((tau / 72) * j))
end 
--thanks skpg