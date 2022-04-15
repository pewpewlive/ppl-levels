local player_helper = require("/dynamic/helpers/player_helpers.lua")
local angle_helpers = require("/dynamic/helpers/angle_helpers.lua")
local floating_message = require("/dynamic/helpers/floating_message.lua")
local shield_box = require("/dynamic/helpers/boxes/shield_box.lua")
local cannon_box = require("/dynamic/helpers/boxes/cannon_box.lua")
local inertic = require("/dynamic/inertic.lua")

local function toRad(x)
  return x * (22fx/7fx) / 180fx
end
  
local function toDeg(x)
  return x * 180fx / (22fx/7fx)
end

local random_rotation = {}
local random_angle = fmath.random_fixedpoint(0fx, fmath.tau())
local random_axis1 = {}
local random_axis2 = {}
local random_fixedpoint = fmath.random_fixedpoint(10fx, 1240fx)

local height = 1250fx
local width = 1250fx
pewpew.set_level_size(width, height)

local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_30, cannon = pewpew.CannonType.DOUBLE}
local player = player_helper.new_player_ship(width / 2fx, height / 2fx, 0)
pewpew.configure_player(0, {camera_distance = 0fx, shield = 5})
pewpew.configure_player_ship_weapon(player, weapon_config)

for i = 0, 14 do
  local background = pewpew.new_customizable_entity(0fx, 0fx)
  pewpew.customizable_entity_set_mesh(background, "/dynamic/border and inside lines.lua", i)
end

local background = pewpew.new_customizable_entity(625fx, 625fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/background.lua", 0)

inertic.new(625fx, 625fx, true)
inertic.new(65fx, 625fx, false)
inertic.new(625fx, 1185fx, false)
inertic.new(1185fx, 625fx, false)
inertic.new(625fx, 65fx, false)

pewpew.add_wall(0fx, 700fx, 300fx, 630fx)
pewpew.add_wall(0fx, 550fx, 300fx, 620fx)
pewpew.add_wall(550fx, 1250fx, 620fx, 1010fx)
pewpew.add_wall(700fx, 1250fx, 630fx, 1010fx)
pewpew.add_wall(1250fx, 700fx, 950fx, 630fx)
pewpew.add_wall(1250fx , 550fx, 950fx, 620fx)
pewpew.add_wall(700fx, 0fx, 630fx, 300fx)
pewpew.add_wall(550fx, 0fx, 620fx, 300fx)

function make_bounce(player_id, bouncer_id, speed)
  local px, py = pewpew.entity_get_position(player_id)
  local bx, by = pewpew.entity_get_position(bouncer_id)
  local ax = px - bx
  local ay = py - by
  local angle = fmath.atan2(ay, ax)
  local dx, dy = fmath.sincos(angle)
  dx = dx * speed 
  dy = dy * speed
  pewpew.entity_set_position(player_id, px + dx, py + dy)
end

local bounce = pewpew.new_customizable_entity(625fx, 625fx)
pewpew.entity_set_radius(bounce, 30fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 6.2048fx)
end)
local bounce = pewpew.new_customizable_entity(300fx, 625fx)
pewpew.entity_set_radius(bounce, 6fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 20.2048fx)
end)
local bounce = pewpew.new_customizable_entity(625fx, 1005fx)
pewpew.entity_set_radius(bounce, 6fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 20.2048fx)
end)
local bounce = pewpew.new_customizable_entity(950fx, 625fx)
pewpew.entity_set_radius(bounce, 6fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 20.2048fx)
end)
local bounce = pewpew.new_customizable_entity(625fx, 300fx)
pewpew.entity_set_radius(bounce, 6fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 20.2048fx)
end)
local bounce = pewpew.new_customizable_entity(280fx, 625fx)
pewpew.entity_set_radius(bounce, 4fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 20.2048fx)
end)
local bounce = pewpew.new_customizable_entity(625fx, 1025fx)
pewpew.entity_set_radius(bounce, 4fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 20.2048fx)
end)
local bounce = pewpew.new_customizable_entity(970fx, 625fx)
pewpew.entity_set_radius(bounce, 4fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 20.2048fx)
end)
local bounce = pewpew.new_customizable_entity(625fx, 280fx)
pewpew.entity_set_radius(bounce, 4fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 20.2048fx)
end)
local bounce = pewpew.new_customizable_entity(230fx, 625fx)
pewpew.entity_set_radius(bounce, 8fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 20.2048fx)
end)
local bounce = pewpew.new_customizable_entity(625fx, 1075fx)
pewpew.entity_set_radius(bounce, 8fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 20.2048fx)
end)
local bounce = pewpew.new_customizable_entity(1020fx, 625fx)
pewpew.entity_set_radius(bounce, 8fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 20.2048fx)
end)
local bounce = pewpew.new_customizable_entity(625fx, 230fx)
pewpew.entity_set_radius(bounce, 8fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 20.2048fx)
end)
local bounce = pewpew.new_customizable_entity(190fx, 625fx)
pewpew.entity_set_radius(bounce, 20fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 20.2048fx)
end)
local bounce = pewpew.new_customizable_entity(625fx, 1125fx)
pewpew.entity_set_radius(bounce, 20fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 20.2048fx)
end)
local bounce = pewpew.new_customizable_entity(1070fx, 625fx)
pewpew.entity_set_radius(bounce, 20fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 20.2048fx)
end)
local bounce = pewpew.new_customizable_entity(625fx, 180fx)
pewpew.entity_set_radius(bounce, 20fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 20.2048fx)
end)
local bounce = pewpew.new_customizable_entity(140fx, 625fx)
pewpew.entity_set_radius(bounce, 27fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 25.2048fx)
end)
local bounce = pewpew.new_customizable_entity(625fx, 1160fx)
pewpew.entity_set_radius(bounce, 27fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 25.2048fx)
end)
local bounce = pewpew.new_customizable_entity(1120fx, 625fx)
pewpew.entity_set_radius(bounce, 27fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 25.2048fx)
end)
local bounce = pewpew.new_customizable_entity(625fx, 130fx)
pewpew.entity_set_radius(bounce, 27fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 25.2048fx)
end)
local bounce = pewpew.new_customizable_entity(70fx, 625fx)
pewpew.entity_set_radius(bounce, 35fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 25.2048fx)
end)
local bounce = pewpew.new_customizable_entity(625fx, 1195fx)
pewpew.entity_set_radius(bounce, 35fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 25.2048fx)
end)
local bounce = pewpew.new_customizable_entity(1160fx, 625fx)
pewpew.entity_set_radius(bounce, 35fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 25.2048fx)
end)
local bounce = pewpew.new_customizable_entity(625fx, 70fx)
pewpew.entity_set_radius(bounce, 35fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 25.2048fx)
end)
local bounce = pewpew.new_customizable_entity(10fx, 625fx)
pewpew.entity_set_radius(bounce, 40fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 25.2048fx)
end)
local bounce = pewpew.new_customizable_entity(625fx, 1240fx)
pewpew.entity_set_radius(bounce, 40fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 25.2048fx)
end)
local bounce = pewpew.new_customizable_entity(1230fx, 625fx)
pewpew.entity_set_radius(bounce, 40fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 25.2048fx)
end)
local bounce = pewpew.new_customizable_entity(625fx, 10fx)
pewpew.entity_set_radius(bounce, 40fx)
pewpew.customizable_entity_set_player_collision_callback(bounce, function(bounce, player_index, ship_entity_id)
  make_bounce(ship_entity_id, bounce, 25.2048fx)
end)



local time = 0
pewpew.add_update_callback(
    function()
      time = time + 1
      local conf = pewpew.get_player_configuration(0)
      if conf["has_lost"] == true then
        pewpew.stop_game()
     end
     local random_angle = fmath.random_fixedpoint(0fx, fmath.tau())
    if time > 50 and time < 1000 and time % 80 == 0 then 
        pewpew.new_inertiac(625fx, 625fx, 1fx, random_angle)
    end
    if time > 1100 and time < 1250 and time % 17 == 0 then 
      pewpew.new_inertiac(625fx, 625fx, 1fx, random_angle)
    end
    if time > 1250 and time < 2250 and time % 60 == 0 then 
      pewpew.new_inertiac(625fx, 625fx, 1fx, random_angle)
    end
    if time > 2250 and time < 3250 and time % 40 == 0 then 
      pewpew.new_inertiac(625fx, 625fx, 1fx, random_angle)
    end
    if time > 3250 and time < 4250 and time % 30 == 0 then 
      pewpew.new_inertiac(625fx, 625fx, 1fx, random_angle)
    end
    if time > 4250 and time % 20 == 0 then 
      pewpew.new_inertiac(625fx, 625fx, 1fx, random_angle)
    end
    if time > 200 and time < 1200 and time % 200 == 0 then 
      pewpew.new_inertiac(65fx, 625fx, 2fx, 0fx)
      pewpew.new_inertiac(1185fx, 625fx, 2fx, toRad(180fx))
      pewpew.new_inertiac(625fx, 1185fx, 2fx, toRad(270fx))
      pewpew.new_inertiac(625fx, 65fx, 2fx, toRad(90fx))
    end
    if time > 1200 and time < 2200 and time % 175 == 0 then 
      pewpew.new_inertiac(65fx, 625fx, 2fx, 0fx)
      pewpew.new_inertiac(1185fx, 625fx, 2fx, toRad(180fx))
      pewpew.new_inertiac(625fx, 1185fx, 2fx, toRad(270fx))
      pewpew.new_inertiac(625fx, 65fx, 2fx, toRad(90fx))
    end
    if time > 2200 and time < 3200 and time % 150 == 0 then 
      pewpew.new_inertiac(65fx, 625fx, 2fx, 0fx)
      pewpew.new_inertiac(1185fx, 625fx, 2fx, toRad(180fx))
      pewpew.new_inertiac(625fx, 1185fx, 2fx, toRad(270fx))
      pewpew.new_inertiac(625fx, 65fx, 2fx, toRad(90fx))
    end
    if time > 3200 and time < 4200 and time % 125 == 0 then 
      pewpew.new_inertiac(65fx, 625fx, 2fx, 0fx)
      pewpew.new_inertiac(1185fx, 625fx, 2fx, toRad(180fx))
      pewpew.new_inertiac(625fx, 1185fx, 2fx, toRad(270fx))
      pewpew.new_inertiac(625fx, 65fx, 2fx, toRad(90fx))
    end
    if time > 4200 and time < 5200 and time % 100 == 0 then 
      pewpew.new_inertiac(65fx, 625fx, 2fx, 0fx)
      pewpew.new_inertiac(1185fx, 625fx, 2fx, toRad(180fx))
      pewpew.new_inertiac(625fx, 1185fx, 2fx, toRad(270fx))
      pewpew.new_inertiac(625fx, 65fx, 2fx, toRad(90fx))
    end
    if time > 5200 and time % 75 == 0 then 
      pewpew.new_inertiac(65fx, 625fx, 2fx, 0fx)
      pewpew.new_inertiac(1185fx, 625fx, 2fx, toRad(180fx))
      pewpew.new_inertiac(625fx, 1185fx, 2fx, toRad(270fx))
      pewpew.new_inertiac(625fx, 65fx, 2fx, toRad(90fx))
    end
    if time > 600 and time < 1850 and time % 620 == 0 then 
      pewpew.new_asteroid(1fx, 1249fx)
      pewpew.new_asteroid(1249fx, 1249fx)
      pewpew.new_asteroid(1249fx, 1fx)
      pewpew.new_asteroid(1fx, 1fx)
    end
    if time > 1850 and time < 3100 and time % 570 == 0 then 
      pewpew.new_asteroid(1fx, 1249fx)
      pewpew.new_asteroid(1249fx, 1249fx)
      pewpew.new_asteroid(1249fx, 1fx)
      pewpew.new_asteroid(1fx, 1fx)
    end
    if time > 3100 and time < 4350 and time % 520 == 0 then 
      pewpew.new_asteroid(1fx, 1249fx)
      pewpew.new_asteroid(1249fx, 1249fx)
      pewpew.new_asteroid(1249fx, 1fx)
      pewpew.new_asteroid(1fx, 1fx)
    end
    if time > 4350 and time < 5600 and time % 470 == 0 then 
      pewpew.new_asteroid(1fx, 1249fx)
      pewpew.new_asteroid(1249fx, 1249fx)
      pewpew.new_asteroid(1249fx, 1fx)
      pewpew.new_asteroid(1fx, 1fx)
    end
    if time > 5600 and time < 6850 and time % 420 == 0 then 
      pewpew.new_asteroid(1fx, 1249fx)
      pewpew.new_asteroid(1249fx, 1249fx)
      pewpew.new_asteroid(1249fx, 1fx)
      pewpew.new_asteroid(1fx, 1fx)
    end
    if time > 6850 and time % 370 == 0 then 
      pewpew.new_asteroid(1fx, 1249fx)
      pewpew.new_asteroid(1249fx, 1249fx)
      pewpew.new_asteroid(1249fx, 1fx)
      pewpew.new_asteroid(1fx, 1fx)
    end
    if time > 1000 and time < 2250 and time % 570 == 0 then 
      pewpew.new_mothership(900fx, 900fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(375fx, 900fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(375fx, 375fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(900fx, 375fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
    end
    if time > 2250 and time < 3500 and time % 520 == 0 then 
      pewpew.new_mothership(900fx, 900fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(375fx, 900fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(375fx, 375fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(900fx, 375fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
    end
    if time > 3500 and time < 4750 and time % 470 == 0 then
      pewpew.new_mothership(900fx, 900fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(375fx, 900fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(375fx, 375fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(900fx, 375fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
    end
    if time > 4750 and time < 7000 and time % 420 == 0 then
      pewpew.new_mothership(900fx, 900fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(375fx, 900fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(375fx, 375fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(900fx, 375fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
    end
    if time > 7000 and time < 8250 and time % 370 == 0 then 
      pewpew.new_mothership(900fx, 900fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(375fx, 900fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(375fx, 375fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(900fx, 375fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
    end
    if time > 8250 and time % 320 == 0 then 
      pewpew.new_mothership(900fx, 900fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(375fx, 900fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(375fx, 375fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
      pewpew.new_mothership(900fx, 375fx, pewpew.MothershipType.FIVE_CORNERS, random_angle)
    end
    if time > 8000 and time < 9000 and time % 50 == 0 then 
      pewpew.new_rolling_sphere(fmath.random_fixedpoint(10fx,1240fx),fmath.random_fixedpoint(10fx,1240fx),0fx,15fx)
    end
    if time % 30 == 0 then
        local x, y = pewpew.entity_get_position(player)
        pewpew.print(x .. " , " .. y)
    end
    if time > 500 and time < 5000 and time % 700 == 0 then
      shield_box.new(900fx, 900fx, weapon_config)
      shield_box.new(375fx, 900fx, weapon_config)
      shield_box.new(375fx, 375fx, weapon_config)
      shield_box.new(900fx, 375fx, weapon_config)
    end
    if time > 5000 and time % 625 == 0 then
      shield_box.new(900fx, 900fx, weapon_config)
      shield_box.new(375fx, 900fx, weapon_config)
      shield_box.new(375fx, 375fx, weapon_config)
      shield_box.new(900fx, 375fx, weapon_config)
    end
    if time > 1 and time % 10 == 0 then
        pewpew.set_player_ship_speed(player, 1fx, 0fx, -1)
    end
    if time > 700 and time < 800 and time % 22 == 0 then
      pewpew.new_bomb(fmath.random_fixedpoint(10fx, 1240fx), fmath.random_fixedpoint(10fx, 1240fx), pewpew.BombType.REPULSIVE)
    end
    if time > 2000 and time < 2150 and time % 17 == 0 then
      pewpew.new_bomb(fmath.random_fixedpoint(10fx, 1240fx), fmath.random_fixedpoint(10fx, 1240fx), pewpew.BombType.REPULSIVE)
    end
    if time > 2150 and time % 200 == 0 then
      pewpew.new_bomb(fmath.random_fixedpoint(10fx, 1240fx), fmath.random_fixedpoint(10fx, 1240fx), pewpew.BombType.REPULSIVE)
    end
    if time > 1000 and time < 1450 and time % 32 == 0 then
      pewpew.new_bomb(fmath.random_fixedpoint(10fx, 1240fx), fmath.random_fixedpoint(10fx, 1240fx), pewpew.BombType.FREEZE)
    end
    if time > 2400 and time < 2550 and time % 15 == 0 then
      pewpew.new_bomb(fmath.random_fixedpoint(10fx, 1240fx), fmath.random_fixedpoint(10fx, 1240fx), pewpew.BombType.FREEZE)
    end
    if time > 2450 and time % 200 == 0 then
      pewpew.new_bomb(fmath.random_fixedpoint(10fx, 1240fx), fmath.random_fixedpoint(10fx, 1240fx), pewpew.BombType.FREEZE)
    end
    if time > 2350 and time % 1250 == 0 then
      local id = pewpew.new_bomb(fmath.random_fixedpoint(10fx, 1240fx), fmath.random_fixedpoint(10fx, 1240fx), pewpew.BombType.SMALL_ATOMIZE)
      player_helper.add_arrow(id, 0x422087ff)
    end
    if time > 600 and time < 1800 and time % 600 == 0 then
      cannon_box.new(fmath.random_fixedpoint(10fx, 1240fx), fmath.random_fixedpoint(10fx, 1240fx), fmath.random_int(0, 1))
    end
    if time > 1800 and time % 500 == 0 then
      cannon_box.new(fmath.random_fixedpoint(10fx, 1240fx), fmath.random_fixedpoint(10fx, 1240fx), fmath.random_int(0, 1))
    end
  end)