
local s = {}

function angle_to_player(x, y, ship_id)
  if pewpew.entity_get_is_alive(ship_id) == false then
    return fmath.random_fixedpoint(0fx, 100fx)
  end
  local px, py = pewpew.entity_get_position(ship_id)
  return fmath.atan2(py - y, px - x)
end

function s.new(x, y, ship_id)
  local id = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_start_spawning(id, 0)
  pewpew.customizable_entity_set_mesh_scale(id, 3fx)

  local z = 1000fx
  local angle = 0fx
  local d_angle = fmath.random_fixedpoint(-10fx, 10fx) / 50fx
  local z_axis = fmath.random_fixedpoint(2fx, 5fx)
  local dead = false
  pewpew.entity_set_update_callback(id, function()
    if dead == true then
      return
    end
    z = z - 10fx
    if z == 980fx then
      pewpew.customizable_entity_set_mesh(id,  "/dynamic/snowflake_mesh.lua", fmath.random_int(0, 7))
    end

    if z == 60fx then
      local baf_angle = angle_to_player(x,y, ship_id)
      local lifetime = 1000
      pewpew.new_baf(x, y, baf_angle, 10fx, lifetime)
    end
    if z == 10fx then
      pewpew.create_explosion(x, y, 0xffffffff, 1fx, 40)
    end
    if z == 0fx then
      pewpew.customizable_entity_start_exploding(id, 20)
      dead = true
    end
    pewpew.customizable_entity_set_mesh_z(id, z)
    pewpew.customizable_entity_set_mesh_angle(id, angle, 1fx, 1fx, z_axis)
    angle = angle + d_angle
  end)

end

return s