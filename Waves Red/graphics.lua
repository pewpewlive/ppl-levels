local mesh = {
  vertexes = {},
  colors = {},
  segments = {},
}

local Delaunay = require("/dynamic/delauney.lua")
local Point = Delaunay.Point

local width = 900
local height = 650
--local color1 = 0x00808040
--local color2 = 0xff101040
-- local color1 =0xe3b50560
-- local color2 =0x044b7f60
local color1 =0xc7000060
local color2 =0xfffd8f60

local half_width = width // 2

local points = {}
for i = 1, half_width do
  local x = i * 2 -- Guarantees that no points are too close to each other.
  local y = math.random() * height * 0.25
  y = y + (height * 0.25) * (i % 4);

  if i < 24 then
    local pos = {{-1,-1}, {width+1,-1}, {width+1,height+1}, {-1,height+1}}

    if i <= 4 then
        x = pos[i][1]
        y = pos[i][2]
    else
        local n = (i % 4) + 1
        local n2 = (n % 4) + 1
        local percentage = math.random()
        x = pos[n][1]
        y = pos[n][2]
        local dx = pos[n2][1] - x
        local dy = pos[n2][2] - y
        x = x + dx * percentage
        y = y + dy * percentage
        x = x + -1 + 2 * math.random()
        y = y + -1 + 2 * math.random()
    end
  end

  local z = (math.sin(y / 50) + math.sin(x / 50)) * 140
  if z > 0 then
    z = -z
  end
  local color = color1

  if math.random() < 0.5 then
    color = color2
  end

  if i <= -8 then
    local xs = {0, width, width, 0, width / 2, width, width / 2, 0}
    local ys = {0, 0, height, height, 0, height / 2, height, height / 2}
    x = xs[i]
    y = ys[i]
    z = 0
  end

  table.insert(mesh.vertexes, {x,y, z})
  table.insert(mesh.colors, color)
  points[i] = Point(x, y)
end

-- Triangulating the convex polygon made by those points
local triangles = Delaunay.triangulate(table.unpack(points))

local segments_added = {}

function contains(t, e)
    return t[e]
end

function getIndex(a, b)
    if a > b then
        return a + 1000 * b
    end
    return b + 1000 * a
end

for i, triangle in ipairs(triangles) do
  local p1 = triangle.p1.id
  local p2 = triangle.p2.id
  local p3 = triangle.p3.id

  local i1 = getIndex(p1, p2)
  local i2 = getIndex(p2, p3)
  local i3 = getIndex(p3, p1)

  if contains(segments_added, i1) == False then
    table.insert(mesh.segments, {triangle.p1.id - 1, triangle.p2.id -1})
    segments_added[i1] = true
  end

  if contains(segments_added, i2) == False then
    table.insert(mesh.segments, {triangle.p2.id - 1, triangle.p3.id -1})
    segments_added[i2] = true
  end

  if contains(segments_added, i3) == False then
    table.insert(mesh.segments, {triangle.p3.id - 1, triangle.p1.id -1})
    segments_added[i3] = true
  end
end

meshes = {
    mesh
}
