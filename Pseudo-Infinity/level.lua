local level_width, level_height = 3000fx, 3000fx
pewpew.set_level_size(level_width, level_height)

local p1_index = 0
local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.DOUBLE}
local player_one = pewpew.new_player_ship(1500fx, 1500fx, p1_index)
pewpew.configure_player(p1_index, {shield = 999})
pewpew.configure_player_ship_weapon(player_one, weapon_config)

--The code that loops the entities around the player
--It is self explanatory.
--ex, ey are entities' positions.
-- #entities is the number of entities
function loop_entities()
  local entities = pewpew.get_all_entities()

  for num=1,#entities do 
    local ex, ey = pewpew.entity_get_position(entities[num])
    
    if fmath.to_int(ex) > fmath.to_int(player_x) + 600 then 
      ex = player_x - 600fx
    elseif fmath.to_int(ex) < fmath.to_int(player_x) - 600 then
      ex = player_x + 600fx
    end

    if fmath.to_int(ey) > fmath.to_int(player_y) + 400 then
      ey = player_y - 400fx
    elseif fmath.to_int(ey) < fmath.to_int(player_y) - 400 then
      ey = player_y + 400fx
    end

    pewpew.entity_set_position(entities[num], ex, ey)
  end
end

--The code that loops the player and displaces the entities to create the illusion
function loop_player()
  pewpew.entity_get_position(player_one)
  local changes = 0

  if fmath.to_int(player_x) > fmath.to_int((level_width / 2fx) + 600fx) then
    player_x = (level_width / 2fx) - 600fx
    changes = changes + 1
  elseif fmath.to_int(player_x) < (fmath.to_int(level_width) / 2) - 600 then
    player_x = (level_width / 2fx) + 600fx
    changes = changes + 1
  end

  if fmath.to_int(player_y) > (fmath.to_int(level_height) / 2) + 400 then
    player_y = (level_height / 2fx) - 400fx
    changes = changes + 1
  elseif fmath.to_int(player_y) < (fmath.to_int(level_height) / 2) - 400 then
    player_y = (level_height / 2fx) + 400fx
    changes = changes + 1
  end

  local cx, cy = pewpew.entity_get_position(player_one) --cx, cy are current positions of the player.
  local dx = player_x - cx  --dx, dy are the difference between the new variable position and the position before the variables were changed.
  local dy = player_y - cy

  if changes > 0 then
    local entities = pewpew.get_all_entities()

    for j=1,#entities do
      local ex, ey = pewpew.entity_get_position(entities[j])
      pewpew.entity_set_position(entities[j], ex + dx, ey + dy)  --Offsets every entity (including the player)
    end
  end
end

local time = 0
function level_tick()
  time = time + 1
  if pewpew.entity_get_is_alive(player_one) then
    player_x, player_y = pewpew.entity_get_position(player_one)
  end

  local player1_score = pewpew.get_score_of_player(p1_index)  --To be removed for personal use
  pewpew.increase_score_of_player(p1_index, player1_score * -1)  -- To be removed for personal use

  if pewpew.get_entity_count(pewpew.EntityType.ASTEROID) < 1 then  --To be removed for personal use
    pewpew.new_asteroid(fmath.random_fixedpoint(player_x - 600fx, player_x + 600fx), fmath.random_fixedpoint(player_y - 400fx, player_y + 400fx))
  end
  
  if time % 300 == 0 then
    local x = fmath.random_fixedpoint(player_x - 600fx, player_x + 600fx)
    local y = fmath.random_fixedpoint(player_y - 400fx, player_y + 400fx)
    local angle = fmath.random_fixedpoint(0fx, 629fx) / 100fx
    pewpew.new_baf_blue(x, y, angle, 15fx, -1)
  end
  
  local conf = pewpew.get_player_configuration(0)
  if conf["has_lost"] == true then
    pewpew.add_damage_to_player_ship(player_one, -1)
  else
    loop_player()
  end
  loop_entities()
end

pewpew.add_update_callback(level_tick)