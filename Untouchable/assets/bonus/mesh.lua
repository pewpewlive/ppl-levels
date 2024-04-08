
require'/dynamic/mesh_helpers.lua'

meshes = {}

a = 16
b1 = 20
b2 = 4
c = 8
z1 = -10
z2 = 40
zo = 10

f = pi / 3

__s = {
  {0, 1, 2, 0}, {3, 4, 5, 3}, {0, 3}, {1, 4}, {2, 5},
}

param = require(ASSETS_PATH .. 'bonus/animation.lua')

frame_amount = param.frame_amount
variation_amount = param.variation_amount

-- base definitions and box creation ; 3 for weapons ; 1 for shield

function create_box_animation(color)
  for i = 1, frame_amount do
    local index = 0
    local b = b1 + b2 * sin(i / frame_amount * tau)
    local mesh = def_mesh()
    local v, s, colors = def_vsc(mesh)
    for n = 0, 5 do
      local k = (n % 3) * tau / 3
      table.insert(v, {a * cos(k), a * sin(k), n > 2 and z2 or z1})
    end
    copy_segments(__s, s, index)
    for q = 0, 2 do
      index = #v
      copy_segments(__s, s, index)
      local p = q / 3 * tau + f
      for n = 0, 5 do
        local k = (n % 3) * tau / 3 + f
        table.insert(v, {c * cos(k) + b * cos(p), c * sin(k) + b * sin(p), n > 2 and z2 - zo or z1 + zo})
      end
    end
    for n = 1, #v do
      table.insert(colors, color)
    end
    table.insert(meshes, mesh)
  end
end

weapon_box_color = 0x40f0a0ff
for i = 1, variation_amount - 1 do
  create_box_animation(weapon_box_color)
end

shield_box_color = 0xd0ff40ff
create_box_animation(shield_box_color)

-- adding elements to boxes ; base definitions

h = (z2 + z1) / 2
rx = math.random() * tau
ry = math.random() * tau
rz = math.random() * tau
l = math.sqrt(rx ^ 2 + ry ^ 2 + rz ^ 2)
t = 1
if l > t then
  rx = rx / l * t
  ry = ry / l * t
  rz = rz / l * t
end

function add_object_to_box(mesh_offset, vertexes, segments)
  local index = #meshes[mesh_offset + 1].vertexes
  for i = mesh_offset + 1, mesh_offset + frame_amount do
    local k = math.cos(i / frame_amount * tau)
    copy_segments(segments, meshes[i].segments, index)
    copy_vertexes(vertexes, meshes[i].vertexes, function(vertex)
      local x, y, z = table.unpack(vertex)
      x, y, z = rotate_vector3f(x, y, z, rx * k, ry * k, rz * k)
      return {x, y, z + h}
    end)
    insert_color(meshes[i].colors, color, #vertexes)
  end
end

-- adding elements to boxes

-- pinky
m = 3 ^ 0.5 / 2
a = 9
b = 2
color = 0xff30a0ff
__v = {
  {b, a / 2, 0}, {b + a * m, 0, 0}, {b, -a / 2, 0},
  {-b, a / 2, 0}, {-b - a * m, 0, 0}, {-b, -a / 2, 0},
}
__s = {
  {0, 1, 2, 0}, {3, 4, 5, 3},
}
add_object_to_box(0, __v, __s)

-- candy
m = 3 ^ 0.5 / 2
a = 8
color = 0xffff20ff
triangle_amount = 2
offset = 4
__v = {
  {-a * m / 3, a / 2, 0}, {a * m / 3 * 2, 0, 0}, {-a * m / 3, -a / 2, 0},
}
__s = {
  {0, 1, 2, 0}
}
for i = 1, triangle_amount do
  local k = (a + offset * i) / a
  for n = 1, 3 do
    table.insert(__v, {__v[n][1] * k, __v[n][2] * k, 0})
  end
  table.insert(__s, {i * 3, i * 3 + 1, i * 3 + 2, i * 3})
end
add_object_to_box(frame_amount, __v, __s)

-- potato
r = 5
vertex_amount = 5
figure_amount = 4
offset = 1.75
color = 0xff8020ff
__m = def_mesh()
for i = 0, figure_amount - 1 do
  create_circle(__m, #__m.vertexes, r + offset * i, vertex_amount, 0)
end
for i = 1, #__m.vertexes do
  table.insert(__m.vertexes[i], 0)
end
add_object_to_box(frame_amount * 2, __m.vertexes, __m.segments)

-- player_laser
a = 16
b = -a / 2
c = 2
angle = 0.4
sa = a * sin(angle)
ca = a * cos(angle)
color = 0x40ff00ff
__v = {
  {b, 0, 0}, {b + a, 0, 0}, {b + ca, sa, 0}, {b + ca, -sa, 0}, {b, c, 0}, {b, -c, 0},
}
__s = {
  {0, 1}, {4, 2}, {5, 3},
}
add_object_to_box(frame_amount * 3, __v, __s)

-- shield
a = 3
b = 3 * a
color = shield_box_color
__v = {
  {a, a, 0}, {b, a, 0}, {b, -a, 0},
  {a, -a, 0}, {a, -b, 0}, {-a, -b, 0}, 
  {-a, -a, 0}, {-b, -a, 0}, {-b, a, 0},
  {-a, a, 0}, {-a, b, 0}, {a, b, 0},
}
__s = {
  {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0}
}
add_object_to_box(frame_amount * 4, __v, __s)
