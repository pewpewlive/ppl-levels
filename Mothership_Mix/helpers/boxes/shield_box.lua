local box = require("/dynamic/helpers/boxes/box_template.lua")
local floating_message = require("/dynamic/helpers/floating_message.lua")
local player_helpers = require("/dynamic/helpers/player_helpers.lua")

local shield_box = {}

function shield_box.new(x, y, resurrection_weapon_config)
  local b = box.new(x, y, {"/dynamic/helpers/boxes/box_graphics.lua", 0}, {"/dynamic/helpers/boxes/inner_box_graphics.lua", 0}, function(player_id, ship_id)
    pewpew.play_sound("/dynamic/helpers/boxes/shield_pickup_sound.lua", 0, x, y)
    pewpew.create_explosion(x, y, 0xffff00ff, 0.4000fx, 40)

    local conf = pewpew.get_player_configuration(player_id)
    pewpew.configure_player(player_id, {shield = conf.shield + 1})
    -- local new_message = floating_message.new(x, y, "Shield +1", 1.5, 0xffff00ff, 3)
  end, 400)
end

return shield_box
