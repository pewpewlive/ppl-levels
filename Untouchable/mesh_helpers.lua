
require'/dynamic/def.lua'
meshes_path = ASSETS_PATH .. 'common/meshes/'

pi = math.pi
tau = pi * 2

sin = math.sin
cos = math.cos

function def_mesh()
  return {vertexes = {}, segments = {}, colors = {}}
end

function def_meshes()
  meshes = {{vertexes = {}, segments = {}, colors = {}}}
end

function def_vsc(mesh)
  return mesh.vertexes, mesh.segments, mesh.colors
end

function make_color(r, g, b, a)
	return ((r * 256 + g) * 256 + b) * 256 + a
end

function create_circle(mesh, index_offset, radius, vertex_amount, angle_offset)
  local da = pi * 2 / vertex_amount
  local segment = {}
  for i = 1, vertex_amount do
    local angle = i * da + angle_offset
    table.insert(mesh.vertexes, {radius * cos(angle), radius * sin(angle)})
    table.insert(segment, i + index_offset - 1)
  end
  table.insert(segment, index_offset)
  table.insert(mesh.segments, segment)
end

function copy_vertexes(v1, v2, mod_vertex)
  for i = 1, #v1 do
    table.insert(v2, mod_vertex(v1[i]))
  end
end

function copy_segments(s1, s2, index_offset)
  for i = 1, #s1 do
    local segment = {}
    for n = 1, #s1[i] do
      table.insert(segment, index_offset + s1[i][n])
    end
    table.insert(s2, segment)
  end
end

function insert_color(colors, color, n)
  for i = 1, n do
    table.insert(colors, color)
  end
end

function rotate_vector3f(x, y, z, rx, ry, rz)
  local l, angle
  
  l = math.sqrt(y ^ 2 + z ^ 2)
  angle = math.atan(z, y) + rx
  y = l * cos(angle)
  z = l * sin(angle)
  
  l = math.sqrt(x ^ 2 + z ^ 2)
  angle = math.atan(z, x) + ry
  x = l * cos(angle)
  z = l * sin(angle)
  
  l = math.sqrt(x ^ 2 + y ^ 2)
  angle = math.atan(y, x) + rz
  x = l * cos(angle)
  y = l * sin(angle)
  
  return x, y, z
end
