-- ---------------------------------- --
-- --------- Fury-like mesh --------- --
-- -------- Fury mesh by: JF -------- --
-- ----- Modified by Tasty Kiwi ----- --
-- ---------------------------------- --

require("/static/graphics/helpers/color_helpers.lua")
require("/static/graphics/helpers/geometric_helpers.lua")

version = 1

meshes = {{vertexes = {}, segments = {}, colors = {}}}

local w = 500
local h = 300

-- Cube side.
local q = 50

local startColor
local endColor
local rng_number = math.random(1, 6)
if rng_number == 1 then
  -- Yellow (rolling cube)
  startColor = 0xffff00ff
  endColor = 0xffff00ff
elseif rng_number == 2 then
  -- Blue (wary)
  startColor = 0x2020ffff
  endColor = 0x2020ffff
elseif rng_number == 3 then
  -- Green (rolling cube)
  startColor = 0x80ff00ff
  endColor = 0x80ff00ff
elseif rng_number == 4 then
  -- Orange (rolling cube)
  startColor = 0xff8000ff
  endColor = 0xff8000ff
elseif rng_number == 5 then
  -- Beige (rolling cube)
  startColor = 0xb6b060ff
  endColor = 0xb6b060ff
elseif rng_number == 6 then
  -- Purple (wary)
  startColor = 0xaa10ffff
  endColor = 0xaa10ffff
end

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