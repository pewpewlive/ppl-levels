local true_width, true_height = 1536fx, 768fx
local level_width, level_height = 2fx * true_width + 100fx, 2fx * true_height + 100fx

local range_x, range_y = true_width / 2fx, true_height / 2fx
local center_x, center_y = level_width / 2fx, level_height / 2fx

local player_right_edge = center_x + range_x
local player_left_edge = center_x - range_x
local player_top_edge = center_y + range_y
local player_bottom_edge = center_y - range_y

pewpew.set_level_size(level_width, level_height)

local player_index = 0
local ship_id = pewpew.new_player_ship(center_x, center_y, player_index)

pewpew.configure_player(player_index, {shield = 4, camera_distance = 50fx})

pewpew.configure_player_ship_weapon(ship_id, {
  cannon = pewpew.CannonType.DOUBLE,
  frequency = pewpew.CannonFrequency.FREQ_10
})

local px, py = pewpew.entity_get_position(ship_id)

function loop_player()
  local has_player_moved = false

  local dx, dy = 0fx, 0fx

  if px > player_right_edge then
    dx = -true_width

    has_player_moved = true
  elseif px < player_left_edge then
    dx = true_width

    has_player_moved = true
  end

  if py > player_top_edge then
    dy = -true_height

    has_player_moved = true
  elseif py < player_bottom_edge then
    dy = true_height

    has_player_moved = true
  end

  if has_player_moved then
    local entities = pewpew.get_all_entities()

    -- Move all the entities, including the player ship.
    for i = 1, #entities do
      local entity_id = entities[i]
      local ex, ey = pewpew.entity_get_position(entity_id)

      ex = ex + dx
      ey = ey + dy

      pewpew.entity_set_position(entity_id, ex, ey)
    end
  end

  if pewpew.entity_get_is_alive(ship_id) then
    px, py = pewpew.entity_get_position(ship_id)
  end
end

function loop_entities()
  local entities = pewpew.get_all_entities()

  -- The borders around the player for the entities
  local right_edge = px + range_x
  local left_edge = px - range_x
  local top_edge = py + range_y
  local bottom_edge = py - range_y

  for i = 1, #entities do
    local entity = entities[i]
    local ex, ey = pewpew.entity_get_position(entity)

    if ex > right_edge then
      ex = ex - true_width
    elseif ex < left_edge then
      ex = ex + true_width
    end

    if ey > top_edge then
      ey = ey - true_height
    elseif ey < bottom_edge then
      ey = ey + true_height
    end

    pewpew.entity_set_position(entity, ex, ey)
  end
end

local time = -1
local wave = 0
pewpew.add_update_callback(function()
  time = time + 1
  if pewpew.entity_get_is_alive(ship_id) then
    px, py = pewpew.entity_get_position(ship_id)

    if pewpew.get_entity_count(pewpew.EntityType.ASTEROID) == 0 then
      wave = wave + 1

      local delta_entity_number = (wave - 1) // 3

      if wave % 3 == 1 then
        pewpew.new_floating_message(center_x, center_y, "Round "..wave, {scale = 3fx, dz = 0fx, ticks_before_fade = 120, is_optional = false})

        local x = center_x - range_x
        local y = center_y

        for i = 1, 3 + 3 * delta_entity_number do
          pewpew.new_asteroid(x, y)
        end
      elseif wave % 3 == 2 then
        pewpew.new_floating_message(center_x, center_y, "#00ff00ffRound "..wave, {scale = 3fx, dz = 0fx, ticks_before_fade = 120, is_optional = false})

        local x = center_x - range_x
        local y = center_y

        for i = 1, 3 + 2 * delta_entity_number do
          pewpew.new_asteroid(x, y)
        end

        for i = 1, 1 + 2 * delta_entity_number do
          local angle = fmath.random_fixedpoint(0fx, fmath.tau())

          pewpew.new_mothership(x, y, pewpew.MothershipType.SIX_CORNERS, angle)
        end
      else
        pewpew.new_floating_message(center_x, center_y, "#ffff00ffRound "..wave, {scale = 3fx, dz = 0fx, ticks_before_fade = 120, is_optional = false})

        local asteroid_x = center_x - range_x
        local asteroid_y = center_y

        for i = 1, 3 + 2 * delta_entity_number do
          pewpew.new_asteroid(asteroid_x, asteroid_y)
        end

        for dx = -80fx * (delta_entity_number + 1), 80fx * (delta_entity_number + 1), 40fx do
          pewpew.new_rolling_cube(center_x + dx, asteroid_y - 80fx)
        end
      end
    end
  end

  loop_player()
  loop_entities()

  if pewpew.get_player_configuration(player_index)["has_lost"] then
    pewpew.stop_game()
  end
end)