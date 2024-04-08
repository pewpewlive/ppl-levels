min_z = -10
min_zr = -10
max_z = 10
max_zr = 10

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
  local ratio = math.sin(i / (pole_amount_y + 1) * angle_ratio) + math.cos(n / (pole_amount_x + 1) * angle_ratio_x + angle_offset_x)
  return  min_z + min_zr * ratio * math.random(),
          max_z + max_zr * ratio * math.random()
end

max_rx = 0
max_ry = 0
function get_random_x()
  return (math.random() * 2 - 1) * max_rx
end
function get_random_y()
  return (math.random() * 2 - 1) * max_ry
end

require(meshes_path .. 'bg_poles_main.lua')(meshes[1], 6, 6, width - 6, height - 6, pole_amount_x, pole_amount_y, 0, get_random_x, get_random_y, get_z1_z2)