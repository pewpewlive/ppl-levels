
local helper = require("/dynamic/helpers/mesh_helpers.lua")
local geometry = require("/dynamic/geometry_helpers.lua")

function make_snowflake()
  -- Step 1: create empty mesh
  -- Step 2: create the segments of 1 branch
  -- Step 3: add the segments to the mesh, rotated

  mesh = helper.new_mesh()

  local angle_of_branch = math.pi / 4
  local sin,cos = math.sincos(angle_of_branch)
  local radius = 9
  local color = 0xffffff99
  vertexes = {{-radius,0, 0}, {radius,0, 0}}
  colors = {color, color}
  local x = 1
  while x < radius do
    local x0 = x
    local y0 = 0
    local r = math.random(1,7 - (x // 2))
    if x < radius / 2 then
      r = r * 0.8
    end
    local x1 = x + r * cos
    local y1 = r * sin
    table.insert(vertexes, {x0, y0, 0})
    table.insert(vertexes, {x1, y1, 0})
    table.insert(vertexes, {x0, -y0, 0})
    table.insert(vertexes, {x1, -y1, 0})

    table.insert(vertexes, {-x0, y0, 0})
    table.insert(vertexes, {-x1, y1, 0})
    table.insert(vertexes, {-x0, -y0, 0})
    table.insert(vertexes, {-x1, -y1, 0})
    for i=1,8 do
      table.insert(colors, color)
    end
    x = x + math.random(1,4)
  end

  helper.add_segments_to_mesh(mesh, vertexes, colors)

  vertexes2 = geometry.rotate_vertexes_around_z(vertexes, math.pi / 3)
  vertexes3 = geometry.rotate_vertexes_around_z(vertexes, 2 * math.pi / 3)

  helper.add_segments_to_mesh(mesh, vertexes2, colors)
  helper.add_segments_to_mesh(mesh, vertexes3, colors)
  return mesh
end

meshes = {make_snowflake(), make_snowflake(), make_snowflake(), make_snowflake(), make_snowflake(), make_snowflake(), make_snowflake(), make_snowflake()}
