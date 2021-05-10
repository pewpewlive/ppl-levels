  -- Function that creates a custom enemy at the position `x`,`y`.
  -- The enemy explodes if it is hit by a player's weapon.
  -- The enemy sends a bullet in a random direction every 10 ticks.
  -- The enemy moves up for 10 ticks, then moves down for 10 ticks.
  function player_turret(x, y, t)
    local id = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(id, "/dynamic/enemy_graphic.lua", 0)
    pewpew.customizable_entity_set_position_interpolation(id, true)
    pewpew.entity_set_radius(id, 20fx)
    local x,y = pewpew.entity_get_position(id)
    -- Send a bullet every 10 ticks.
    local time = 0
    pewpew.entity_set_update_callback(id, function()
      time = time + 1
      local score = pewpew.get_score_of_player(0)
      if time % 250 == 0 then
        t = t + 1
      end
      local frate = t/2
      if time % frate == 0 then
        for i = 1, t do
         local angle = fmath.random_fixedpoint(0fx, fmath.tau())
         pewpew.new_player_bullet(x,y,angle,0)
        end
      end
    end)
  end