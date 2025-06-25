function MakeColor(r, g, b, a)
  local color = r * 256 + g
  color = color * 256 + b
  color = color * 256 + a
  return color
end

function InterpolateColor(color1, color2, percentage)
  local r1 = (color1 >> 24) & 0xff
  local g1 = (color1 >> 16) & 0xff
  local b1 = (color1 >> 8) & 0xff
  local a1 = (color1) & 0xff

  local r2 = (color2 >> 24) & 0xff
  local g2 = (color2 >> 16) & 0xff
  local b2 = (color2 >> 8) & 0xff
  local a2 = (color2) & 0xff

  local r3 = r1 + (r2 - r1) * percentage
  local g3 = g1 + (g2 - g1) * percentage
  local b3 = b1 + (b2 - b1) * percentage
  local a3 = a1 + (a2 - a1) * percentage

  return MakeColor(r3, g3, b3, a3)
end

function ColorWithAlpha(color, new_alpha)
  local alpha = color % 256
  color = color - alpha + new_alpha
  return color
end

function AddLineToMesh(mesh, vertexes, colors)
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
  table.insert(mesh.segments, segments)
end
