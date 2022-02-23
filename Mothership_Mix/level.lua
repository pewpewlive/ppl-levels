local player_helpers = require("/dynamic/player_helpers.lua")
local cannon_box = require("/dynamic/helpers/boxes/cannon_box.lua")
local shield_box = require("/dynamic/helpers/boxes/shield_box.lua")
--basic stuff, everybody should know how to do this

local width = 800fx
local height = 800fx
pewpew.set_level_size(width, height)

local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.DOUBLE}
local ship = player_helpers.new_player_ship(400fx, 400fx, 0)
pewpew.configure_player(0, {camera_distance = 50fx, shield = 32})
pewpew.configure_player_ship_weapon(ship, weapon_config)

pewpew.add_wall(0fx,0fx,800fx,0fx)
pewpew.add_wall(800fx,0fx,800fx,800fx)
pewpew.add_wall(800fx,800fx,0fx,800fx)
pewpew.add_wall(0fx,800fx,0fx,0fx)

--WARNING!!! What you are about to see requires preparation, you will need the following items to survive through this seemingly endless ladder of code:
--bleach, 2 pairs of fresh eyes, the extreme and unfathomable will to survive through this, the mental capacity to not lose all your brain cells from this atrosity and lastly, an overabundance of patience
--im very sorry

local function custom_background(x, y)
  local idthing = pewpew.new_customizable_entity(400fx, 400fx)
  pewpew.customizable_entity_set_mesh(idthing, "/dynamic/graphics.lua", 0)
end

custom_background(x, y)

local function custom_background2(x, y)
  local idthing2 = pewpew.new_customizable_entity(0fx, 0fx)
  pewpew.customizable_entity_set_mesh(idthing2, "/dynamic/graphics2.lua", 0)
  pewpew.customizable_entity_set_mesh_z(idthing2, -4000fx)
end

custom_background2(x, y)

local function custom_background3(x, y)
  local idthing3 = pewpew.new_customizable_entity(-400fx, -400fx)
  pewpew.customizable_entity_set_mesh(idthing3, "/dynamic/graphics2.lua", 0)
  pewpew.customizable_entity_set_mesh_z(idthing3, -3500fx)
  pewpew.customizable_entity_set_mesh_xyz_scale(idthing3, 2fx, 2fx, 2fx)
end

custom_background3(x, y)

local function custom_background4(x, y)
  local idthing4 = pewpew.new_customizable_entity(-800fx, -800fx)
  pewpew.customizable_entity_set_mesh(idthing4, "/dynamic/graphics2.lua", 0)
  pewpew.customizable_entity_set_mesh_z(idthing4, -3000fx)
  pewpew.customizable_entity_set_mesh_xyz_scale(idthing4, 3fx, 3fx, 3fx)
end

custom_background4(x, y)

local function custom_background5(x, y)
  local idthing5 = pewpew.new_customizable_entity(-1200fx, -1200fx)
  pewpew.customizable_entity_set_mesh(idthing5, "/dynamic/graphics2.lua", 0)
  pewpew.customizable_entity_set_mesh_z(idthing5, -2500fx)
  pewpew.customizable_entity_set_mesh_xyz_scale(idthing5, 4fx, 4fx, 4fx)
end

custom_background5(x, y)

local function custom_background6(x, y)
  local idthing6 = pewpew.new_customizable_entity(-1600fx, -1600fx)
  pewpew.customizable_entity_set_mesh(idthing6, "/dynamic/graphics2.lua", 0)
  pewpew.customizable_entity_set_mesh_z(idthing6, -2000fx)
  pewpew.customizable_entity_set_mesh_xyz_scale(idthing6, 5fx, 5fx, 5fx)
end

custom_background6(x, y)

local function custom_background7(x, y)
  local idthing7 = pewpew.new_customizable_entity(-2000fx, -2000fx)
  pewpew.customizable_entity_set_mesh(idthing7, "/dynamic/graphics2.lua", 0)
  pewpew.customizable_entity_set_mesh_z(idthing7, -1500fx)
  pewpew.customizable_entity_set_mesh_xyz_scale(idthing7, 6fx, 6fx, 6fx)
end

custom_background7(x, y)

local function custom_background8(x, y)
  local idthing8 = pewpew.new_customizable_entity(-2400fx, -2400fx)
  pewpew.customizable_entity_set_mesh(idthing8, "/dynamic/graphics2.lua", 0)
  pewpew.customizable_entity_set_mesh_z(idthing8, -1000fx)
  pewpew.customizable_entity_set_mesh_xyz_scale(idthing8, 7fx, 7fx, 7fx)
end

custom_background8(x, y)

local function custom_background9(x, y)
  local idthing9 = pewpew.new_customizable_entity(-2800fx, -2800fx)
  pewpew.customizable_entity_set_mesh(idthing9, "/dynamic/graphics2.lua", 0)
  pewpew.customizable_entity_set_mesh_z(idthing9, -500fx)
  pewpew.customizable_entity_set_mesh_xyz_scale(idthing9, 8fx, 8fx, 8fx)
end

custom_background9(x, y)

local function custom_background0(x, y)
  local idthing0 = pewpew.new_customizable_entity(-3200fx, -3200fx)
  pewpew.customizable_entity_set_mesh(idthing0, "/dynamic/graphics2.lua", 0)
  pewpew.customizable_entity_set_mesh_z(idthing0, 0fx)
  pewpew.customizable_entity_set_mesh_xyz_scale(idthing0, 9fx, 9fx, 9fx)
end

custom_background0(x, y)


local function custom_background11(x, y)
  local idthing11 = pewpew.new_customizable_entity(-2800fx, -2800fx)
  pewpew.customizable_entity_set_mesh(idthing11, "/dynamic/graphics2.lua", 0)
  pewpew.customizable_entity_set_mesh_z(idthing11, 500fx)
  pewpew.customizable_entity_set_mesh_xyz_scale(idthing11, 8fx, 8fx, 8fx)
end

custom_background11(x, y)

local function square(x, y)
  local sq = pewpew.new_customizable_entity(0fx, 0fx)
  pewpew.customizable_entity_set_mesh(sq, "/dynamic/graphics3.lua", 0)
end

square(x, y)

local function idk(x, y)
  local sqd = pewpew.new_customizable_entity(0fx, 0fx)
  pewpew.customizable_entity_set_mesh(sqd, "/dynamic/graphics4.lua", 0)
end

idk(x, y)

local function idk2(x,y)
  local sqd2 = pewpew.new_customizable_entity(800fx, 800fx)
  pewpew.customizable_entity_set_mesh(sqd2, "/dynamic/graphics4v2.lua", 0)
  pewpew.customizable_entity_set_mesh_xyz_scale(sqd2, -1fx, -1fx, 1fx)
end

idk2(x, y)

local function idk23(x,y)
  local sqd23 = pewpew.new_customizable_entity(800fx, 0fx)
  pewpew.customizable_entity_set_mesh(sqd23, "/dynamic/graphics4v3.lua", 0)
  pewpew.customizable_entity_set_mesh_xyz_scale(sqd23, -1fx, 1fx, 1fx)
end

idk23(x, y)

local function idk234(x,y)
  local sqd234 = pewpew.new_customizable_entity(0fx, 800fx)
  pewpew.customizable_entity_set_mesh(sqd234, "/dynamic/graphics4v4.lua", 0)
  pewpew.customizable_entity_set_mesh_xyz_scale(sqd234, 1fx, -1fx, 1fx)
end

idk234(x, y)

--this custom enemy is basically a rolling sphere but it shrinks every time it hits a wall, which means at some point it will disappear
local function custom_grps(x, y, angle)
  local grps = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_set_mesh(grps, "/dynamic/grps5.lua", 0)
  pewpew.customizable_entity_set_mesh_color(grps, 0x00ff00ff)
  pewpew.customizable_entity_set_position_interpolation(grps, true)
  --setting variables moment
  local radius = 24fx
  pewpew.entity_set_radius(grps, radius)
  local move_y, move_x = fmath.sincos(angle)
  local scale = 1fx
  local rolling_angle = fmath.tau() 
  local speed = 5fx
  local time = 0
  --doing the magic
  pewpew.entity_set_update_callback(grps)
    pewpew.entity_set_update_callback(grps, function()
    time = time + 1
    local x, y = pewpew.entity_get_position(grps)
    pewpew.entity_set_position(grps, x + (move_x*speed), y + (move_y*speed))
    rolling_angle = rolling_angle + 0.709fx
    pewpew.customizable_entity_set_mesh_angle(grps, rolling_angle, 0fx, 1fx, 0fx)
    pewpew.customizable_entity_add_rotation_to_mesh(grps, angle, 0fx, 0fx, 1fx)
    if time % 4 == 0 then 
      pewpew.customizable_entity_set_mesh_color(grps, 0x00ff00ff)--check line 208 - 210 to see why i put this
    end
  end)
  pewpew.customizable_entity_configure_wall_collision(grps, true, function(entity_id, wall_normal_x, wall_normal_y)
    if wall_normal_x == -1fx or wall_normal_x == 1fx then --this is basically: if the wall is vertical then make the number move_x from a positive to a negative, and from a negative to a positive
      move_x = -move_x
    end
    if wall_normal_y == -1fx or wall_normal_y == 1fx then --this is basically: if the wall is horizontal then make the number move_y from a positive to a negative, and from a negative to a positive
      move_y = -move_y 
    end
    --from 187 - 192, it is essential for any rolling sphere replica, as it is basically telling it how it should bounce whne hit to a wall
    angle = fmath.atan2(move_y, move_x)
    scale = scale - 1fx / 10fx
    pewpew.customizable_entity_set_mesh_scale(grps, scale)
    radius = radius - 25fx / 10fx
    pewpew.entity_set_radius(grps, radius)
    speed = speed - 0.5fx --this is why i made the variables, if i didnt make them like this it wouldnt work
    if scale <= 40fx / 100fx then
      pewpew.customizable_entity_start_exploding(grps, 10)
    end
  end)
  pewpew.customizable_entity_set_player_collision_callback(grps, function()
    pewpew.add_damage_to_player_ship(ship, 2) 
    pewpew.customizable_entity_start_exploding(grps, 10)
  end)
  pewpew.customizable_entity_set_weapon_collision_callback(grps, function()
    local x, y = pewpew.entity_get_position(grps) 
    pewpew.customizable_entity_set_mesh_color(grps, 0xffffffff)--basically when it is hit it will become white, but since we dont want it to always be white look at what we did at 183
    return true
  end)
end

--i always use this, and honestly is very useful, i don't think i need to explain this, the name of the function already explains itself
local function random_position_rewards()
  return fmath.random_fixedpoint(50fx, width-50fx), fmath.random_fixedpoint(50fx, height-50fx)
end

--THIS IS THE BEST I COULD DO TO OPTIMIZE ENEMY SPAWNS

--left to right
for y = 50fx, 750fx, 100fx do
  pewpew.new_mothership(0fx, y, pewpew.MothershipType.SEVEN_CORNERS, 0fx)
end
pewpew.new_mothership(0fx, 0fx, pewpew.MothershipType.SEVEN_CORNERS, 0fx)
pewpew.new_mothership(0fx, 790fx, pewpew.MothershipType.SEVEN_CORNERS, 0fx)
--down to up
for x = 50fx, 750fx, 100fx do
  pewpew.new_mothership(x, 0fx, pewpew.MothershipType.THREE_CORNERS, fmath.tau() / 4fx)
end
pewpew.new_mothership(0fx, 0fx, pewpew.MothershipType.THREE_CORNERS, fmath.tau() / 4fx)
pewpew.new_mothership(790fx, 0fx, pewpew.MothershipType.THREE_CORNERS, fmath.tau() / 4fx)
--up to down
for x = 50fx, 750fx, 100fx do
  pewpew.new_mothership(x, 800fx, pewpew.MothershipType.FOUR_CORNERS, fmath.tau() / 4fx)
end
pewpew.new_mothership(0fx, 790fx, pewpew.MothershipType.FOUR_CORNERS, fmath.tau() / 4fx)
pewpew.new_mothership(790fx, 790fx, pewpew.MothershipType.FOUR_CORNERS, fmath.tau() / 4fx)
--right to left
for y = 50fx, 750fx, 100fx do
  pewpew.new_mothership(800fx, y, pewpew.MothershipType.SIX_CORNERS, 0fx)
end
pewpew.new_mothership(800fx, 15fx, pewpew.MothershipType.SIX_CORNERS, 0fx)
pewpew.new_mothership(790fx, 790fx, pewpew.MothershipType.SIX_CORNERS, 0fx)

local time = 0
local test = true
function level_tick()
  time = time + 1
  local conf = pewpew.get_player_configuration(0)
  if conf["has_lost"] then
	  pewpew.stop_game()
  end
  --ATTENTION: The rest of this code below now consists of the actual gameplay, the first three blocks of code are to increase difficulty as time goes on,
  --this is done by making them spawn faster after a specific amount of time passes.
  if time > 460 and time < 2000 and time % 600 == 0 then 
    --left to right
    for y = 50fx, 750fx, 100fx do
      pewpew.new_mothership(0fx, y, pewpew.MothershipType.SEVEN_CORNERS, 0fx)
    end
    pewpew.new_mothership(0fx, 0fx, pewpew.MothershipType.SEVEN_CORNERS, 0fx)
    pewpew.new_mothership(0fx, 790fx, pewpew.MothershipType.SEVEN_CORNERS, 0fx)
    --down to up
    for x = 50fx, 750fx, 100fx do
      pewpew.new_mothership(x, 0fx, pewpew.MothershipType.THREE_CORNERS, fmath.tau() / 4fx)--90 degree angle, fmath.tav() is basically 360 degrees and dividing by 4 making it 90 degrees
    end
    pewpew.new_mothership(0fx, 0fx, pewpew.MothershipType.THREE_CORNERS, fmath.tau() / 4fx)
    pewpew.new_mothership(790fx, 0fx, pewpew.MothershipType.THREE_CORNERS, fmath.tau() / 4fx)
    --up to down
    for x = 50fx, 750fx, 100fx do
      pewpew.new_mothership(x, 800fx, pewpew.MothershipType.FOUR_CORNERS, fmath.tau() / 4fx)
    end
    pewpew.new_mothership(0fx, 790fx, pewpew.MothershipType.FOUR_CORNERS, fmath.tau() / 4fx)
    pewpew.new_mothership(790fx, 790fx, pewpew.MothershipType.FOUR_CORNERS, fmath.tau() / 4fx)
    --right to left
    for y = 50fx, 750fx, 100fx do
      pewpew.new_mothership(800fx, y, pewpew.MothershipType.SIX_CORNERS, 0fx)
    end
    pewpew.new_mothership(800fx, 15fx, pewpew.MothershipType.SIX_CORNERS, 0fx)
    pewpew.new_mothership(790fx, 790fx, pewpew.MothershipType.SIX_CORNERS, 0fx)
  end
  if time > 2000 and time < 3540 and time % 450 == 0 then 
    --left to right
    for y = 50fx, 750fx, 100fx do
      pewpew.new_mothership(0fx, y, pewpew.MothershipType.SEVEN_CORNERS, 0fx)
    end
    pewpew.new_mothership(0fx, 0fx, pewpew.MothershipType.SEVEN_CORNERS, 0fx)
    pewpew.new_mothership(0fx, 790fx, pewpew.MothershipType.SEVEN_CORNERS, 0fx)
    --down to up
    for x = 50fx, 750fx, 100fx do
      pewpew.new_mothership(x, 0fx, pewpew.MothershipType.THREE_CORNERS, fmath.tau() / 4fx)
    end
    pewpew.new_mothership(0fx, 0fx, pewpew.MothershipType.THREE_CORNERS, fmath.tau() / 4fx)
    pewpew.new_mothership(790fx, 0fx, pewpew.MothershipType.THREE_CORNERS, fmath.tau() / 4fx)
    --up to down
    for x = 50fx, 750fx, 100fx do
      pewpew.new_mothership(x, 800fx, pewpew.MothershipType.FOUR_CORNERS, fmath.tau() / 4fx)
    end
    pewpew.new_mothership(0fx, 790fx, pewpew.MothershipType.FOUR_CORNERS, fmath.tau() / 4fx)
    pewpew.new_mothership(790fx, 790fx, pewpew.MothershipType.FOUR_CORNERS, fmath.tau() / 4fx)
    --right to left
    for y = 50fx, 750fx, 100fx do
      pewpew.new_mothership(800fx, y, pewpew.MothershipType.SIX_CORNERS, 0fx)
    end
    pewpew.new_mothership(800fx, 15fx, pewpew.MothershipType.SIX_CORNERS, 0fx)
    pewpew.new_mothership(790fx, 790fx, pewpew.MothershipType.SIX_CORNERS, 0fx)
  end
  if time > 3450 and time < 5080 and time % 250 == 0 then 
    --left to right
    for y = 50fx, 750fx, 100fx do
      pewpew.new_mothership(0fx, y, pewpew.MothershipType.SEVEN_CORNERS, 0fx)
    end
    pewpew.new_mothership(0fx, 0fx, pewpew.MothershipType.SEVEN_CORNERS, 0fx)
    pewpew.new_mothership(0fx, 790fx, pewpew.MothershipType.SEVEN_CORNERS, 0fx)
    --down to up
    for x = 50fx, 750fx, 100fx do
      pewpew.new_mothership(x, 0fx, pewpew.MothershipType.THREE_CORNERS, fmath.tau() / 4fx)
    end
    pewpew.new_mothership(0fx, 0fx, pewpew.MothershipType.THREE_CORNERS, fmath.tau() / 4fx)
    pewpew.new_mothership(790fx, 0fx, pewpew.MothershipType.THREE_CORNERS, fmath.tau() / 4fx)
    --up to down
    for x = 50fx, 750fx, 100fx do
      pewpew.new_mothership(x, 800fx, pewpew.MothershipType.FOUR_CORNERS, fmath.tau() / 4fx)
    end
    pewpew.new_mothership(0fx, 790fx, pewpew.MothershipType.FOUR_CORNERS, fmath.tau() / 4fx)
    pewpew.new_mothership(790fx, 790fx, pewpew.MothershipType.FOUR_CORNERS, fmath.tau() / 4fx)
    --right to left
    for y = 50fx, 750fx, 100fx do
      pewpew.new_mothership(800fx, y, pewpew.MothershipType.SIX_CORNERS, 0fx)
    end
    pewpew.new_mothership(800fx, 15fx, pewpew.MothershipType.SIX_CORNERS, 0fx)
    pewpew.new_mothership(790fx, 790fx, pewpew.MothershipType.SIX_CORNERS, 0fx)
  end
  if time % 790 == 0 and pewpew.get_score_of_player(0) > 3000 then 
    local x, y = random_position_rewards()
    pewpew.new_bomb(x, y, pewpew.BombType.FREEZE)
  end
  if time % 100 == 0 then 
    local x, y = random_position_rewards()
    cannon_box.new(x, y, 0)
  end
  if time > 1000 and time < 3540 and time % 770 == 0 and pewpew.get_score_of_player(0) > 3000 then
    local x, y = random_position_rewards()
    shield_box.new(x, y, weapon_config)
    local x, y = random_position_rewards()
    shield_box.new(x, y, weapon_config)
    local x, y = random_position_rewards()
    shield_box.new(x, y, weapon_config)
    local x, y = random_position_rewards()
    shield_box.new(x, y, weapon_config)
  end
  if time % 25 == 0 then
    local x, y = random_position_rewards()
    custom_grps(x, y, fmath.random_fixedpoint(0fx,fmath.tau()))--me custom rolling sphere
  end
end

--le update callback, essential for the whole thing above to work
pewpew.add_update_callback(level_tick)
--So yes, probably more than half of the code is unoptimized meshes and the rest is actual gameplay which i tried to optimize. This leads us to here, line 361. Bruh.