
function create_static_bg(x, y, mesh_name, color)
  local id = pewpew.new_customizable_entity(x, y)
  local path = '/dynamic/assets/common/meshes/' .. mesh_name .. '.lua'
  pewpew.customizable_entity_set_mesh(id, path, 0)
  if color then
    local counter = 0
    pewpew.entity_set_update_callback(id, function()
      if counter < 192 then
        counter = counter + 1
        pewpew.customizable_entity_set_mesh_color(id, color + counter)
      else
        pewpew.entity_set_update_callback(id, nil)
      end
    end)
  end
  return id
end

function configure_wall_bounce(entity)
  entity:configure_wall_collision(true, function()
    local ex, ey = entity:get_position()
    ex = ex + entity[i_dx]
    ey = ey + entity[i_dy]
    if ex <= 0fx or ex >= LEVEL_SIZE_X then
      entity[i_dx] = -entity[i_dx]
    end
    if ey <= 0fx or ey >= LEVEL_SIZE_Y then
      entity[i_dy] = -entity[i_dy]
    end
  end)
end

function configure_wall_destruction(entity)
  entity:configure_wall_collision(true, function()
    if entity.create_explosion_effect then
      entity:create_explosion_effect()
    end
    entity:destroyA()
  end)
end

function check_collision_with_group(entity1, group_name)
  local x1, y1 = entity1:get_position()
  for _, entity2 in pairs(pplaf.entity.get_group(group_name)) do
    if entity2:get_is_alive() and not entity2:get_is_started_to_be_destroyed() then
      local x2, y2 = entity2:get_position()
      local dx = x2 - x1
      local dy = y2 - y1
      if __DEF_FMATH_SQRT(dx * dx + dy * dy) < entity1[i_type].radius + entity2[i_type].radius then
        return entity2
      end
    end
  end
end

function check_collision_with_player(entity)
  if not GAME_STATE then
    return nil
  end
  local x, y = entity:get_position()
  local dx = PLAYER_X - x
  local dy = PLAYER_Y - y
  if __DEF_FMATH_SQRT(dx * dx + dy * dy) < PLAYER[i_type].radius + entity[i_type].radius then
    return true
  end
end

function check_collision_with_player_lasers(entity)
  local ex, ey = entity:get_position()
  for _, laser in pairs(pplaf.entity.get_group'player_laser') do
    if laser[i_laser_state] > -1 and laser:get_is_alive() then
      local lx, ly = laser:get_position()
      local dx = lx - ex
      local dy = ly - ey
      local angle = __DEF_FMATH_ATAN2(dy, dx) - laser[i_angle]
      if __DEF_FMATH_ABS(angle) % TAU_FX >= PI_FX / 2fx and __DEF_FMATH_ABS(__DEF_FMATH_SQRT(dx * dx + dy * dy) * __DEF_FMATH_SINCOS(angle)) < entity[i_type].radius then
        return true
      end
    end
  end
end
