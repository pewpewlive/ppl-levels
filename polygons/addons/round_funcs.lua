---
--  Functions designed for polygon or circular use v1
--  Created by Tasty Kiwi
---

local shield_box = require("/dynamic/helpers/boxes/shield_box.lua")
local cannon_box = require("/dynamic/helpers/boxes/cannon_box.lua")

function create_mothership_angle(msx, msy, px, py)
  local dx = px - msx
  local dy = py - msy
  return fmath.atan2(dy,dx)
end

function make_walls(radius, sides, center_x, center_y)
  local locations = {}
  for i = 0, sides do
    local angle = (6.1159fx / fmath.to_fixedpoint(sides)) * fmath.to_fixedpoint(i)
    local y, x = fmath.sincos(angle)
    y = y * radius
    x = x * radius
    table.insert(locations, {x , y})
  end
  for i = 1, #locations do
    if i ~= #locations then
      pewpew.add_wall(center_x + locations[i][1], center_y + locations[i][2], center_x + locations[i + 1][1], center_y + locations[i + 1][2])
    else
      pewpew.add_wall(center_x + locations[#locations][1], center_y + locations[#locations][2], center_x + locations[1][1], center_y + locations[1][2])
    end
  end
end

function spawn_motherships_circular(radius, amount, typ, center_x, center_y)
  for i = 0, amount + 1 do
    local angle = (6.1159fx / fmath.to_fixedpoint(amount + 1)) * fmath.to_fixedpoint(i) 
    local y, x = fmath.sincos(angle)
    y = y * radius
    x = x * radius
    if i > 0 then
      pewpew.new_mothership( center_x + x, center_y + y, typ, create_mothership_angle(radius + x, radius + y, center_x, center_y))
    end
  end
end

function spawn_inertiacs_circular(radius, amount, accel, center_x, center_y)
  for i = 0, amount + 1 do
    local angle = (6.1159fx / fmath.to_fixedpoint(amount + 1)) * fmath.to_fixedpoint(i) 
    local y, x = fmath.sincos(angle)
    y = y * radius
    x = x * radius
    if i > 0 then
      pewpew.new_inertiac( center_x + x, center_y + y, accel, create_mothership_angle(radius + x, radius + y, center_x, center_y))
    end
  end
end

function spawn_shields_circular(radius, amount, center_x, center_y)
  for i = 0, amount + 1 do
    local angle = (6.1159fx / fmath.to_fixedpoint(amount + 1)) * fmath.to_fixedpoint(i) 
    local y, x = fmath.sincos(angle)
    y = y * radius
    x = x * radius
    if i > 0 then
      shield_box.new(center_x + x, center_y + y)
    end
  end
end

function spawn_cannons_circular(radius, amount, center_x, center_y)
  for i = 0, amount + 1 do
    local angle = (6.1159fx / fmath.to_fixedpoint(amount + 1)) * fmath.to_fixedpoint(i) 
    local y, x = fmath.sincos(angle)
    y = y * radius
    x = x * radius
    if i > 0 then
      cannon_box.new(center_x + x, center_y + y, fmath.random_int(0, 3))
    end
  end
end

function spawn_bombs_circular(radius, amount, typ, center_x, center_y)
  for i = 0, amount + 1 do
    local angle = (6.1159fx / fmath.to_fixedpoint(amount + 1)) * fmath.to_fixedpoint(i) 
    local y, x = fmath.sincos(angle)
    y = y * radius
    x = x * radius
    -- Despawn bombs after a certain amount of time
    if i > 0 then
      local bomb_id = pewpew.new_bomb(center_x + x, center_y + y, typ)
      pewpew.add_arrow_to_player_ship(ship1, bomb_id, 0x00c074ff)
      
      local internal_time = 0
      pewpew.entity_set_update_callback(bomb_id, function(entity_id)
        internal_time = internal_time + 1
        if internal_time == 360 then
          pewpew.entity_destroy(entity_id)
        end
      end)
    
    end
  end
end
