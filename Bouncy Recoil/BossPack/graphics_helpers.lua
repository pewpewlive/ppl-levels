local helper = {}

--- Creates a new empty mesh.
function helper.new_mesh()
  local mesh = {}
  mesh.vertexes = {}
  mesh.segments = {}
  mesh.colors = {}
  return mesh
end

--- Adds a line to a mesh.
-- @params mesh table: a properly formated mesh. Possibly created with `new_mesh`.
-- @params vertex table: a list of either 2D or 3D vertexes. The coordinates of the vertexes are floats.
-- @params colors table: a list of colors. There should be as many colors as there are vertexes.
-- @params close_loop boolean: whether the line should be a closed loop, with the first vertex being linked with the last vertex.
function helper.add_line_to_mesh(mesh, vertexes, colors, close_loop)
  local vertex_count = #mesh.vertexes
  local color_count = #mesh.colors
  local segment_count = #mesh.segments
  local number_of_new_segments = #vertexes - 1
  local segments = {}

  for i = 1, #vertexes do
    table.insert(mesh.vertexes, vertexes[i])
    table.insert(mesh.colors, colors[i])
  end

  table.insert(segments, vertex_count)
  for i = 1, number_of_new_segments do
    table.insert(segments, vertex_count + i)
  end
  if close_loop then
    table.insert(segments, vertex_count)
  end
  table.insert(mesh.segments, segments)
end

function helper.add_cube_to_mesh(mesh, center, side_length, color)
  local half = side_length / 2
  local x = center[1]
  local y = center[2]
  local z = center[3]

  local a = {x - half, y - half, z - half}
  local b = {x - half, y + half, z - half}
  local c = {x + half, y + half, z - half}
  local d = {x + half, y - half, z - half}
  local e = {x - half, y - half, z + half}
  local f = {x - half, y + half, z + half}
  local g = {x + half, y + half, z + half}
  local h = {x + half, y - half, z + half}

  helper.add_line_to_mesh(mesh, {a, b, c, d}, {color, color, color, color}, true)
  helper.add_line_to_mesh(mesh, {e, f, g, h}, {color, color, color, color}, true)
 
  helper.add_line_to_mesh(mesh, {a, e}, {color, color})
  helper.add_line_to_mesh(mesh, {b, f}, {color, color})
  helper.add_line_to_mesh(mesh, {c, g}, {color, color})
  helper.add_line_to_mesh(mesh, {d, h}, {color, color})
end

function helper.add_poly(mesh, center, sides, color, radius)
  if sides > 2 then
    local x = center[1]
    local y = center[2]
    local z = center[3]
    local vertices = {} --One "face" of the shape
    local vertices2 = {} --The second "face" of the shape
    local colors = {}

    --Plots the vertices
    for i = 1, sides do
      local angle = (math.pi * 2 * i)/sides
      table.insert(vertices, {x + radius * math.cos(angle),y + radius * math.sin(angle), z + radius})
      table.insert(vertices2, {x + radius * math.cos(angle),y + radius * math.sin(angle), z - radius})
      table.insert(colors, color)
    end

    --Draws the segments between each vertex
    helper.add_line_to_mesh(mesh, vertices, colors ,true)
    helper.add_line_to_mesh(mesh, vertices2, colors ,true)
    for i = 1, sides do
      helper.add_line_to_mesh(mesh, {vertices[i], vertices2[i]}, {color,color})
    end
  end
end

function helper.add_poly2(mesh, center, sides, color, radius, height)
  if sides > 2 then
    local x = center[1]
    local y = center[2]
    local z = center[3]
    local vertices = {} --One "face" of the shape
    local vertices2 = {} --The second "face" of the shape
    local colors = {}

    --Plots the vertices
    for i = 1, sides do
      local angle = (math.pi * 2 * i)/sides
      table.insert(vertices, {x + radius * math.cos(angle),y + radius * math.sin(angle), z + height})
      table.insert(vertices2, {x + radius * math.cos(angle),y + radius * math.sin(angle), z - height})
      table.insert(colors, color)
    end

    --Draws the segments between each vertex
    helper.add_line_to_mesh(mesh, vertices, colors ,true)
    helper.add_line_to_mesh(mesh, vertices2, colors ,true)
    for i = 1, sides do
      helper.add_line_to_mesh(mesh, {vertices[i], vertices2[i]}, {color,color})
    end
  end
end

function helper.add_poly3(mesh, center, sides, color, radius, radius2, height)
  if sides > 2 then
    local x = center[1]
    local y = center[2]
    local z = center[3]
    local vertices = {} --One "face" of the shape
    local vertices2 = {} --The second "face" of the shape
    local colors = {}

    --Plots the vertices
    for i = 1, sides do
      local angle = (math.pi * 2 * i)/sides
      table.insert(vertices, {x + radius * math.cos(angle),y + radius2 * math.sin(angle), z + height})
      table.insert(vertices2, {x + radius * math.cos(angle),y + radius2 * math.sin(angle), z - height})
      table.insert(colors, color)
    end

    --Draws the segments between each vertex
    helper.add_line_to_mesh(mesh, vertices, colors ,true)
    helper.add_line_to_mesh(mesh, vertices2, colors ,true)
    for i = 1, sides do
      helper.add_line_to_mesh(mesh, {vertices[i], vertices2[i]}, {color,color})
    end
  end
end

function helper.add_plus(mesh, center, color, radius)
  local x = center[1]
  local y = center[2]
  local z = center[3]
  local vertices = {}
  local vertices2 = {}
  local vertices3= {}

  table.insert(vertices,{x, y + radius, z})
  table.insert(vertices, {x, y - radius, z})
  table.insert(vertices2,{x + radius, y, z})
  table.insert(vertices2, {x - radius, y, z})
  table.insert(vertices3,{x, y, z - radius})
  table.insert(vertices3, {x, y, z + radius})

  helper.add_line_to_mesh(mesh, vertices, {color, color})
  helper.add_line_to_mesh(mesh, vertices2, {color, color})
  helper.add_line_to_mesh(mesh, vertices3, {color, color})

end

local function f(x)
  return math.sqrt(16-x*x)
end
local function f2(x)
  return math.sqrt(9-x*x)
end


function helper.add_ball(mesh, center, color, radius)
  local x = center[1]
  local y = center[2]
  local z = center[3]
  local plus_reduce = 3

    for i = -4, 4 do
    for j = 1, (1+f(i)^2) do
      local angle = (math.pi * 2 * j)/(1+f(i)^2)
      local scale = radius
      local xchange = i * scale
      local ychange = math.sin(angle) * scale * f(i)
      local zchange = math.cos(angle) * scale * f(i)
      
      helper.add_plus(mesh, {x + xchange, y + ychange, z + zchange}, color[math.random(1,#color)], radius/plus_reduce)
    end
  end
end

function helper.add_sphere2(mesh, center, color, radius)
  local x = center[1]
  local y = center[2]
  local z = center[3]
  local plus_reduce = 8
  local vertexes = {}
  local colors = {}

  for i = -3, 3 do
    for j = 1, (1+f(i)^2) do
      local angle = (math.pi * 2 * j)/(1+f(i)^2)
      local scale = radius
      local xchange = i * scale
      local ychange = math.sin(angle) * scale * f(i)
      local zchange = math.cos(angle) * scale * f(i)
      
      table.insert(vertexes,{x + xchange, y + ychange, z + zchange})
      table.insert(colors,color)
    end
    helper.add_line_to_mesh(mesh, vertexes, colors, true)
    colors = {}
    vertexes = {}
  end
end

function helper.add_sphere(mesh, center, color, radius)
  local x = center[1]
  local y = center[2]
  local z = center[3]
  local plus_reduce = 8
  local vertexes = {}
  local colors = {}

  for i = -3, 3 do
    for j = 1, (1+f(i)^2) do
      local angle = (math.pi * 2 * j)/(1+f(i)^2)
      local scale = radius
      local xchange = i * scale
      local ychange = math.sin(angle) * scale * f(i)
      local zchange = math.cos(angle) * scale * f(i)
      
      table.insert(vertexes,{x + xchange, y + ychange, z + zchange})
      table.insert(colors,color)
    end
    helper.add_line_to_mesh(mesh, vertexes, colors, true)
    colors = {}
    vertexes = {}
  end
  for i = -3, 3 do
    for j = 1, (1+f(i)^2) do
      local angle = (math.pi * 2 * j)/(1+f(i)^2)
      local scale = radius
      local ychange = i * scale
      local xchange = math.sin(angle) * scale * f(i)
      local zchange = math.cos(angle) * scale * f(i)
      
      table.insert(vertexes,{x + xchange, y + ychange, z + zchange})
      table.insert(colors,color)
    end
    helper.add_line_to_mesh(mesh, vertexes, colors, true)
    colors = {}
    vertexes = {}
  end
end

function helper.add_custom_shape(mesh, center, color, radius)
  local x = center[1]
  local y = center[2]
  local z = center[3]
  local vertices = {}
  local xsign = 0
  local ysign = 0
  local colors = {}


  --Plots the vertices in "quadrants"
  for i = 0, 3 do
    if i == 0 or i == 1 then
      xsign = 1
    end
    if i == 2 or i == 3 then
      xsign = -1
    end
    if i == 0 or i == 3 then
      ysign = 1
    end
    if i == 1 or i == 2 then
      ysign = -1
    end
    table.insert(vertices,{x + xsign*radius, y + ysign*3*radius, z})
    table.insert(vertices,{x + xsign*radius, y + ysign*radius, z})
    table.insert(vertices,{x + xsign*3*radius, y + ysign*radius, z})
    table.insert(colors, color)
    
  end

  helper.add_line_to_mesh(mesh, vertices, colors ,true)

end
function helper.add_big_plus(mesh, center, color, radius)
  local x = center[1]
  local y = center[2]
  local z = center[3]
  local vertices = {}
  local xsign = 0
  local ysign = 0
  local colors = {}

  --Plots the vertices in "quadrants"

  local c1_3 = {1,1,3}
  local c3_1 = {3,1,1}
  for i = 1,3 do
    table.insert(vertices,{x + radius*c1_3[i], y + radius*c3_1[i], z})
    table.insert(colors, color)
  end
  for i = 1,3 do
    table.insert(vertices,{x + radius*c3_1[i], y - radius*c1_3[i], z})
    table.insert(colors, color)
  end
  for i = 1,3 do
    table.insert(vertices,{x - radius*c1_3[i], y - radius*c3_1[i], z})
    table.insert(colors, color)
  end
  for i = 1,3 do
    table.insert(vertices,{x - radius*c3_1[i], y + radius*c1_3[i], z})
    table.insert(colors, color)
  end

  helper.add_line_to_mesh(mesh, vertices, colors ,true)

end

function helper.add_semi_circle(mesh, center, color, radius)
  local x = center[1]
  local y = center[2]
  local z = center[3]
  local vertices = {}
  local colors = {}
  local vertex_amount = 50
  local increment = math.pi/vertex_amount
  for i = 0, vertex_amount do
      table.insert(vertices, {x + radius*(math.cos(increment*i)), y + radius*(math.sin(increment*i)), z})
      table.insert(colors,color)
  end

  helper.add_line_to_mesh(mesh, vertices, colors)


end

function helper.add_multi_lines(mesh, center, color, radius)
  local x = center[1]
  local y = center[2]
  local z = center[3]
  local vertices = {}
  local vertices2 = {}
  local vertices3 = {}
  local colors = {}
  local spacingratio = 2

  table.insert(vertices, {x, y + radius, z})
  table.insert(vertices, {x, y - radius, z})
  table.insert(vertices2, {x + radius/spacingratio, y + radius, z})
  table.insert(vertices2, {x + radius/spacingratio, y - radius, z})
  table.insert(vertices3, {x - radius/spacingratio, y + radius, z})
  table.insert(vertices3, {x - radius/spacingratio, y - radius, z})
  for i = 0,6 do
    table.insert(colors, color)
  end

  helper.add_line_to_mesh(mesh, vertices, colors)
  helper.add_line_to_mesh(mesh, vertices2, colors)
  helper.add_line_to_mesh(mesh, vertices3, colors)



end

function helper.add_diagonals_map(mesh, length, height, section_count, padding, frequency, color)
  for i = 0, section_count-1 do
    local x = length/section_count*i + padding
    local x2 = length/section_count*(i + 1) - padding
    local z = 0
    local turn = -1
    local vertices = {}
    local colors = {}

    for i = 0, frequency do
      local y = height/frequency*i
      if turn < 0 then
        table.insert(vertices, {x, y, z})
        table.insert(colors, color)
      end
      if turn > 0 then
        table.insert(vertices, {x2, y, z})
        table.insert(colors, color)
      end
      turn = turn*(-1)

    end
    helper.add_line_to_mesh(mesh, vertices, colors)
  end
end

function helper.add_diamonds(mesh, length, height, section_count, frequency, color_list)
  local turn = -1
  for i = 1, section_count-1 do
    local x = length/section_count*i
    local x2 = length/section_count*(i + 1)
    local vertices = {}
    local colors = {}
    local radius = 20

    for i = 1, frequency-1 do
      local color = color_list[math.random(1,#color_list)]
      local y = height/frequency*i
      local z = math.random(-80,-10)
      local smallify = 0
      if turn < 0 then
        smallify = math.random(1,2)
      end
      if turn > 0 then
        smallify = math.random(3,5)
      end

      table.insert(vertices, {x, y + radius/smallify, z})
      table.insert(vertices, {x, y - radius/smallify, z})
      table.insert(colors, color)
      table.insert(colors, color)
      helper.add_line_to_mesh(mesh, vertices, colors)
      vertices = {}
      colors = {}

      table.insert(vertices, {x + radius/smallify, y, z})
      table.insert(vertices, {x - radius/smallify, y, z})
      table.insert(colors, color)
      table.insert(colors, color)
      helper.add_line_to_mesh(mesh, vertices, colors)
      vertices = {}
      colors = {}

      table.insert(vertices, {x, y + radius/smallify, z})
      table.insert(vertices, {x + radius/smallify, y, z})
      table.insert(vertices, {x, y - radius/smallify, z})
      table.insert(vertices, {x - radius/smallify, y, z})
      table.insert(colors, color)
      table.insert(colors, color)
      table.insert(colors, color)
      table.insert(colors, color)
      helper.add_line_to_mesh(mesh, vertices, colors, true)
      vertices = {}
      colors = {}
      turn = turn * (-1)
    end
    turn = turn * (-1)

  end
end

function helper.add_star(mesh, center, color, radius)
  local x = center[1]
  local y = center[2]
  local z = center[3]
  local colors = {}
  local vertices = {}
  for i = 1, 5 do
    local angle = (2*math.pi/5)*i*2
    local xchange = math.cos(angle)
    local ychange = math.sin(angle)
    table.insert(vertices,{x + xchange*radius, y + ychange*radius, z})
    table.insert(colors,color)
  end
  helper.add_line_to_mesh(mesh, vertices, colors, true)
end

function helper.add_exstar(mesh, center, color, radius, height)
  local x = center[1]
  local y = center[2]
  local z = center[3]
  local colors = {}
  local vertices = {}
  local vertices2 = {}
  for i = 1, 5 do
    local angle = (2*math.pi/5)*i*2
    local xchange = math.cos(angle)
    local ychange = math.sin(angle)
    local zchange = height
    table.insert(vertices,{x + xchange*radius, y + ychange*radius, z+zchange})
    table.insert(vertices2,{x + xchange*radius, y + ychange*radius, z-zchange})
    table.insert(colors,color)
  end
  helper.add_line_to_mesh(mesh, vertices, colors, true)
  helper.add_line_to_mesh(mesh, vertices2, colors, true)
  for i = 1, #vertices do
    helper.add_line_to_mesh(mesh, {vertices[i],vertices2[i]}, colors)
  end
end

function helper.add_3D_diamond(mesh, center, color, radius)
  local x = center[1]
  local y = center[2]
  local z = center[3]
  local colors = {color, color, color}
  local vertices = {}
  local vertices2 = {}
  local vertices3 = {}
  local vertices4 = {}
  local vertices5 = {}
  
  table.insert(vertices, {x, y + radius*2, z})
  table.insert(vertices, {x, y, z + radius})
  table.insert(vertices, {x, y - radius*2, z})

  table.insert(vertices2, {x, y + radius*2, z})
  table.insert(vertices2, {x + radius, y, z})
  table.insert(vertices2, {x, y - radius*2, z})

  table.insert(vertices3, {x, y + radius*2, z})
  table.insert(vertices3, {x, y, z - radius})
  table.insert(vertices3, {x, y - radius*2, z})

  table.insert(vertices4, {x, y + radius*2, z})
  table.insert(vertices4, {x - radius, y, z})
  table.insert(vertices4, {x, y - radius*2, z})

  table.insert(vertices5, {x, y, z + radius})
  table.insert(vertices5, {x + radius, y, z})
  table.insert(vertices5, {x, y, z - radius})
  table.insert(vertices5, {x - radius, y, z})

  helper.add_line_to_mesh(mesh, vertices, colors)
  helper.add_line_to_mesh(mesh, vertices2, colors)
  helper.add_line_to_mesh(mesh, vertices3, colors)
  helper.add_line_to_mesh(mesh, vertices4, colors)
  helper.add_line_to_mesh(mesh, vertices5, {color,color,color,color})

end

--- Returns a integer encoding a color.
-- @params r,g,b,a (integers in the [0,255] range): the red, green, blue, and alpha components of the color.
function helper.make_color(r, g, b, a)
  local color = r * 256 + g
  color = color * 256 + b
  color = color * 256 + a
  return color
end

function helper.print()
  pewpew.print("it works!")
end

return helper