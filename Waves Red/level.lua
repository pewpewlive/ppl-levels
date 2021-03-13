local BAF = require("/dynamic/BAF.lua")
local power_up = require("/dynamic/power_ups.lua")

-- Set map size
local level_height = 650fx
local level_length = 900fx
pewpew.set_level_size(level_length,level_height)
local BAFlimit = 1000

-- Create an entity at position (0,0) that will hold the background mesh.
local background = pewpew.new_customizable_entity(0fx, 0fx)
--pewpew.customizable_entity_set_mesh(background, "/static/levels/endless/waves/graphics.lua", 0)
pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 0)
game = {}
game.BAFs = {}

--Creates the player ship
local player_x = level_length/2fx
local player_y = level_height/2fx
local player_index = 0
local ship_id = pewpew.new_player_ship(player_x, player_y, player_index)
pewpew.configure_player_ship_weapon(ship_id, { frequency = pewpew.CannonFrequency.FREQ_7_5, cannon = pewpew.CannonType.SINGLE})
pewpew.configure_player(0, {shield = 5})

local time = 0
local wavespawn = 120
local hoardspawn = 2000
local time_until_next_wave = 0
local waves_per_minute = 17
local time_between_waves = 1800 // waves_per_minute


function ColorToString(color)
  local s = string.format("%x", color)
  while string.len(s) < 8 do
    s = "0" .. s
  end
  return "#" .. s
end


--Spawns a bomb

function bombmake(time)
  if time%300==0 then
    local x = fmath.random_fixedpoint(level_length/5fx,level_length-level_length/5fx)
    local y = fmath.random_fixedpoint(level_height/5fx,level_height-level_height/5fx)
    pewpew.new_bomb(x,y,pewpew.BombType.SMALL_ATOMIZE)
  end
end

--Spawns differing Motherships

function mothershipmake(time)
  -- if time%500==0 then
  --   local shipx = fmath.random_fixedpoint(0fx,level_length)
  --   local shipy = fmath.random_fixedpoint(0fx,level_height)
  --   local shiptype = pewpew.MothershipType.SEVEN_CORNERS
  --   local shipangle = fmath.random_fixedpoint(0fx,8fx)/4fx * (3.573fx)
  --   pewpew.new_mothership(shipx,shipy,shiptype,shipangle)
  -- end
  if time%500==0 then
    local shipx = fmath.random_fixedpoint(0fx,level_length)
    local shipy = fmath.random_fixedpoint(0fx,level_height)
    local shiptype = pewpew.MothershipType.FOUR_CORNERS
    local shipangle = fmath.random_fixedpoint(0fx,8fx)/4fx * (3.573fx)
    pewpew.new_mothership(shipx,shipy,shiptype,shipangle)
  end
end

--Spawns the inertiac

function inertiacmake(time)
  if time%510==0 then
    local inertiacx = fmath.random_fixedpoint(0fx,level_length)
    local inertiacy = fmath.random_fixedpoint(0fx,level_height)
    local inertiacacc = 1fx
    local inertiacangle = fmath.random_fixedpoint(0fx,8fx)/4fx * (3.573fx)
    pewpew.play_ambient_sound("/dynamic/sounds.lua", 1)
    pewpew.new_inertiac(inertiacx, inertiacy, inertiacacc, inertiacangle)
  end
end

--Spawns a wall or wave of arrows
function wave(time,wavespawn)

  local outcome = fmath.random_int(1,2)
  local mapside = fmath.to_fixedpoint(fmath.random_int(0,1))

  if outcome == 1 then
    local spacing = level_height
    for i = 0fx, spacing, 30fx do 
        local baf_x = level_length*mapside
        local baf_y = i
        local baf_angle = mapside*3.573fx
        local baf_speed = 8fx
        local lifetime = 450
        if mapside == 0fx then
          baf_angle = "RIGHT"
        else
          baf_angle = "LEFT"
        end
        --pewpew.new_baf(baf_x, baf_y, baf_angle, baf_speed, lifetime)
        if #game.BAFs > BAFlimit then
          return
        end
        BAF.new_horizontal(baf_x, baf_y, 3, baf_speed, lifetime, baf_angle,game)
        --(x, y, health, speed, lifetime, direction)
    end
  end
  if outcome == 2 then
    local spacing = level_length
    for i = 15fx, spacing-15fx, 30fx do 
        local baf_y = level_height*mapside
        local baf_x = i
        local baf_angle = (mapside*3.573fx)+0.2048fx*3.573fx
        local baf_speed = 8fx
        local lifetime = 450
        if mapside == 0fx then
          baf_angle = "UP"
        else
          baf_angle = "DOWN"
        end
        if #game.BAFs > BAFlimit then
          return
        end
        --pewpew.new_baf(baf_x, baf_y, baf_angle, baf_speed, lifetime)
        BAF.new_vertical(baf_x, baf_y, 3, baf_speed, lifetime, baf_angle,game)
    end
  end

end

--Spawns a "hoard" of walls of arrows

function hoardmake(time,hoardspawn)
  if time > 10 then
    if time%hoardspawn == 0 then

      pewpew.play_ambient_sound("/dynamic/sounds.lua", 0)
      hoardspawn = hoardspawn - 90
      for i = 0,6 do
      local outcome = fmath.random_int(1,2)
      local mapside = fmath.to_fixedpoint(fmath.random_int(0,1))
      if outcome == 1 then
        local spacing = level_height
        for i = 0fx, spacing, 30fx do 
            local baf_x = level_length*mapside
            local baf_y = i
            local baf_angle = mapside*3.573fx
            local baf_speed = 10fx
            local lifetime = 450
            if mapside == 0fx then
              baf_angle = "RIGHT"
            else
              baf_angle = "LEFT"
            end
            --pewpew.new_baf(baf_x, baf_y, baf_angle, baf_speed, lifetime)
            if #game.BAFs > BAFlimit then
              return
            end
            BAF.new_horizontal(baf_x, baf_y, 3, baf_speed, lifetime, baf_angle,game)
            --(x, y, health, speed, lifetime, direction)
        end
      end
      if outcome == 2 then
        local spacing = level_length
        for i = 15fx, spacing-15fx, 30fx  do 
            local baf_y = level_height*mapside
            local baf_x = i
            local baf_angle = (mapside*3.573fx)+0.2048fx*3.573fx
            local baf_speed = 10fx
            local lifetime = 450
            if mapside == 0fx then
              baf_angle = "UP"
            else
              baf_angle = "DOWN"
            end
            --pewpew.new_baf(baf_x, baf_y, baf_angle, baf_speed, lifetime)
            if #game.BAFs > BAFlimit then
              return
            end
            BAF.new_vertical(baf_x, baf_y, 3, baf_speed, lifetime, baf_angle,game)
        end
      end
      end
    end
  end
end


local opacity = 0xffffffff
local n = 0

-- A function that will get called every game tick, which is 30 times per seconds.
function level_tick()
  -- Stop the game if the player is dead.
  local conf = pewpew.get_player_configuration(player_index)
  if conf["has_lost"] == true then
    pewpew.stop_game()
  end
  


  time = time + 1
  if time % (30 * 6) == 0 then
     waves_per_minute = waves_per_minute + 1
     time_between_waves = 1800 // waves_per_minute
  end
  
  time_until_next_wave = time_until_next_wave - 1
  if time_until_next_wave <= 0 then
    wave()
    if time_until_next_wave <= 0 then
    time_until_next_wave = time_between_waves
    end
  end
  
    bombmake(time)
    mothershipmake(time)
    inertiacmake(time)
    hoardmake(time,hoardspawn)
    opacity = opacity + n
    if opacity < 0xffffff40 then
      n = 6
    end
    if opacity > 0xfffffffe then
      n = -6
    end

    if time % (30 * 15) == 0 then
      local x = fmath.random_fixedpoint(level_length/5fx,level_length-level_length/5fx)
      local y = fmath.random_fixedpoint(level_height/5fx,level_height-level_height/5fx)
      power_up.doublemake(x,y)
    end
    if time %(30 * 20) == 0 then
      local x = fmath.random_fixedpoint(level_length/5fx,level_length-level_length/5fx)
      local y = fmath.random_fixedpoint(level_height/5fx,level_height-level_height/5fx)
      power_up.shieldmake(x,y)
    end
    if time % (30*60) == 0 then
      local x = fmath.random_fixedpoint(level_length/5fx,level_length-level_length/5fx)
      local y = fmath.random_fixedpoint(level_height/5fx,level_height-level_height/5fx)
      power_up.doubleswipemake(x,y)
    end

    pewpew.customizable_entity_set_mesh_color(background, opacity)


end

-- Register the `level_tick` function to be called at every game tick.
pewpew.add_update_callback(level_tick)