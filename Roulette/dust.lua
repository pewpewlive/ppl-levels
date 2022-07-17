local new = require("/dynamic/helpers/mesh_helpers.lua").new_mesh
local color = require("/dynamic/helpers/color_helpers.lua").make_color_with_alpha

meshes = {new()}

local counter = 0

local function addDustParticle(x, y, z)
  table.insert(meshes[1].vertexes, {x - 2, y, z})
  table.insert(meshes[1].vertexes, {x + 2, y, z})
  table.insert(meshes[1].vertexes, {x, y + 2, z})
  table.insert(meshes[1].vertexes, {x, y - 2, z})

  table.insert(meshes[1].segments, {counter, counter + 1})
  table.insert(meshes[1].segments, {counter + 2, counter + 3})

  local alpha = math.random(0, 150)

  table.insert(meshes[1].colors, color(0xffff00ff, alpha))
  table.insert(meshes[1].colors, color(0xffff00ff, alpha))
  table.insert(meshes[1].colors, color(0xffff00ff, alpha))
  table.insert(meshes[1].colors, color(0xffff00ff, alpha))
  
  counter = counter + 4
end

local radius = 1500
local height_bound = 2400

local particle_count = 2400
local sub_count = 720

for i = 1, 1000 do
  for j = 1, particle_count // sub_count do 
    addDustParticle(math.cos(i) * radius, math.random(0, height_bound), math.sin(i) * radius)
  end
end
--thanks skpg