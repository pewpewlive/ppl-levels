local player_helper = require("/dynamic/helpers/player_helpers.lua") 
local floating_message = require("/dynamic/helpers/floating_message.lua")
local cannon_box = require("/dynamic/weapon_box.lua")

local height = 480fx 
local width = 480fx 
pewpew.set_level_size(width, height) 

local bg_inside = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(bg_inside, "/dynamic/beforecolor.lua", 6)
pewpew.customizable_entity_set_mesh_color(bg_inside, 0xffff0055)

local bg_outline = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh(bg_outline, "/dynamic/beforecolor.lua", 0)
pewpew.customizable_entity_set_mesh_color(bg_outline, 0xffff00ff)

local triangle1 = pewpew.new_customizable_entity(width / 2fx, 225fx)
pewpew.customizable_entity_set_mesh(triangle1, "/dynamic/beforecolor.lua", 7)
pewpew.customizable_entity_set_mesh_color(triangle1, 0xffff0055)

local triangle2 = pewpew.new_customizable_entity(width / 2fx + 5fx, 255fx)
pewpew.customizable_entity_set_mesh(triangle2, "/dynamic/beforecolor.lua", 7)
pewpew.customizable_entity_set_mesh_color(triangle2, 0xffff0055)
pewpew.customizable_entity_set_mesh_angle(triangle2, fmath.tau() / 2fx, 0fx, 0fx, 1fx)
local circle_array = {}

local function create_circles()
  table.insert(circle_array, pewpew.new_customizable_entity(width / 2fx, height / 2fx))
  pewpew.customizable_entity_set_mesh(circle_array[1], "/dynamic/beforecolor.lua", 1)
  pewpew.customizable_entity_set_mesh_color(circle_array[1], 0xffff0055)
  
  table.insert(circle_array, pewpew.new_customizable_entity(width / 2fx, height / 2fx))
  pewpew.customizable_entity_set_mesh(circle_array[2], "/dynamic/beforecolor.lua", 2)
  pewpew.customizable_entity_set_mesh_color(circle_array[2], 0xffff0055)

  table.insert(circle_array, pewpew.new_customizable_entity(width / 2fx, height / 2fx))
  pewpew.customizable_entity_set_mesh(circle_array[3], "/dynamic/beforecolor.lua", 3)
  pewpew.customizable_entity_set_mesh_color(circle_array[3], 0xffff0055)
  
  table.insert(circle_array, pewpew.new_customizable_entity(width / 2fx, height / 2fx))
  pewpew.customizable_entity_set_mesh(circle_array[4], "/dynamic/beforecolor.lua", 4)
  pewpew.customizable_entity_set_mesh_color(circle_array[4], 0xffff0055)
  
  table.insert(circle_array, pewpew.new_customizable_entity(width / 2fx, height / 2fx))
  pewpew.customizable_entity_set_mesh(circle_array[5], "/dynamic/beforecolor.lua", 5)
  pewpew.customizable_entity_set_mesh_color(circle_array[5], 0xffff0055)
end

local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_30, cannon = pewpew.CannonType.TRIPLE}
local omited_weapon_config = {frequency = pewpew.CannonFrequency.FREQ_7_5}
local player = player_helper.new_player_ship(width / 2fx, height / 2fx, 0)
pewpew.configure_player(0, {camera_distance = -50fx, shield = 0, move_joystick_color = 0xffff00ff, shoot_joystick_color = 0xff0000ff}) 
pewpew.configure_player_ship_weapon(player, omited_weapon_config) 

create_circles()

local angleLeft = 0fx
local angleRight = 0fx
reverse = false

local goalLeft = fmath.tau() / -1fx
local goalRight = fmath.tau() / 1fx

local function turnCircles()
  angleLeft = angleLeft + (goalLeft - angleLeft) / (420fx)
  pewpew.customizable_entity_set_mesh_angle(circle_array[2], angleLeft, 0fx, 0fx, 1fx)
  pewpew.customizable_entity_set_mesh_angle(circle_array[4], angleLeft, 0fx, 0fx, 1fx)
  if not reverse then
    goalLeft = goalLeft - fmath.tau() / 10fx
  else
    goalLeft = goalLeft + fmath.tau() / 10fx
  end
  angleRight = angleRight + (goalRight - angleRight) / (420fx)
  pewpew.customizable_entity_set_mesh_angle(circle_array[1], angleRight, 0fx, 0fx, 1fx)
  pewpew.customizable_entity_set_mesh_angle(circle_array[3], angleRight, 0fx, 0fx, 1fx)
  pewpew.customizable_entity_set_mesh_angle(circle_array[5], angleRight, 0fx, 0fx, 1fx)
  if not reverse then
    goalRight = goalRight + fmath.tau() / 10fx
  else
    goalRight = goalRight - fmath.tau() / 10fx
  end
  if goalRight > 30fx and goalLeft < -30fx then
    reverse = true
  elseif goalRight < -30fx and goalLeft > 30fx then
    reverse = false
  end
end

local waitforkill = false
local waitforkill2 = false
local waitforkill3 = false
function create_mothership_angle(x, y)
  local px, py = pewpew.entity_get_position(player)
  local dx = px - x
  local dy = py - y
  return fmath.atan2(dy,dx)
end

local time = 0
pewpew.add_update_callback( 
    function()
      time = time + 1
      if time == 40 then
        floating_message.new(width / 2fx, height / 2fx, "Round 1 / 3", 1fx, 0x00ffffff, 4)
      end
      if pewpew.entity_get_is_alive(player) then
        turnCircles()
        if time < 400 then
          if time % 15 == 0 then
            pewpew.new_rolling_cube(450fx, 450fx)
          end
        end
        if time == 400 then
          cannon_box.new(width / 2fx, height / 2fx, {"/dynamic/weapon_mesh.lua", 0}, {"/dynamic/helpers/boxes/inner_box_graphics.lua", 5},
            function(player_id, entity_id)
              local weapon_config1 = {frequency = pewpew.CannonFrequency.FREQ_5, cannon = pewpew.CannonType.HEMISPHERE}
              pewpew.configure_player_ship_weapon(player, weapon_config1)
              floating_message.new(width / 2fx, height / 2fx + 10fx, "GIGA CANNON", 1.2048fx, 0xff0000ff, 4)
              pewpew.play_sound("/dynamic/helpers/boxes/cannon_pickup_sound.lua", 0, width / 2fx, height / 2fx)
            end, 400)
          waitforkill = true
        elseif time == 430 then
          cannon_box.new(width / 2fx, height / 2fx, {"/dynamic/weapon_mesh.lua", 0}, {"/dynamic/helpers/boxes/inner_box_graphics.lua", 5},
            function(player_id, entity_id)
              local weapon_config1 = {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.TRIPLE}
              pewpew.configure_player_ship_weapon(player, weapon_config1)
              floating_message.new(width / 2fx, height / 2fx + 10fx, "KILO CANNON", 1.2048fx, 0xff0000ff, 4)
              pewpew.play_sound("/dynamic/helpers/boxes/cannon_pickup_sound.lua", 0, width / 2fx, height / 2fx)
            end, 400)
            pewpew.new_mothership(25fx, 25fx, pewpew.MothershipType.FOUR_CORNERS, create_mothership_angle(25fx, 25fx))
            pewpew.new_mothership(450fx, 25fx, pewpew.MothershipType.FOUR_CORNERS, create_mothership_angle(450fx, 25fx))
            pewpew.new_mothership(25fx, 450fx, pewpew.MothershipType.FOUR_CORNERS, create_mothership_angle(25fx, 450fx))
            pewpew.new_mothership(450fx, 450fx, pewpew.MothershipType.FOUR_CORNERS, create_mothership_angle(450fx, 450fx))
            floating_message.new(width / 2fx, height / 2fx - 10fx, "Round 2 / 3", 1fx, 0x00ffffff, 4)
            waitforkill2 = true
        elseif time == 460 then
          pewpew.new_mothership(25fx, 25fx, pewpew.MothershipType.SIX_CORNERS, create_mothership_angle(25fx, 25fx))
          pewpew.new_mothership(450fx, 25fx, pewpew.MothershipType.SIX_CORNERS, create_mothership_angle(450fx, 25fx))
          pewpew.new_mothership(25fx, 450fx, pewpew.MothershipType.SIX_CORNERS, create_mothership_angle(25fx, 450fx))
          pewpew.new_mothership(450fx, 450fx, pewpew.MothershipType.SIX_CORNERS, create_mothership_angle(450fx, 450fx))
          pewpew.new_mothership(25fx, 25fx, pewpew.MothershipType.SIX_CORNERS, create_mothership_angle(25fx, 25fx))
          pewpew.new_mothership(450fx, 25fx, pewpew.MothershipType.SIX_CORNERS, create_mothership_angle(450fx, 25fx))
          pewpew.new_mothership(25fx, 450fx, pewpew.MothershipType.SIX_CORNERS, create_mothership_angle(25fx, 450fx))
          pewpew.new_mothership(450fx, 450fx, pewpew.MothershipType.SIX_CORNERS, create_mothership_angle(450fx, 450fx))
          floating_message.new(width / 2fx, height / 2fx - 10fx, "Round 3 / 3", 1fx, 0x00ffffff, 4)
          waitforkill3 = true
        end
        if waitforkill and pewpew.get_entity_count(pewpew.EntityType.ROLLING_CUBE) == 0 then
          pewpew.configure_player_ship_weapon(player, omited_weapon_config)
          waitforkill = false
        elseif time == 402 and waitforkill then
          time = time - 1
        end
        if waitforkill2 and pewpew.get_entity_count(pewpew.EntityType.MOTHERSHIP) == 0 then
          waitforkill2 = false
        elseif time == 432 and waitforkill2 then
          time = time - 1
        end
        if waitforkill3 and pewpew.get_entity_count(pewpew.EntityType.MOTHERSHIP) == 0 then
          waitforkill3 = false
          time = 1000
          local msgnum1 = pewpew.new_customizable_entity(width / 2fx, 420fx)
          pewpew.customizable_entity_set_string(msgnum1, "Nice.")
          local msgnum2 = pewpew.new_customizable_entity(width / 2fx, height / 2fx + 100fx)
          pewpew.customizable_entity_set_string(msgnum2, "Time to conquer")
          local msgnum3 = pewpew.new_customizable_entity(width / 2fx, height / 2fx + 50fx)
          pewpew.customizable_entity_set_string(msgnum3, "the leaderboards.")
        elseif time == 462 and waitforkill3 then
          time = time - 1
        end
        if time == 1060 then
          pewpew.add_damage_to_player_ship(player, 1)
        end
        else
        pewpew.stop_game()
      end
    end)