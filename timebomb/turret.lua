local player_helpers = require("/dynamic/helpers/player_helpers.lua")

-- Function that creates an enemy bullet.
-- The bullet is spawned at the position `x`,`y` and goes in the direction
-- specified by `angle`.
function new_enemy_bullet(x, y, angle)
    local id = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_start_spawning(id, 0)
    pewpew.customizable_entity_set_mesh(id, "/dynamic/bullet_graphic.lua", 0)
    pewpew.customizable_entity_set_position_interpolation(id, true)
    pewpew.entity_set_radius(id, 10fx)
    -- Make the bullet move
    local dy, dx = fmath.sincos(angle)
    dx = dx * 4fx
    dy = dy * 4fx
    pewpew.entity_set_update_callback(id, function()
      local x,y = pewpew.entity_get_position(id)
      x = x + dx
      y = y + dy
      pewpew.entity_set_position(id, x, y)
    end)
    -- Make the bullet collide with walls: destroy the bullet on collision.
    pewpew.customizable_entity_configure_wall_collision(id, false, function()
      pewpew.customizable_entity_start_exploding(id, 10)
    end)
    -- Make the bullet collide with player ships: add 3 damage to the ship, and destroy the bullet.
    pewpew.customizable_entity_set_player_collision_callback(id, function(entity_id, player_id, ship_id)
      pewpew.add_damage_to_player_ship(ship_id, 1)
      pewpew.customizable_entity_start_exploding(entity_id, 10)
    end)
  end
  
  -- Function that creates a custom enemy at the position `x`,`y`.
  -- The enemy explodes if it is hit by a player's weapon.
  -- The enemy sends a bullet in a random direction every 10 ticks.
  -- The enemy moves up for 10 ticks, then moves down for 10 ticks.
  function turret(x, y)
    local id = pewpew.new_customizable_entity(x, y)
    pewpew.customizable_entity_set_mesh(id, "/dynamic/enemy_graphic.lua", 0)
    pewpew.customizable_entity_set_position_interpolation(id, true)
    pewpew.entity_set_radius(id, 20fx)
    local health = 10
    local x,y = pewpew.entity_get_position(id)
    pewpew.customizable_entity_set_weapon_collision_callback(id, function()
       pewpew.play_sound("/dynamic/turret_hit_sound.lua", 0, x, y)
        health = health - 1
        if health <= 0 then
          pewpew.customizable_entity_start_exploding(id, 10)
        end
        return true
     end)
    -- Send a bullet every 10 ticks.
    local time = 0
    local chance = fmath.random_int(1,3)
    local dy = 5fx
    local dx = 5fx
    pewpew.entity_set_update_callback(id, function()
      time = time + 1
      if time % 30 == 0 then
        local angle = fmath.random_fixedpoint(0fx, fmath.tau())
        new_enemy_bullet(x, y, angle)
      end
      if chance == 1 then
        y = y + dy
      pewpew.entity_set_position(id, x, y)
      elseif chance == 3 then
        y = y + dy
        x = x + dx
      pewpew.entity_set_position(id, x, y)
      elseif chance == 2 then
        x = x + dx
      pewpew.entity_set_position(id, x, y)
      end
    end)
    pewpew.customizable_entity_configure_wall_collision(id, false, function()
      dy = -dy
      dx = -dx
    end)
  end