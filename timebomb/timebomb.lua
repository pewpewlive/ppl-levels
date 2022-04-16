local floating_message = require("/dynamic/helpers/floating_message.lua")
local player_helpers = require("/dynamic/helpers/player_helpers.lua")
local boxes = require("/dynamic/helpers/boxes/box_template.lua")

local boxs = {}



function timebomb(x,y)
  local counter = pewpew.new_customizable_entity(x, y - 25fx)
  pewpew.customizable_entity_set_mesh_scale(counter, 1fx/2fx)
  local box_outer_mesh_info = {"/dynamic/box_graphics.lua", 0}
  local box_inner_mesh_info = {"/dynamic/box_graphics.lua", 1}
  local center = pewpew.new_customizable_entity(x, y)
  local timer = 0
  local seconds = 10

  local box = boxes.new(x, y, box_outer_mesh_info, box_inner_mesh_info, function(player_id, ship_id)
    pewpew.customizable_entity_start_exploding(counter, 1)
    pewpew.customizable_entity_start_exploding(center, 1)
    pewpew.create_explosion(x, y, 0x00ff00ff, 2.2048fx, 100)
    pewpew.increase_score_of_player(0,seconds*5)
  end)
  player_helpers.add_arrow(center, 0x00ff00ff)

  local time = 0
  pewpew.add_update_callback(
      function()
        if pewpew.entity_get_is_alive(center) and pewpew.entity_get_is_alive(counter) then
            time = time + 1
            if time % 30 == 0 and seconds > 0 then
             seconds = seconds - 1
           end
           pewpew.customizable_entity_set_string(counter, seconds)
            if seconds == 0 then
              player_helpers.deal_damage_to_player(100)
              timer = timer + 1
              if timer == 1 then
              pewpew.create_explosion(x, y, 0xff0000ff, 10fx, 25000)
              end
            end

        end
      end)
end

return boxs
