---
--  Polygons v1.0
--  Created by Tasty Kiwi
---

local player_helpers = require("/dynamic/helpers/player_helpers.lua")
local color_helpers = require("/dynamic/helpers/color_helpers.lua")

local width = 1000fx
local height = 1000fx
local centerx = width / 2fx
local centery = height / 2fx

pewpew.set_level_size(width, height)

-- Create player
local weapon_config1 = {frequency = pewpew.CannonFrequency.FREQ_15, cannon = pewpew.CannonType.TIC_TOC}
ship1 = player_helpers.new_player_ship(width / 2fx, height / 2fx, 0)
pewpew.configure_player(0, {camera_distance = -100fx, shield = 12})
pewpew.configure_player_ship_weapon(ship1, weapon_config1)

-- Import the addon
require("/dynamic/addons/round_funcs.lua")

-- Static meshes (that do not spin)
local static0 = pewpew.new_customizable_entity(centerx, centery)
pewpew.customizable_entity_set_mesh(static0, "/dynamic/assets/stacked_polygons.lua", 6) -- 1 (main one)

local static1 = pewpew.new_customizable_entity(750fx, 750fx)
pewpew.customizable_entity_set_mesh(static1, "/dynamic/assets/stacked_polygons.lua", 5) -- 2
pewpew.customizable_entity_configure_music_response(static1, { scale_z_start = 1fx, scale_z_end = 1.1024fx })

local static2 = pewpew.new_customizable_entity(250fx, 250fx)
pewpew.customizable_entity_set_mesh(static2, "/dynamic/assets/stacked_polygons.lua", 5) -- 3
pewpew.customizable_entity_configure_music_response(static2, { scale_z_start = 1fx, scale_z_end = 1.1024fx })

local static3 = pewpew.new_customizable_entity(250fx, 750fx)
pewpew.customizable_entity_set_mesh(static3, "/dynamic/assets/stacked_polygons.lua", 5) -- 4
pewpew.customizable_entity_configure_music_response(static3, { scale_z_start = 1fx, scale_z_end = 1.1024fx })

local static4 = pewpew.new_customizable_entity(750fx, 250fx)
pewpew.customizable_entity_set_mesh(static4, "/dynamic/assets/stacked_polygons.lua", 5) -- 5
pewpew.customizable_entity_configure_music_response(static4, { scale_z_start = 1fx, scale_z_end = 1.1024fx })

-- pillar / wall locations:
--  [3  1]
--  [    ]
--  [2  4]

make_walls(500fx, 12, centerx, centery) -- Map boundary walls

make_walls(75fx, 8, 750fx, 750fx) -- Pillar 1
make_walls(75fx, 8, 250fx, 250fx) -- Pillar 2
make_walls(75fx, 8, 250fx, 750fx) -- Pillar 3
make_walls(75fx, 8, 750fx, 250fx) -- Pillar 4

-- Variable meshes (that do spin)
local z_angle0 = 0fx
local variable0 = pewpew.new_customizable_entity(centerx, centery)
pewpew.customizable_entity_set_mesh(variable0, "/dynamic/assets/stacked_polygons.lua", 0)
pewpew.entity_set_update_callback(variable0, function(entity_id)
  pewpew.customizable_entity_set_mesh_angle(entity_id, 0fx, 1fx, 1fx, 1fx)
  pewpew.customizable_entity_add_rotation_to_mesh(entity_id, z_angle0, 0fx, 0fx, 1fx)
  z_angle0 = z_angle0 - 0.0034fx
end)

local z_angle1 = 0fx
local variable1 = pewpew.new_customizable_entity(centerx, centery)
pewpew.customizable_entity_set_mesh(variable1, "/dynamic/assets/stacked_polygons.lua", 1)
pewpew.entity_set_update_callback(variable1, function(entity_id)
  pewpew.customizable_entity_set_mesh_angle(entity_id, 0fx, 1fx, 1fx, 1fx)
  pewpew.customizable_entity_add_rotation_to_mesh(entity_id, z_angle1, 0fx, 0fx, 1fx)
  z_angle1 = z_angle1 + 0.0032fx
end)

local z_angle2 = 0fx
local variable2 = pewpew.new_customizable_entity(centerx, centery)
pewpew.customizable_entity_set_mesh(variable2, "/dynamic/assets/stacked_polygons.lua", 2)
pewpew.entity_set_update_callback(variable2, function(entity_id)
  pewpew.customizable_entity_set_mesh_angle(entity_id, 0fx, 1fx, 1fx, 1fx)
  pewpew.customizable_entity_add_rotation_to_mesh(entity_id, z_angle2, 0fx, 0fx, 1fx)
  z_angle2 = z_angle2 - 0.0064fx
end)

local z_angle3 = 0fx
local variable3 = pewpew.new_customizable_entity(centerx, centery)
pewpew.customizable_entity_set_mesh(variable3, "/dynamic/assets/stacked_polygons.lua", 3)
pewpew.entity_set_update_callback(variable3, function(entity_id)
  pewpew.customizable_entity_set_mesh_angle(entity_id, 0fx, 1fx, 1fx, 1fx)
  pewpew.customizable_entity_add_rotation_to_mesh(entity_id, z_angle3, 0fx, 0fx, 1fx)
  z_angle3 = z_angle3 + 0.0064fx
end)

local z_angle4 = 0fx
local variable4 = pewpew.new_customizable_entity(centerx, centery)
pewpew.customizable_entity_set_mesh(variable4, "/dynamic/assets/stacked_polygons.lua", 4)
pewpew.entity_set_update_callback(variable4, function(entity_id)
  pewpew.customizable_entity_set_mesh_angle(entity_id, 0fx, 1fx, 1fx, 1fx)
  pewpew.customizable_entity_add_rotation_to_mesh(entity_id, z_angle4, 0fx, 0fx, 1fx)
  z_angle4 = z_angle4 - 0.0128fx
end)

-- Some preparation variables
local time = 150
local mothership_radius = 471fx
local alpha = 0x6f
local alpha_lock
local wave = 0

-- Runs every tick
pewpew.add_update_callback(function()
  -- Color breathing code:
  if alpha == 0x6f then
    alpha_lock = false
  elseif alpha == 255 then
    alpha_lock = true
  end
  if alpha_lock == true then
    alpha = alpha - 2 
  elseif alpha_lock == false then
    alpha = alpha + 1
  end
  pewpew.customizable_entity_set_mesh_color(static0, color_helpers.make_color(0, 43, 54, alpha - 18))
  pewpew.customizable_entity_set_mesh_color(static1, color_helpers.make_color(153, 123, 17, alpha))
  pewpew.customizable_entity_set_mesh_color(static2, color_helpers.make_color(153, 123, 17, alpha))
  pewpew.customizable_entity_set_mesh_color(static3, color_helpers.make_color(153, 123, 17, alpha))
  pewpew.customizable_entity_set_mesh_color(static4, color_helpers.make_color(153, 123, 17, alpha))

  pewpew.customizable_entity_set_mesh_color(variable0, color_helpers.make_color(0, 246, 193, alpha))
  pewpew.customizable_entity_set_mesh_color(variable1, color_helpers.make_color(0, 255, 0, alpha))
  pewpew.customizable_entity_set_mesh_color(variable2, color_helpers.make_color(199, 75, 0, alpha))
  pewpew.customizable_entity_set_mesh_color(variable3, color_helpers.make_color(255, 0, 0, alpha))
  pewpew.customizable_entity_set_mesh_color(variable4, color_helpers.make_color(190, 31, 100, alpha))
  
  -- The rest of tick code:
  if player_helpers.all_players_have_lost() then
    pewpew.stop_game()
  else
    time = time + 1
    if time % 4 == 0 then pewpew.increase_score_of_player(0, 1) end
    if time % 210 == 0 then
      for i = 0, 4 do
        spawn_motherships_circular((mothership_radius + 10fx) - fmath.to_fixedpoint(i) * 25fx, 3, i, centerx, centery)
      end
      wave = wave + 1
      if wave % 5 == 0 then
        spawn_inertiacs_circular(400fx, 1, 1fx, centerx, centery)
      end
    end
    if time % 420 == 0 then
      spawn_shields_circular(400fx, 2, centerx, centery)
    end
    if time % 630 == 0 then
      spawn_cannons_circular(496fx, 1, centerx, centery)
    end
    if time % 900 == 0 then
      spawn_bombs_circular(300fx, 1, pewpew.BombType.FREEZE, centerx, centery)
    end
  end
end)
