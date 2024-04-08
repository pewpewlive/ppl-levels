min_z = -10
min_zr = -40
max_z = 50
max_zr = 150

require'/dynamic/mesh_helpers.lua'

def_meshes()

width = fmath.to_int(LEVEL_SIZE_X)
height = fmath.to_int(LEVEL_SIZE_Y)

pole_amount_x = 100
pole_amount_y = 75
angle_ratio = math.pi * math.pi
angle_ratio_x = angle_ratio / height * width
angle_offset_x = math.pi * height / width
function get_z1_z2(i, n)
  return  min_z + min_zr * math.random(),
          max_z + max_zr * math.random()
end

max_rx = 2
max_ry = 2
function get_random_x()
  return (math.random() * 2 - 1) * max_rx
end
function get_random_y()
  return (math.random() * 2 - 1) * max_ry
end

require(meshes_path .. 'bg_poles_main.lua')

pole_distance = 10
pole_border_amount = 20

local offset = pole_distance * pole_border_amount
local border_offset_x = width / pole_amount_x

local index = 0

index = create_poles_mesh(meshes[1], -offset, -offset, 0, height + offset, pole_border_amount, pole_border_amount * 2 + pole_amount_y,
  index, get_random_x, get_random_y, get_z1_z2)
index = create_poles_mesh(meshes[1], width, -offset, width + offset, height + offset, pole_border_amount, pole_border_amount * 2 + pole_amount_y,
  index, get_random_x, get_random_y, get_z1_z2)
index = create_poles_mesh(meshes[1], border_offset_x, -offset, width - border_offset_x, 0, pole_amount_x - 2, pole_border_amount,
  index, get_random_x, get_random_y, get_z1_z2)
index = create_poles_mesh(meshes[1], border_offset_x, height, width - border_offset_x, height + offset, pole_amount_x - 2, pole_border_amount,
  index, get_random_x, get_random_y, get_z1_z2)