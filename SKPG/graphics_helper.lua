local color_helpers = require("/dynamic/helpers/color_helpers.lua")
-- This is NOT my helper, but FLAVOUR's, just modified
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

function helper.add_ex(mesh,center,color,length,height)
  local x = center[1]
  local y = center[2]
  local z = center[3]

  helper.add_line_to_mesh(mesh,{{x-length, y -height, z},{x + length, y + height, z}}, {color,color})
  helper.add_line_to_mesh(mesh,{{x-length, y +height, z},{x + length, y - height, z}}, {color,color})
end

function helper.add_white_line_to_mesh(mesh, vertexes, close_loop)
  local vertex_count = #mesh.vertexes
  --local color_count = #mesh.colors
  local segment_count = #mesh.segments
  local number_of_new_segments = #vertexes - 1
  local segments = {}

  for i = 1, #vertexes do
    table.insert(mesh.vertexes, vertexes[i])
    --table.insert(mesh.colors, colors[i])
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

function helper.add_filled_rectangle(mesh, center, height, length, color)
  local x = center[1]
  local y = center[2]
  local z = center[3]

  for i = -length, length do
    helper.add_line_to_mesh(mesh,{{x + i, y + height, z},{x + i, y - height, z}}, {color,color})
  end

end

function cf(x, radius)
  return math.sqrt(radius^2 - x^2)
end

function helper.add_disk(mesh,center,radius,color)
  local x = center[1]
  local y = center[2]
  local z = center[3]

  for i = -radius, radius do
    local height = cf(i, radius)
    helper.add_line_to_mesh(mesh,{{x + i, y + height, z},{x + i, y - height, z}}, {color,color})
  end

end

function helper.add_cube_to_mesh(mesh, center, side_length, color)
  local half = side_length / 2
  local x = center[1]
  local y = center[2]
  local z = center[3]

  local a = {x, y - half, z - half}
  local b = {x - half, y, z - half}
  local c = {x, y + half, z - half}
  local d = {x + half, y, z - half}
  local e = {x, y - half, z + half}
  local f = {x - half, y, z + half}
  local g = {x, y + half, z + half}
  local h = {x + half, y, z + half}

  helper.add_line_to_mesh(mesh, {a, b, c, d}, {color, color, color, color}, true)
  helper.add_line_to_mesh(mesh, {e, f, g, h}, {color, color, color, color}, true)
 
  helper.add_line_to_mesh(mesh, {a, e}, {color, color})
  helper.add_line_to_mesh(mesh, {b, f}, {color, color})
  helper.add_line_to_mesh(mesh, {c, g}, {color, color})
  helper.add_line_to_mesh(mesh, {d, h}, {color, color})
end

function helper.add_flat_poly_angle(mesh, center, sides, color, radius, startangle)
  if sides > 2 then
    local x = center[1]
    local y = center[2]
    local z = center[3]
    local vertices = {} --One "face" of the shape
    local colors = {}

    --Plots the vertices
    for i = 1, sides do
      local angle = (math.pi * 2 * i)/sides + startangle
      table.insert(vertices, {x + radius * math.cos(angle),y + radius * math.sin(angle), z})
      table.insert(colors, color)
    end

    --Draws the segments between each vertex
    helper.add_line_to_mesh(mesh, vertices, colors ,true)
  end
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

function helper.add_poly2(mesh, center, sides, color, radius, second_radius, height)
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
      table.insert(vertices, {x + radius * math.cos(angle),y + second_radius * math.sin(angle), z + height})
      table.insert(vertices2, {x + radius * math.cos(angle),y + second_radius * math.sin(angle), z - height})
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
  local plus_reduce = 1

    for i = -4, 4 do
    for j = 1, (1+f(i)^2) do
      local angle = (math.pi * 2 * j)/(1+f(i)^2)
      local scale = radius
      local xchange = i * scale
      local ychange = math.sin(angle) * scale * f(i)
      local zchange = math.cos(angle) * scale * f(i)
      
      helper.add_plus(mesh, {x + xchange, y + ychange, z + zchange}, color, radius/plus_reduce)
    end
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

function helper.add_grid_map(mesh,center,color,width,height,frequency)
  local x = center[1]
  local y = center[2]
  local z = center[3]

  for x = center[1],width-frequency*2,frequency do
    local a = {x+frequency,y,z}
    local b = {x+frequency,y+height,z}

    helper.add_line_to_mesh(mesh,{a,b},{color,color})
  end
  for y = center[2],height-frequency*2,frequency do
    local a = {x,y+frequency,z}
    local b = {x+width,y+frequency,z}

    helper.add_line_to_mesh(mesh,{a,b},{color,color})
  end
end

function helper.add_elevating_squares(mesh,center,color,width,height,end_z,frequency,z_extra)
  local x = center[1]
  local y = center[2]
  local z = center[3]

  local r = color[1]
  local g = color[2]
  local b = color[3]
  local a2 = color[4]

  for z = center[3], end_z, frequency do
    local a1 = {x-width/2-z/4,y-height/2-z/4,z-z_extra}
    local b1 = {x+width/2+z/4,y-height/2-z/4,z-z_extra}
    local c1 = {x+width/2+z/4,y+height/2+z/4,z-z_extra}
    local d1 = {x-width/2-z/4,y+height/2+z/4,z-z_extra}

    --[[if frequency % frequency*2 == 0 then
      z_extra = - z_extra
    end]]
    local a2 = a2 - z/3
    local true_color = color_helpers.make_color(r,g,b,a2)
    local true_color2 = color_helpers.make_color(r+80,g,b,a2)

    helper.add_line_to_mesh(mesh,{a1,b1,c1,d1},{true_color,true_color2,true_color,true_color2},true)
  end
end

function helper.add_dot(mesh, center, color_list)
  local x = center[1]
  local y = center[2]
  local z = center[3]

  local color = color_list[math.random(1,#color_list)]

  local a = {x-1,y,z}
  local b = {x+1,y,z}
  local a2 = {x,y-1,z}
  local b2 = {x,y+1,z}

  helper.add_line_to_mesh(mesh, {a,b}, {color, color})
  helper.add_line_to_mesh(mesh, {a2,b2}, {color, color})
end

function helper.add_stars(mesh,center,width,height,depth,amount)
  local x = center[1]
  local y = center[2]
  local z = center[3]

  for i = 1, amount do
    local x2 = fmath.random_int(x,width)
    local y2 = fmath.random_int(y,height)
    local z2 = fmath.random_int(z,depth)

    helper.add_dot(mesh,{x2,y2,z2},{0xffffff90,0xffffff70,0xffffff50,0xffffff30})
  end
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

function helper.add_star(mesh, center, color, radius,angle)
  local x = center[1]
  local y = center[2]
  local z = center[3]
  local colors = {}
  local vertices = {}
  for i = 1, 5 do
          local angle = (math.pi * 2 * i)/5*2+angle
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

function helper.add_circle(mesh, center, color, radius)
  local x = center[1]
  local y = center[2]
  local z = center[3]
  local vertices = {}
  local colors = {}
  local vertex_amount = 50
  local increment = math.pi/vertex_amount
  for i = 0, vertex_amount do
      table.insert(vertices, {x + radius*(math.cos(increment*i*2)), y + radius*(math.sin(increment*i*2)), z})
      table.insert(colors,color)
  end

  helper.add_line_to_mesh(mesh, vertices, colors)
end

function helper.add_circle2(mesh, center, color, radius)
  local x = center[1]
  local y = center[2]
  local z = center[3]
  local vertices = {}
  local colors = {}
  local vertex_amount = 50
  local increment = math.pi/vertex_amount
  for i = 0, vertex_amount do
      table.insert(vertices, {x+ radius*(math.sin(increment*i*2)), y , z+ radius*(math.cos(increment*i*2))})
      table.insert(colors,color)
  end

  helper.add_line_to_mesh(mesh, vertices, colors)
end

function helper.add_circle3(mesh, center, color, radius)
  local x = center[1]
  local y = center[2]
  local z = center[3]
  local vertices = {}
  local colors = {}
  local vertex_amount = 50
  local increment = math.pi/vertex_amount
  for i = 0, vertex_amount do
      table.insert(vertices, {x, y + radius*(math.sin(increment*i*2)), z+ radius*(math.cos(increment*i*2))})
      table.insert(colors,color)
  end

  helper.add_line_to_mesh(mesh, vertices, colors)
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
  
  table.insert(vertices, {x, y + radius, z})
  table.insert(vertices, {x, y, z + radius})
  table.insert(vertices, {x, y - radius, z})

  table.insert(vertices2, {x, y + radius, z})
  table.insert(vertices2, {x + radius, y, z})
  table.insert(vertices2, {x, y - radius, z})

  table.insert(vertices3, {x, y + radius, z})
  table.insert(vertices3, {x, y, z - radius})
  table.insert(vertices3, {x, y - radius, z})

  table.insert(vertices4, {x, y + radius, z})
  table.insert(vertices4, {x - radius, y, z})
  table.insert(vertices4, {x, y - radius, z})

  table.insert(vertices5, {x, y, z + radius})
  table.insert(vertices5, {x + radius, y, z})
  table.insert(vertices5, {x, y, z - radius})
  table.insert(vertices5, {x - radius, y, z})

  helper.add_line_to_mesh(mesh, vertices, colors)
  helper.add_line_to_mesh(mesh, vertices2, colors)
  helper.add_line_to_mesh(mesh, vertices3, colors)
  helper.add_line_to_mesh(mesh, vertices4, colors)
  helper.add_line_to_mesh(mesh, vertices5, {color,color,color,color},true)

end

return helper