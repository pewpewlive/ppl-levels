-- ---------------------------------- --
-- ------------ Deadline ------------ --
-- ------ by: SKPG, Tasty Kiwi ------ --
-- ---------------------------------- --

-- import helpers
local player_helper = require("/dynamic/helpers/player_helpers.lua") 
local color_helper = require("/dynamic/helpers/color_helpers.lua")
local disappearing_message = require("/dynamic/helpers/disappearing_message.lua")
local angle_helper = require("/dynamic/helpers/angle_helpers.lua")

-- prep stuff
local height = 500fx
local width = 1000fx
pewpew.set_level_size(width, height) 

-- make bg
local background_outline = pewpew.new_customizable_entity(500fx, 250fx)
pewpew.customizable_entity_set_mesh(background_outline, "/dynamic/assets/bg_outline_mesh.lua", 0)

-- make text
local background_text = pewpew.new_customizable_entity(width / 2fx, (height / 2fx) + 200fx)
pewpew.customizable_entity_set_string(background_text, color_helper.color_to_string(color_helper.make_color(fmath.random_int(0, 255), fmath.random_int(0, 255), fmath.random_int(0, 255), 255)) .. "Hurry up!")

pewpew.customizable_entity_set_mesh_scale(background_text, 1fx)
pewpew.customizable_entity_set_mesh_color(background_text, color_helper.make_color(fmath.random_int(0, 255), fmath.random_int(0, 255), fmath.random_int(0, 255), 255))
local background_text2 = pewpew.new_customizable_entity(width / 2fx, (height / 2fx) + 150fx)
pewpew.customizable_entity_set_string(background_text2, color_helper.color_to_string(color_helper.make_color(fmath.random_int(0, 255), fmath.random_int(0, 255), fmath.random_int(0, 255), 255)) .. "Kill all of the enemies before the timer runs out!")

pewpew.customizable_entity_set_mesh_scale(background_text2, 8fx / 12fx)
pewpew.customizable_entity_set_mesh_color(background_text2, color_helper.make_color(fmath.random_int(0, 255), fmath.random_int(0, 255), fmath.random_int(0, 255), 255))
local background_text3 = pewpew.new_customizable_entity(width / 2fx, (height / 2fx) - 225fx)

local credit_color = color_helper.color_to_string(color_helper.make_color(fmath.random_int(0, 255), fmath.random_int(0, 255), fmath.random_int(0, 255), 51))
pewpew.customizable_entity_set_string(background_text3, credit_color .. "Special thanks to #0000fb33SKPG-Tech" .. credit_color .. " for creating original Deadline!")
pewpew.customizable_entity_set_mesh_scale(background_text3, 5fx / 10fx)
pewpew.customizable_entity_set_mesh_color(background_text3, color_helper.make_color(fmath.random_int(0, 255), fmath.random_int(0, 255), fmath.random_int(0, 255), 51))

-- prep player
local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.TIC_TOC}
local player = player_helper.new_player_ship(width / 2fx, height / 2fx, 0)
pewpew.configure_player(0, {camera_distance = 0fx, shield = 15})

pewpew.configure_player_ship_weapon(player, weapon_config) 

-- add timer
local timer_text = pewpew.new_customizable_entity(width / 2fx, height / 2fx)
pewpew.customizable_entity_set_mesh_scale(timer_text, 30fx/15fx)

-- bounce for those spawning nests
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

-- make spawning nests
local spawnpoint1 = pewpew.new_customizable_entity((width / 2fx) - 350fx, height / 2fx)
pewpew.customizable_entity_set_mesh(spawnpoint1, "/dynamic/assets/nest_mesh.lua", 0)
pewpew.customizable_entity_set_mesh_color(spawnpoint1, color_helper.make_color(fmath.random_int(0, 255), fmath.random_int(0, 255), fmath.random_int(0, 255), 255))
pewpew.customizable_entity_configure_music_response(spawnpoint1, {scale_x_start = 1fx, scale_x_end = 6fx / 5fx, scale_y_start = 1fx, scale_y_end = 6fx / 5fx, color_start = 0xffffff88, color_end = 0xffffffff})

pewpew.entity_set_radius(spawnpoint1, 50fx)

pewpew.customizable_entity_set_player_collision_callback(spawnpoint1, function(entity_id, player_index, ship_entity_id)
  make_bounce(ship_entity_id, spawnpoint1, 4.2048fx)
end)

local spawnpoint2 = pewpew.new_customizable_entity((width / 2fx) + 350fx, height / 2fx)
pewpew.customizable_entity_set_mesh(spawnpoint2, "/dynamic/assets/nest_mesh.lua", 0)
pewpew.customizable_entity_set_mesh_color(spawnpoint2, color_helper.make_color(fmath.random_int(0, 255), fmath.random_int(0, 255), fmath.random_int(0, 255), 255))
pewpew.customizable_entity_configure_music_response(spawnpoint2, {scale_x_start = 1fx, scale_x_end = 6fx / 5fx, scale_y_start = 1fx, scale_y_end = 6fx / 5fx, color_start = 0xffffff88, color_end = 0xffffffff})

pewpew.entity_set_radius(spawnpoint2, 50fx)
pewpew.customizable_entity_set_player_collision_callback(spawnpoint2, function(entity_id, player_index, ship_entity_id)
  make_bounce(ship_entity_id, spawnpoint2, 4.2048fx)
end)


local entity_table = {}

local difficulty = 5

function spawn_wary()
  for i = 1, difficulty - 3 do
    table.insert(entity_table, pewpew.new_wary((width / 2fx) - 350fx, height / 2fx))
  end
  for i = 1, difficulty - 3 do
    table.insert(entity_table, pewpew.new_wary((width / 2fx) + 350fx, height / 2fx))
  end
end

function spawn_rolling_cube()
  for i = 1, difficulty do
    table.insert(entity_table, pewpew.new_rolling_cube((width / 2fx) - 350fx, height / 2fx))
  end
  for i = 1, difficulty do
    table.insert(entity_table, pewpew.new_rolling_cube((width / 2fx) + 350fx, height / 2fx))
  end
end

function spawn_asteroid()
  for i = 1, difficulty - 4 do
    table.insert(entity_table, pewpew.new_asteroid((width / 2fx) - 350fx, height / 2fx))
  end
  for i = 1, difficulty - 4 do
    table.insert(entity_table, pewpew.new_asteroid((width / 2fx) + 350fx, height / 2fx))
  end
end

function spawn_mothership()
  for i = 1, difficulty - 2 do
    table.insert(entity_table, pewpew.new_mothership((width / 2fx) - 350fx, height / 2fx, fmath.random_int(0, 4), angle_helper.random_angle()))
  end
  for i = 1, difficulty - 2 do
    table.insert(entity_table, pewpew.new_mothership((width / 2fx) + 350fx, height / 2fx, fmath.random_int(0, 4), angle_helper.random_angle()))
  end
end

function spawn_ufo()
  for i = 1, difficulty - 3 do
    table.insert(entity_table, pewpew.new_ufo((width / 2fx) - 350fx, height / 2fx, 5fx / 2fx))
    pewpew.ufo_set_enable_collisions_with_walls(entity_table[i], true)
  end
  for i = difficulty - 2, (difficulty - 3) * 2 do
    table.insert(entity_table, pewpew.new_ufo((width / 2fx) + 350fx, height / 2fx, 5fx / 2fx))
    pewpew.ufo_set_enable_collisions_with_walls(entity_table[i], true)
  end
end

function spawn_inertiac()
  for i = 1, difficulty - 5 do
    table.insert(entity_table, pewpew.new_inertiac((width / 2fx) - 350fx, height / 2fx, 3fx / 2fx, angle_helper.random_angle()))
  end
  for i = 1, difficulty - 5 do
    table.insert(entity_table, pewpew.new_inertiac((width / 2fx) + 350fx, height / 2fx, 3fx / 2fx, angle_helper.random_angle()))
  end
end

function spawn_crowder()
  for i = 1, difficulty do
    table.insert(entity_table, pewpew.new_crowder((width / 2fx) - 350fx, height / 2fx))
  end
  for i = 1, difficulty do
    table.insert(entity_table, pewpew.new_crowder((width / 2fx) + 350fx, height / 2fx))
  end
end

function spawn_baf_blue()
  for i = 1, difficulty + 7 do
    table.insert(entity_table, pewpew.new_baf_blue((width / 2fx) - 350fx, height / 2fx, angle_helper.random_angle(), 10fx, 900))
  end
  for i = 1, difficulty + 7 do
    table.insert(entity_table, pewpew.new_baf_blue((width / 2fx) + 350fx, height / 2fx, angle_helper.random_angle(), 10fx, 900))
  end
end

-- Too hard ._.
--[[
function spawn_baf_red()
  for i = 1, difficulty + 7 do
    table.insert(entity_table, pewpew.new_baf_red((width / 2fx) - 350fx, height / 2fx, angle_helper.random_angle(), 10fx, 900))
  end
  for i = 1, difficulty + 7 do
    table.insert(entity_table, pewpew.new_baf_red((width / 2fx) + 350fx, height / 2fx, angle_helper.random_angle(), 10fx, 900))
  end
end
]]

function spawn_baf()
  for i = 1, difficulty + 7 do
    table.insert(entity_table, pewpew.new_baf((width / 2fx) - 350fx, height / 2fx, angle_helper.random_angle(), 10fx, 900))
  end
  for i = 1, difficulty + 7 do
    table.insert(entity_table, pewpew.new_baf((width / 2fx) + 350fx, height / 2fx, angle_helper.random_angle(), 10fx, 900))
  end
end


-- variable prep
local time = 0
local second_counter_amount = 40
local second_counter = second_counter_amount
local frame_counter = 60
local round = 1
local end_game = true
pewpew.customizable_entity_set_string(timer_text, color_helper.color_to_string(0x87bab8ff) .. second_counter)

spawn_wary()
spawn_crowder()

local entity_count = #entity_table

pewpew.add_update_callback(
    function()
      time = time + 1
      if pewpew.entity_get_is_alive(player) then
        local px, py = pewpew.entity_get_position(player)
        if time == 30 then
          disappearing_message.new(width / 2fx, (height / 2fx) + 50fx, "Round: 1", 1fx, 0xfba7deff, 3)
        end
        for i = 1, #entity_table do
          if not pewpew.entity_get_is_alive(entity_table[i]) then
            table.remove(entity_table, i)
            entity_count = entity_count - 1
            table.insert(entity_table, pewpew.new_customizable_entity((width / 2fx) + 350fx, height / 2fx))
          end
        end
        if entity_count == 0 then
          disappearing_message.new(width / 2fx, (height / 2fx) - 50fx, "Score Bonus: " .. second_counter .. " *10", 1fx, 0x42dbd9ff, 2)
          pewpew.increase_score_of_player(0, second_counter * 10)
          round = round + 1
          pewpew.configure_player_ship_weapon(player, {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.TIC_TOC})
          disappearing_message.new(width / 2fx, (height / 2fx) + 50fx, "Round: " .. round, 1fx, 0xfba7deff, 3)
          second_counter = second_counter_amount
          if round % 7 == 0 then
            -- every 7th round in series, spawn boss wave
            entity_table = {}
            local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_30, cannon = pewpew.CannonType.FOUR_DIRECTIONS, duration = 220}
            pewpew.configure_player_ship_weapon(player, weapon_config)
            disappearing_message.new(width / 2fx, (height / 2fx) + 94.2048fx, "BOSS ROUND", 2fx, 0x3f8725ff, 4)
            spawn_rolling_cube()
            spawn_baf()
            spawn_baf_blue()
            spawn_mothership()
            spawn_crowder()
            entity_count = #entity_table
          elseif round % 6 == 0 then
            -- every 6th round in series, spawn inertiac wave
            entity_table = {}
            local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_7_5, cannon = pewpew.CannonType.TRIPLE, duration = 999999}
            pewpew.configure_player_ship_weapon(player, weapon_config)
            spawn_inertiac()
            entity_count = #entity_table
          elseif round % 5 == 0 then
            -- every 5th round in series, spawn UFO wave
            entity_table = {}
            spawn_ufo()
            entity_count = #entity_table
          elseif round % 4 == 0 then
            -- every 4th round in series, spawn rolling cube wave 
            entity_table = {}
            spawn_rolling_cube()
            entity_count = #entity_table
          elseif round % 3 == 0 then
            -- every 3rd round in series, spawn asteroid wave 
            entity_table = {}
            local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_7_5, cannon = pewpew.CannonType.HEMISPHERE, duration = 120}
            pewpew.configure_player_ship_weapon(player, weapon_config)
            spawn_asteroid()
            entity_count = #entity_table
          elseif round % 2 == 0 then
            -- every 2nd round in series, spawn mothership wave
            entity_table = {}
            spawn_mothership()
            spawn_baf()
            entity_count = #entity_table
          else
            -- every 1st round in series, spawn wary wave 
            entity_table = {}
            spawn_wary()
            spawn_crowder()
            entity_count = #entity_table
          end
          if round % 3 == 0 then
            -- every 3 rounds, increase difficulty and shields
            difficulty = difficulty + 1
            local shields = pewpew.get_player_configuration(0).shield
            disappearing_message.new((width / 2fx) - 100fx, (height / 2fx) - 100fx, "Difficulty +1", 1fx, 0x14df5fff, 2)
            disappearing_message.new((width / 2fx) + 100fx, (height / 2fx) - 100fx, "Shield +1", 1fx, 0xffff00ff, 2)
            pewpew.configure_player(0, {shield = shields + 1})
          end
          if round % 4 == 0 and second_counter_amount > 10 then
            -- every 4 rounds, decrease max time by 1
            second_counter_amount = second_counter_amount - 1
            disappearing_message.new((width / 2fx), (height / 2fx) + 100fx, "Time -1", 1fx, 0xe150c7ff, 2)
          end
        end
        frame_counter = frame_counter - 2
        if second_counter <= 6 and second_counter > 1 and time % 30 == 0 then
          pewpew.play_ambient_sound("/dynamic/sounds.lua", 1)
        end
        if second_counter <= 5 and second_counter > 0 then
          pewpew.customizable_entity_set_string(timer_text, color_helper.color_to_string(0xbf2626ff) .. second_counter)
        elseif second_counter <= 10 and second_counter > 5 then
          pewpew.customizable_entity_set_string(timer_text, color_helper.color_to_string(0xbfb226ff) .. second_counter)
        elseif second_counter > 10 then
          pewpew.customizable_entity_set_string(timer_text, color_helper.color_to_string(0x87bab8ff) .. second_counter)
        elseif second_counter == 0 then
          pewpew.customizable_entity_set_string(timer_text, color_helper.color_to_string(0xbf2626ff) .. ":(")
        end
        if frame_counter == 0 then
          second_counter = second_counter - 1
          frame_counter = 60
        end
        if second_counter == 0 then
          if end_game == true then
            pewpew.play_ambient_sound("/dynamic/sounds.lua", 0)
            end_game = false
          end
          local shield = pewpew.get_player_configuration(0).shield
          pewpew.add_damage_to_player_ship(player, shield + 1)
        end
      else
        pewpew.customizable_entity_set_string(timer_text, color_helper.color_to_string(0xbf2626ff) .. ":(")
        pewpew.stop_game()
      end
    end)
