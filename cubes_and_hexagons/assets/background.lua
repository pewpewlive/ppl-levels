-- ---------------------------------- --
-- --------- Fury-like mesh --------- --
-- -------- Fury mesh by: JF -------- --
-- ----- Modified by Tasty Kiwi ----- --
-- ---------------------------------- --

require("/dynamic/helpers/fury_gfx_helpers.lua")

meshes = {{vertexes = {}, segments = {}, colors = {}}}

local w = 500
local h = 300

-- Cube side.
local q = 50

local startColor = 0xffffffff
local endColor = 0xffffffff

local minX = -500
local minY = -500
local minZ = 0
local maxX = w + 500
local maxY = h + 300

local maxZ = 1 * q

for z = minZ, maxZ, q do
  local percentage = (z - minZ) / (maxZ - minZ)
  local color = InterpolateColor(startColor, endColor, percentage)
  local lightColor = ColorWithAlpha(color, 50)
  for x = minX, maxX, q do
    if x <= 0 or x >= w then
      AddLineToMesh(meshes[1], {{x, minY, z}, {x, maxY, z}}, {color, color})
    else
      AddLineToMesh(meshes[1], {{x, minY, z}, {x, 0, z}}, {color, color})
      AddLineToMesh(meshes[1], {{x, h, z}, {x, maxY, z}}, {color, color})
      if z == 0 then
        AddLineToMesh(meshes[1], {{x, 0, z}, {x, h, z}}, {lightColor, lightColor})
      end
    end
  end

  for y = minY, maxY, q do
    if y <= 0 or y >= h then
      AddLineToMesh(meshes[1], {{minX, y, z}, {maxX, y, z}}, {color, color})
    else
      AddLineToMesh(meshes[1], {{minX, y, z}, {0, y, z}}, {color, color})
      AddLineToMesh(meshes[1], {{w, y, z}, {maxX, y, z}}, {color, color})
      if z == 0 then
        AddLineToMesh(meshes[1], {{0, y, z}, {w, y, z}}, {lightColor, lightColor})
      end
    end
  end
end

for x = minX, maxX, q do
  for y = minY, maxY, q do
    if x <= 0 or x >= w or y <= 0 or y >= h then
      AddLineToMesh(meshes[1], {{x, y, minZ}, {x, y, maxZ}}, {startColor, endColor})
    end
  end
end