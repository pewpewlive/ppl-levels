local boxes = require("/dynamic/box_template.lua")
local box_outer_mesh_info = {"/dynamic/box_graphics.lua", 0}
local box_inner_mesh_info = {"/dynamic/box_graphics.lua", 1}
local outershield = {"/dynamic/box_graphics.lua", 2}
local innershield = {"/dynamic/box_graphics.lua", 3}
local outerdouble = {"/dynamic/box_graphics.lua", 4}
local innerdouble = {"/dynamic/box_graphics.lua", 5}
local outerhemis = {"/dynamic/box_graphics.lua", 6}
local innerhemis = {"/dynamic/box_graphics.lua", 7}
local outerak = {"/dynamic/box_graphics.lua", 8}
local innerak = {"/dynamic/box_graphics.lua", 9}
local outerburst = {"/dynamic/box_graphics.lua", 11}
local innerburst = {"/dynamic/box_graphics.lua", 12}
local outerinvinc = {"/dynamic/box_graphics.lua", 13}
local innerinvinc = {"/dynamic/box_graphics.lua", 14}
local outermult = {"/dynamic/box_graphics.lua", 15}
local innermult = {"/dynamic/box_graphics.lua", 16}

local power_ups = {}


function ColorToString(color)
  local s = string.format("%x", color)
  while string.len(s) < 8 do
    s = "0" .. s
  end
  return "#" .. s
end


function power_ups.hemispheremake(x,y)


  pewpew.create_explosion(x, y, 0xffff00ff, 4fx, 30)

      local box = boxes.new(x, y, outerhemis, innerhemis,
      function(entity_id,player_ship, entity_ship)
        local time = 0
        --Plays the sound and boosts the player's cannon
        pewpew.configure_player_ship_weapon(entity_ship, { frequency = pewpew.CannonFrequency.FREQ_3, cannon = pewpew.CannonType.HEMISPHERE, duration = 120})
        pewpew.play_ambient_sound("/dynamic/sounds.lua", 3)
        --Spawns the text
        local textentity = pewpew.new_customizable_entity(x,y)
        pewpew.customizable_entity_set_mesh(textentity,"/dynamic/text_mesh.lua",0)
        pewpew.customizable_entity_set_string(textentity, "#ffff00ff HEMISHERE")
        pewpew.customizable_entity_start_spawning(textentity, 15)
        --Makes the test fade away
        local opacity = 0xffff00ff
        local z = 10fx
        local function fade()
          time = time + 1
          if opacity > 0xffff0001 then
            opacity = opacity - 3
          end
          z = z + 9fx
          pewpew.customizable_entity_set_string(textentity, ColorToString(opacity) .. "HEMISPHERE")
          pewpew.customizable_entity_set_mesh_z(textentity, z)
          if time > 150 then
            pewpew.customizable_entity_start_exploding(textentity, 2)
          end
        end
        pewpew.entity_set_update_callback(textentity, fade)
        
      end, 400
    )
    return box
      
end

function power_ups.burstmake(x,y)


  pewpew.create_explosion(x, y, 0xffff00ff, 4fx, 30)

      local box = boxes.new(x, y, outerburst, innerburst,
      function(entity_id,player_ship, entity_ship)
        local time = 0
        --Plays the sound and boosts the player's cannon
        pewpew.configure_player_ship_weapon(entity_ship, { frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.HEMISPHERE, duration = 60})
        pewpew.play_ambient_sound("/dynamic/sounds.lua", 3)
        --Spawns the text
        local textentity = pewpew.new_customizable_entity(x,y)
        pewpew.customizable_entity_set_mesh(textentity,"/dynamic/text_mesh.lua",0)
        pewpew.customizable_entity_set_string(textentity, "#ffff00ff HEMISHERE")
        pewpew.customizable_entity_start_spawning(textentity, 15)
        --Makes the test fade away
        local opacity = 0xffff00ff
        local z = 10fx
        local function fade()
          time = time + 1
          if opacity > 0xffff0001 then
            opacity = opacity - 3
          end
          z = z + 9fx
          pewpew.customizable_entity_set_string(textentity, ColorToString(opacity) .. "BURST")
          pewpew.customizable_entity_set_mesh_z(textentity, z)
          if time > 150 then
            pewpew.customizable_entity_start_exploding(textentity, 2)
          end
        end
        pewpew.entity_set_update_callback(textentity, fade)
        
      end, 400
    )
    return box
      
end

  function power_ups.akmake(x,y)

      pewpew.create_explosion(x, y, 0x992299ff, 4fx, 30)

          local box = boxes.new(x, y, outerak, innerak,
          function(entity_id,player_ship, entity_ship)
            local time = 0
            --Plays the sound and boosts the player's cannon
            pewpew.configure_player_ship_weapon(entity_ship, { frequency = pewpew.CannonFrequency.FREQ_15, cannon = pewpew.CannonType.SINGLE, duration = 120})
            pewpew.play_ambient_sound("/dynamic/sounds.lua", 3)
            --Spawns the text
            local textentity = pewpew.new_customizable_entity(x,y)
            pewpew.customizable_entity_set_mesh(textentity,"/dynamic/text_mesh.lua",0)
            pewpew.customizable_entity_set_string(textentity, "#ffff00ff HEMISHERE")
            pewpew.customizable_entity_start_spawning(textentity, 15)
            --Makes the test fade away
            local opacity = 0x992299ff
            local z = 10fx
            local function fade()
              time = time + 1
              if opacity > 0x99229901 then
                opacity = opacity - 3
              end
              z = z + 9fx
              pewpew.customizable_entity_set_string(textentity, ColorToString(opacity) .. "AK-286")
              pewpew.customizable_entity_set_mesh_z(textentity, z)
              if time > 150 then
                pewpew.customizable_entity_start_exploding(textentity, 2)
              end
            end
            pewpew.entity_set_update_callback(textentity, fade)
            
          end, 400
        )
        return box
          
  end

  function power_ups.triplemake(x,y)
    



      pewpew.create_explosion(x, y, 0x00ffffff, 4fx, 30)

          local box = boxes.new(x, y, box_outer_mesh_info, box_inner_mesh_info,
          function(entity_id,player_ship, entity_ship)
            local time = 0
            --Plays the sound and boosts the player's cannon
            pewpew.configure_player_ship_weapon(entity_ship, { frequency = pewpew.CannonFrequency.FREQ_15, cannon = pewpew.CannonType.TRIPLE, duration = 120})
            pewpew.play_ambient_sound("/dynamic/sounds.lua", 3)
            --Spawns the text
            local textentity = pewpew.new_customizable_entity(x,y)
            pewpew.customizable_entity_set_mesh(textentity,"/dynamic/text_mesh.lua",0)
            pewpew.customizable_entity_set_string(textentity, "#00ffffff TRIPLE")
            pewpew.customizable_entity_start_spawning(textentity, 15)
            --Makes the test fade away
            local opacity = 0x00ffffff
            local z = 10fx
            local function fade()
              time = time + 1
              if opacity > 0x00ffff01 then
                opacity = opacity - 3
              end
              z = z + 9fx
              pewpew.customizable_entity_set_string(textentity, ColorToString(opacity) .. "TRIPLE")
              pewpew.customizable_entity_set_mesh_z(textentity, z)
              if time > 150 then
                pewpew.customizable_entity_start_exploding(textentity, 2)
              end
            end
            pewpew.entity_set_update_callback(textentity, fade)
            
          end, 400
        )
        return box
          
  end

  function power_ups.doublemake(x,y)
    



    pewpew.create_explosion(x, y, 0x00ffffff, 4fx, 30)

        local box = boxes.new(x, y, box_outer_mesh_info, box_inner_mesh_info,
        function(entity_id,player_ship, entity_ship)
          local time = 0
          --Plays the sound and boosts the player's cannon
          pewpew.configure_player_ship_weapon(entity_ship, { frequency = pewpew.CannonFrequency.FREQ_15, cannon = pewpew.CannonType.DOUBLE, duration = 120})
          pewpew.play_ambient_sound("/dynamic/sounds.lua", 3)
          --Spawns the text
          local textentity = pewpew.new_customizable_entity(x,y)
          pewpew.customizable_entity_set_mesh(textentity,"/dynamic/text_mesh.lua",0)
          pewpew.customizable_entity_set_string(textentity, "#00ffffff DOUBLE")
          pewpew.customizable_entity_start_spawning(textentity, 15)
          --Makes the test fade away
          local opacity = 0x00ffffff
          local z = 10fx
          local function fade()
            time = time + 1
            if opacity > 0x00ffff01 then
              opacity = opacity - 3
            end
            z = z + 9fx
            pewpew.customizable_entity_set_string(textentity, ColorToString(opacity) .. "DOUBLE")
            pewpew.customizable_entity_set_mesh_z(textentity, z)
            if time > 150 then
              pewpew.customizable_entity_start_exploding(textentity, 2)
            end
          end
          pewpew.entity_set_update_callback(textentity, fade)
          
        end, 400
      )
      return box
        
end
  
  --Makes the Double Swipe Power up; same set up as the Triple Power up
  
  function power_ups.doubleswipemake(x,y)
    

      pewpew.create_explosion(x, y, 0xff0044ff, 4fx, 30)
      local box = boxes.new(x, y, outerdouble, innerdouble,
      function(entity_id,player_ship, entity_ship)
        local time = 0
        pewpew.configure_player_ship_weapon(entity_ship, { frequency = pewpew.CannonFrequency.FREQ_30, cannon = pewpew.CannonType.DOUBLE_SWIPE, duration = 120})
        pewpew.play_ambient_sound("/dynamic/sounds.lua", 4)
  
        local textentity = pewpew.new_customizable_entity(x,y)
        pewpew.customizable_entity_set_mesh(textentity,"/dynamic/text_mesh.lua",0)
        pewpew.customizable_entity_set_string(textentity, "#ff0044ff DOUBLE SWIPE") 
        pewpew.customizable_entity_start_spawning(textentity, 15)
  
        local opacity = 0xff0044ff
        local z = 10fx
        local function fade()
          time = time + 1
          if opacity > 0xff004401 then
            opacity = opacity - 3
          end
          z = z + 9fx
          pewpew.customizable_entity_set_string(textentity, ColorToString(opacity) .. "DOUBLE SWIPE")
          pewpew.customizable_entity_set_mesh_z(textentity, z)
          if time > 150 then
            pewpew.customizable_entity_start_exploding(textentity, 2)
          end
        end
        pewpew.entity_set_update_callback(textentity, fade)
        
      end, 400
    )
    return box
      
end

function power_ups.shieldmake(x,y)


        local box = boxes.new(x, y, outershield, innershield,
        function(entity_id,player_ship, entity_ship)
            local time = 0
            local config = pewpew.get_player_configuration(player_ship)
            pewpew.configure_player(0, {shield = config["shield"]+1})
            pewpew.play_ambient_sound("/dynamic/sounds.lua", 5)

            local textentity = pewpew.new_customizable_entity(x,y)
            pewpew.customizable_entity_set_mesh(textentity,"/dynamic/text_mesh.lua",0)
            pewpew.customizable_entity_set_string(textentity, "#ffff00ff Shield +1")
            
            pewpew.customizable_entity_start_spawning(textentity, 15)
            local opacity = 0xffff00ff
            local z = 10fx
            local function fade()
                time = time + 1
                if opacity > 0xffff0001 then
                opacity = opacity - 3
                end
                z = z + 9fx
                pewpew.customizable_entity_set_string(textentity, ColorToString(opacity) .. "Shield +1")
                pewpew.customizable_entity_set_mesh_z(textentity, z)
                if time > 150 then
                pewpew.customizable_entity_start_exploding(textentity, 2)
                end
            end
            pewpew.entity_set_update_callback(textentity, fade)
            
        end, 400)
        return box
        
        
end

function power_ups.invincibilitymake(x,y,game)


  local box = boxes.new(x, y, outerinvinc, innerinvinc,
  function(entity_id,player_ship, entity_ship)

      local time = 0
      pewpew.play_ambient_sound("/dynamic/sounds.lua", 6)

      if game[entity_id] then
        game[entity_id].invincibility = true
      else
        pewpew.print("Doesn't exist")
      end

      local x, y = pewpew.entity_get_position(entity_id)
      local protect_entity = pewpew.new_customizable_entity(x,y)
      pewpew.customizable_entity_set_mesh(protect_entity,"/dynamic/entity_meshes.lua",0)
      pewpew.customizable_entity_set_position_interpolation(protect_entity, true)
      local angle = 0fx
      local time = 0
      pewpew.entity_set_update_callback(protect_entity, function()
        local x, y = pewpew.entity_get_position(entity_id)
        pewpew.entity_set_position(protect_entity, x, y)
        pewpew.customizable_entity_set_mesh_angle(protect_entity, angle, 1fx, fmath.tau()/6fx, fmath.tau()/12fx)
        angle = angle + fmath.tau()/20fx
        time = time + 1
        if time == 15*30 then
          if game[entity_id] then
            game[entity_id].invincibility = false
          else
            pewpew.print("Doesn't exist")
          end
          pewpew.customizable_entity_start_exploding(protect_entity, 60)
        end
      end)

      local textentity = pewpew.new_customizable_entity(x,y)
      pewpew.customizable_entity_set_mesh(textentity,"/dynamic/text_mesh.lua",0)
      pewpew.customizable_entity_set_string(textentity, "#f542ddff INVINCIBILITY")
      
      pewpew.customizable_entity_start_spawning(textentity, 15)
      local opacity = 0xf542ddff
      local z = 10fx
      local function fade()
          time = time + 1
          if opacity > 0xf542dd01 then
          opacity = opacity - 3
          end
          z = z + 9fx
          pewpew.customizable_entity_set_string(textentity, ColorToString(opacity) .. "INVINCIBILITY")
          pewpew.customizable_entity_set_mesh_z(textentity, z)
          if time > 150 then
          pewpew.customizable_entity_start_exploding(textentity, 2)
          end
      end
      pewpew.entity_set_update_callback(textentity, fade)
      
  end, 400)
  return box
  
  
end

function power_ups.multipliermake(x,y,game)


  local box = boxes.new(x, y, outermult, innermult,
  function(entity_id,player_ship, entity_ship)
      local time = 0
      local config = pewpew.get_player_configuration(player_ship)
      game[entity_id].multiplier = game[entity_id].multiplier + 1
      pewpew.play_ambient_sound("/dynamic/sounds.lua", 5)

      local textentity = pewpew.new_customizable_entity(x,y+40fx)
      pewpew.customizable_entity_set_mesh(textentity,"/dynamic/text_mesh.lua",0)
      pewpew.customizable_entity_set_string(textentity, "#03f4fcff Score")
      local textentity2 = pewpew.new_customizable_entity(x,y)
      pewpew.customizable_entity_set_mesh(textentity2,"/dynamic/text_mesh.lua",0)
      pewpew.customizable_entity_set_string(textentity2, "#03f4fcff Multiplier +1")
      
      pewpew.customizable_entity_start_spawning(textentity, 15)
      local opacity = 0x03f4fcff
      local z = 10fx
      local function fade()
          time = time + 1
          if opacity > 0x03f4fc01 then
          opacity = opacity - 3
          end
          z = z + 9fx
          pewpew.customizable_entity_set_string(textentity, ColorToString(opacity) .. "Scpre")
          pewpew.customizable_entity_set_mesh_z(textentity, z)
          pewpew.customizable_entity_set_string(textentity2, ColorToString(opacity) .. "Multiplier +1")
          pewpew.customizable_entity_set_mesh_z(textentity2, z)
          if time > 150 then
          pewpew.customizable_entity_start_exploding(textentity, 2)
          end
      end
      pewpew.entity_set_update_callback(textentity, fade)
      
  end, 400)
  return box
  
  
end

return power_ups