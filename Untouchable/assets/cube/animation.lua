
local mesh_path = string.format('%smesh.lua', current_folder_path)

local frame_amount = 120

return {
  
  template = 0,
  frames_per_tick = 2,
  frame_offset = 0,
  variation_amount = 1,
  frame_amount = frame_amount,
  path = mesh_path,
  
  actions = {
    {'wait', 180},
    {'loop', 0, frame_amount}
  },
  
}
