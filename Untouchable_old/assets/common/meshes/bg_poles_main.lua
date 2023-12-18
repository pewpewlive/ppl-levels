
function create_poles_mesh(mesh, x1, y1, x2, y2, pole_amount_x, pole_amount_y, index_offset, get_random_x, get_random_y, get_z1_z2)
  local v, s, c = def_vsc(mesh)
  local step_x = (x2 - x1) / pole_amount_x
  local step_y = (y2 - y1) / pole_amount_y
  for i = 0, pole_amount_y do
    for n = 0, pole_amount_x do
      local rx = get_random_x()
      local ry = get_random_y()
      local z1, z2 = get_z1_z2(i, n)
      table.insert(v, {
        x1 + n * step_x + rx,
        y1 + i * step_y + ry,
        z1
      })
      table.insert(v, {
        x1 + n * step_x + rx,
        y1 + i * step_y + ry,
        z2
      })
      table.insert(s, {index_offset, index_offset + 1})
      index_offset = index_offset + 2
    end
  end
  return index_offset
end

return create_poles_mesh
