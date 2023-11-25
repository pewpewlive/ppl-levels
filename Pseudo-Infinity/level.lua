local true_width, true_height = 1600fx, 900fx
local level_width, level_height = 2fx * true_width + 100fx, 2fx * true_height + 100fx

local range_x, range_y = true_width / 2fx, true_height / 2fx
local center_x, center_y = level_width / 2fx, level_height / 2fx

pewpew.set_level_size(level_width, level_height)

local player_index = 0
local player_one = pewpew.new_player_ship(center_x, center_y, player_index)
pewpew.configure_player(player_index, {shield = 64})  -- This level is just a showcase.
pewpew.configure_player_ship_weapon(player_one, {
  cannon = pewpew.CannonType.DOUBLE,
  frequency = pewpew.CannonFrequency.FREQ_15
})

function loop_player()
  local px, py = pewpew.entity_get_position(player_one)
  local previous_px, previous_py = px, py

  if px > center_x + range_x then  -- Right edge
    px = center_x - range_x
  elseif px < center_x - range_x then  -- Left edge
    px = center_x + range_x
  end

  if py > center_y + range_y then  -- Top edge
    py = center_y - range_y
  elseif py < center_y - range_y then  -- Bottom edge
    py = center_y + range_y
  end

  local dx, dy = px - previous_px, py - previous_py

  if dx + dy ~= 0fx then  -- Needn't move the entities when the player does not loop
    local entities = pewpew.get_all_entities()
    for i = 1, #entities do
      local entity = entities[i]
      local ex, ey = pewpew.entity_get_position(entity)

      ex = ex + dx
      ey = ey + dy

      pewpew.entity_set_position(entity, ex, ey)
    end
  end

  -- Player's position is set to the desired location in the above for-loop itself.
end

function loop_entities()
  local px, py = pewpew.entity_get_position(player_one)

  local entities = pewpew.get_all_entities()

  for i = 1, #entities do
    local entity = entities[i]
    local ex, ey = pewpew.entity_get_position(entity)

    if ex > px + range_x then  -- Right edge
      ex = px - range_x
    elseif ex < px - range_x then  -- Left edge
      ex = px + range_x
    end

    if ey > py + range_y then  -- Top edge
      ey = py - range_y
    elseif ey < py - range_y then  -- Bottom edge
      ey = py + range_y
    end

    pewpew.entity_set_position(entity, ex, ey)
  end
end

local time = 0
pewpew.add_update_callback(function()
  time = time + 1
  if pewpew.entity_get_is_alive(player_one) then
    local px, py = pewpew.entity_get_position(player_one)

    -- (px - range_x, py - range_y) should be treated as (0fx, 0fx) in this system.
    if time % 90 == 0 then
      pewpew.new_asteroid(px + fmath.random_fixedpoint(-range_x, range_x), py + fmath.random_fixedpoint(-range_y, range_y))
    end

    if time % 20 == 0 then
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
      pewpew.new_baf_blue(px + fmath.random_fixedpoint(-range_x, range_x), py + fmath.random_fixedpoint(-range_y, range_y), angle, 8fx, -1)
    end

    loop_player()
    loop_entities()
  end

  if pewpew.get_player_configuration(player_index)["has_lost"] then
    pewpew.stop_game()
  end
end)