-- eskiv boxes, created by tasty kiwi

local boxes = require("/dynamic/blindness_boxes/box_template.lua")

local blindness_boxes = {}

-- @param pos_x fixedpoint: The x location of the box.
-- @param pos_y fixedpoint: The y location of the box.
-- @param seconds int: Starting time for the counter.
-- @param stops_at int: Stopping time for the counter. Pass nil to remove stopping time limit.
-- @param callback function: The callback called when the ship of a player takes a box. Receives in argument the time delta.

function blindness_boxes.create_box(pos_x, pos_y, expiration, ship, callback)
  local is_box_caught = false
  local counter = pewpew.new_customizable_entity(pos_x, pos_y - 30fx)

  pewpew.customizable_entity_set_mesh_scale(counter, 1fx/2fx)
  local box = boxes.new(pos_x, pos_y, expiration, {"/dynamic/blindness_boxes/box_gfx.lua", 0} --[[ <- outer box mesh; inner box mesh -> ]], {"/dynamic/blindness_boxes/box_gfx.lua", 1}, function(player_index, ship_id)
    is_box_caught = true
    pewpew.entity_destroy(counter)
    -- you can change sound path and index if you plan to use different sound
    pewpew.play_sound("/dynamic/blindness_boxes/box_sfx.lua", 0, pos_x, pos_y)
    callback(player_index, ship_id)
  end)
  pewpew.add_arrow_to_player_ship(ship, box.handle, 0xffffff15)
end

return blindness_boxes
